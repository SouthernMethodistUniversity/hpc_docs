#!/usr/bin/env python3
import os
import re
import secrets
import gradio as gr
from fastapi import FastAPI, Form, Request
from fastapi.responses import HTMLResponse, RedirectResponse

# --------------------------------------------
# Ollama HPC Discovery
# --------------------------------------------
def get_ollama_url():
    job_id = os.environ.get("SLURM_JOB_ID")
    if not job_id:
        raise RuntimeError("SLURM_JOB_ID not set — must run inside a SLURM job.")

    # respect OLLAMA_BASE_DIR override
    base = os.environ.get("OLLAMA_BASE_DIR", os.path.expanduser("~"))
    base = os.path.expanduser(base)

    ollama_dir = os.path.join(base, "ollama")
    port_file = os.path.join(ollama_dir, f"port_{job_id}.txt")
    host_file = os.path.join(ollama_dir, f"host_{job_id}.txt")

    if not os.path.exists(port_file):
        raise RuntimeError(f"Missing port file {port_file}")

    if not os.path.exists(host_file):
        raise RuntimeError(f"Missing host file {host_file}")

    with open(port_file) as f:
        port = f.read().strip()

    with open(host_file) as f:
        host = f.read().strip()

    return f"http://{host}:{port}"


OLLAMA_URL = get_ollama_url()
print("📡 Using Ollama at:", OLLAMA_URL)

import requests

# --------------------------------------------
# Utility: Direct Ollama Chat
# --------------------------------------------
def ollama_chat(model, messages, temperature=0.7):
    url = f"{OLLAMA_URL}/api/chat"
    payload = {
        "model": model,
        "messages": messages,
        "options": {"temperature": temperature}
    }
    payload["stream"] = False
    resp = requests.post(url, json=payload, headers={"Content-Type": "application/json"})
    resp.raise_for_status()
    return resp.json()["message"]["content"]

# --------------------------------------------
# Utility: Ollama Embeddings
# --------------------------------------------
def ollama_embed(model, text):
    url = f"{OLLAMA_URL}/api/embeddings"
    payload = {"model": model, "prompt": text}
    payload["stream"] = False
    resp = requests.post(url, json=payload, headers={"Content-Type": "application/json"})
    resp.raise_for_status()
    return resp.json()["embedding"]

# --------------------------------------------
# Document Loaders
# --------------------------------------------
from PyPDF2 import PdfReader
import docx
from bs4 import BeautifulSoup

try:
    import pypandoc
    HAVE_PANDOC = True
except ImportError:
    HAVE_PANDOC = False

def load_text(path):
    ext = os.path.splitext(path)[1].lower()

    if ext in [".txt", ".md"]:
        return open(path, encoding="utf-8", errors="ignore").read()

    if ext == ".pdf":
        return "\n".join([p.extract_text() or "" for p in PdfReader(path).pages])

    if ext == ".docx":
        d = docx.Document(path)
        return "\n".join([p.text for p in d.paragraphs])

    if ext == ".html":
        with open(path, encoding="utf-8", errors="ignore") as f:
            return BeautifulSoup(f, "html.parser").get_text("\n")

    if ext in [".rtf", ".odt"] and HAVE_PANDOC:
        try:
            return pypandoc.convert_file(path, "plain")
        except:
            return ""

    # fallback
    try:
        return open(path, encoding="utf-8", errors="ignore").read()
    except:
        return ""

# --------------------------------------------
# Chroma Setup
# --------------------------------------------
import chromadb
CHROMA_DIR = os.environ.get("CHROMA_DIR")
if not CHROMA_DIR:
    raise RuntimeError("CHROMA_DIR not set")

CHROMA_PATH = os.path.join(CHROMA_DIR, ".chroma")
client = chromadb.PersistentClient(path=CHROMA_PATH)
collection = client.get_or_create_collection("docs")

EMBED_MODEL = os.environ.get("EMBED_MODEL", "embeddinggemma:300m")

def embed_batch(texts):
    return [ollama_embed(EMBED_MODEL, t) for t in texts]

# --------------------------------------------
# Index documents in CHROMA_DIR
# --------------------------------------------
if os.path.isdir(CHROMA_DIR):
    print("📚 Indexing documents...")
    for fname in os.listdir(CHROMA_DIR):
        path = os.path.join(CHROMA_DIR, fname)
        if not os.path.isfile(path) or ".chroma" in fname:
            continue

        text = load_text(path)
        if not text.strip():
            continue

        chunk_size = 1000
        overlap = 200
        chunks = [text[i:i + chunk_size] for i in range(0, len(text), chunk_size - overlap)]

        vectors = embed_batch(chunks)
        ids = [f"{fname}_{i}" for i in range(len(chunks))]

        collection.upsert(documents=chunks, embeddings=vectors, ids=ids)
        print(f"Indexed {fname}")

# --------------------------------------------
# RAG Query
# --------------------------------------------
def query_docs(query, k=5):
    vec = ollama_embed(EMBED_MODEL, query)
    results = collection.query(query_embeddings=[vec], n_results=k)
    if results["documents"]:
        return "\n\n".join(results["documents"][0])
    return ""

# --------------------------------------------
# Chat Logic
# --------------------------------------------
def extract_final(reply):
    m = re.search(r"<\|channel\|>final<\|message\|>(.*)", reply, re.DOTALL)
    return m.group(1).strip() if m else reply.strip()

def chat_fn(message, history):
    context = ""
    if os.environ.get("ENABLE_RAG") == "1":
        context = query_docs(message)

    messages = []
    for turn in history:
        messages.append({"role": "user", "content": turn["content"]})
        messages.append({"role": "assistant", "content": turn["content"]})

    if context:
        messages.append({"role": "system", "content": f"<document-context>\n{context}\n</document-context>"})

    messages.append({"role": "user", "content": message})

    reply = ollama_chat(os.environ.get("MODEL_NAME", "gpt-oss:20b"), messages)
    return extract_final(reply)

# --------------------------------------------
# FastAPI App (Authentication)
# --------------------------------------------
app = FastAPI()
SESSIONS = {}

@app.get("/ready")
async def ready(): return {"status": "ok"}

@app.get("/login")
async def login_page():
    return HTMLResponse("""
        <form action="/login" method="post">
            <input name="username" placeholder="Username"><br>
            <input name="password" type="password" placeholder="Password"><br>
            <button>Login</button>
        </form>
    """)

@app.post("/login")
async def login(username: str = Form(), password: str = Form()):
    if password == os.environ["password"]:
        sid = secrets.token_hex(16)
        SESSIONS[sid] = username
        r = RedirectResponse("/", 302)
        r.set_cookie("session_id", sid, httponly=True, secure=False)
        return r
    return HTMLResponse("Invalid", 401)

@app.middleware("http")
async def auth(request: Request, call_next):
    if request.url.path in ["/login", "/ready"]:
        return await call_next(request)

    sid = request.cookies.get("session_id")
    if sid not in SESSIONS:
        return RedirectResponse("/login")

    return await call_next(request)

# --------------------------------------------
# Gradio UI
# --------------------------------------------
chat_ui = gr.ChatInterface(fn=chat_fn, type="messages", title="Research Chat")
app = gr.mount_gradio_app(app, chat_ui, path="/")