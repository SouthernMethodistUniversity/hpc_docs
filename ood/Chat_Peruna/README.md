# Simple Chatbot using Gradio

Based on https://github.com/WFU-HPC/OOD-GradioApps

## Requirements

### Python environment

The main requirements are:

 - `gradio` (for the app interface)
 - `llama_cpp_python` (to run the models)
 - `openai` (for the OpenAI API calls used in running models)

Some of these, particularly `llama_cpp_python` should be compiled to
utilize available resources appropriately (e.g. GPUs). 
See `build_env.sh` for a simple, compatible environment

### Models

Users are responsible for acquiring or creating their own models.
At present, they are required to be compatible with the OpenAI API.

## TODO ITEMS

- Update Deprecated ChatOllama to use new package

```
Chat_Peruna_Memory.py:33: LangChainDeprecationWarning: The class `ChatOllama` was deprecated in LangChain 0.3.1 and will be removed in 1.0.0. An updated version of the class exists in the :class:`~langchain-ollama package and should be used instead. To use it run `pip install -U :class:`~langchain-ollama` and import as `from :class:`~langchain_ollama import ChatOllama``.
  chat_model = ChatOllama(
```

- Update tuples and stucture

```
Chat_Peruna_Memory.py:139: UserWarning: You have not specified a value for the `type` parameter. Defaulting to the 'tuples' format for chatbot messages, but this is deprecated and will be removed in a future version of Gradio. Please set type='messages' instead, which uses openai-style dictionaries with 'role' and 'content' keys.
  chatbot = gr.Chatbot(
```