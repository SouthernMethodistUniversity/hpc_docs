import gradio as gr
import os
import subprocess
from langchain_community.chat_models import ChatOllama
from collections import deque

# Global variables
chat_model = None
conversation_memory = deque(maxlen=20)  # Store last 20 interactions

def start_ollama():
    """Execute the ollama serve command in the background"""
    try:
        # Execute the command in the background
        my_env = os.environ.copy()
        process = subprocess.Popen(
            ["/projects/egodat/smugpt/models/models/Ollama/bin/ollama", "serve"], 
            stdout=subprocess.DEVNULL, 
            stderr=subprocess.DEVNULL,
            preexec_fn=os.setsid,
            env=my_env
        )
        return f"Ollama server started successfully! Process ID: {process.pid}"
    except FileNotFoundError:
        return "Error: 'ollama' command not found. Please ensure Ollama is installed and in your PATH."
    except Exception as e:
        return f"Error starting Ollama server: {str(e)}"

def setup_chat_model(model_name, temperature):
    """Initialize the chat model with selected parameters."""
    global chat_model
    try:
        chat_model = ChatOllama(
            base_url=f"http://{os.environ.get('OLLAMA_HOST')}",
            model=model_name, 
            temperature=temperature
        )
        return f"✅ Chat model '{model_name}' initialized successfully with temperature {temperature}"
    except Exception as e:
        return f"❗ Error initializing chat model: {str(e)}"

def build_context_prompt(user_input):
    """
    Build a context-aware prompt using conversation memory.
    
    Args:
        user_input: Current user message
    
    Returns:
        Enhanced prompt with conversation context
    """
    if not conversation_memory:
        # No previous context
        return user_input
    
    # Build context from memory
    context_parts = ["Based on our previous conversation:"]
    
    for i, (prev_user, prev_bot) in enumerate(conversation_memory, 1):
        context_parts.append(f"Exchange {i}:")
        context_parts.append(f"Human: {prev_user}")
        context_parts.append(f"Assistant: {prev_bot}")
        context_parts.append("")  # Empty line for readability
    
    context_parts.extend([
        "Current question:",
        f"Human: {user_input}",
        "",
        "Please respond considering the conversation history above. Remember any important information like names, preferences, or context that was mentioned."
    ])
    
    return "\n".join(context_parts)



def create_interface():
    """Create and return the Gradio interface."""
    
    with gr.Blocks(
        title="🐴 Peruna Memory Chatbot",
        theme=gr.themes.Soft(),
        css="""
        .gradio-container {
            max-width: 1800px !important;
            font-family: 'Arial', serif;
        }
        """
    ) as demo:
        
        gr.Markdown("# 🐴 Peruna Memory Chatbot")
        #gr.Markdown("Advanced AI chatbot!")

        with gr.Row():
            # Left Column - Controls and Settings
            with gr.Column(scale=1):

                # Start Ollama Server Button
                #start_button = gr.Button("Start Ollama Server")
                #output_box = gr.Textbox(label="", interactive=False)
                #start_button.click(fn=start_ollama, outputs=output_box)

                # Settings
                #gr.Markdown("### ⚙️ Model Settings")
                
                # Language Model
                model_dropdown = gr.Dropdown(
                    choices=["gemma3:27b","gemma3:12b","llama3-chatqa:8b","mistral:7b","phi3:14b"], 
                    value=None, 
                    label="🤖 Language Model",
                    info="Select the AI model for generating responses"
                )
                
                # Temperature
                temp_slider = gr.Slider(
                    minimum=0.0, 
                    maximum=1.0, 
                    value=0.5, 
                    step=0.01, 
                    label="🌡️ Temperature",
                    info="Controls randomness: 0=focused, 1=creative"
                )
                
                # Model Status
                model_status = gr.Textbox(
                    label="📊 Model Status",
                    interactive=False,
                    visible=True,
                    value="Select model settings and start chatting!",
                    lines=2
                )

            # Right Column - Chat Interface
            with gr.Column(scale=4):

                # Chat Interface Title
                #gr.Markdown("### 💬 Chat Interface")
                
                # Chatbot - Main Chat Interface
                chatbot = gr.Chatbot(
                    show_label=True,
                    label="Chat",
                    height=500,
                    avatar_images=(None, "./icon.png")
                )
                
                # Message Input
                msg = gr.Textbox(
                    placeholder="Type your message here... (Press Enter to send)", 
                    label="💭 Your Message (Press Enter to send)", 
                    interactive=True,
                    lines=1,
                    max_lines=3
                )
                
                with gr.Row():
                    clear_btn = gr.Button("🗑️ Clear Chat Display", variant="secondary")
                    send_btn = gr.Button("📤 Send", variant="primary")

        # State variables
        history_state = gr.State([])

        # Event handlers
        def clear_chat():
            """Clear only the visual chat display, not the memory."""
            return [], []

        def update_model_status(model_name, temperature):
            return setup_chat_model(model_name, temperature)

        # Update model when settings change
        model_dropdown.change(
            update_model_status,
            inputs=[model_dropdown, temp_slider],
            outputs=[model_status]
        )
        
        temp_slider.change(
            update_model_status,
            inputs=[model_dropdown, temp_slider],
            outputs=[model_status]
        )

        def add_user_message(user_input, chat_history, model_name):
            if not model_name:
                # Return error immediately — without letting it go to generate_bot_response
                chat_history.append((user_input, "❗ Please select a language model before chatting."))
                return gr.update(visible=True), chat_history, chat_history
            else:
                chat_history.append((user_input, None))
                return gr.update(visible=True), chat_history, chat_history

        def generate_bot_response(chat_history, model_name, temperature):

            if not chat_history:
                return chat_history, chat_history

            if not model_name:
                # Return error immediately — without letting it go to generate_bot_response
                #chat_history.append((user_input, "❗ Please select a language model before chatting."))
                return chat_history, chat_history

            user_input = chat_history[-1][0]  # Get last user message

            try:
                response = chat_model.invoke(build_context_prompt(user_input))

                bot_response = response.content if hasattr(response, "content") else str(response)
                conversation_memory.append((user_input, bot_response))

                # Update last entry with bot response
                chat_history[-1] = (user_input, bot_response)
            except Exception as e:
                error_response = f"❗ Error: {str(e)}"
                chat_history[-1] = (user_input, error_response)

            return chat_history, chat_history
        
        msg.submit(
            add_user_message,
            inputs=[msg, history_state, model_dropdown],
            outputs=[model_status, chatbot, history_state]
        ).then(
            generate_bot_response,
            inputs=[history_state, model_dropdown, temp_slider],
            outputs=[chatbot, history_state]
        ).then(
            lambda: "",
            outputs=msg
        )

        send_btn.click(
            add_user_message,
            inputs=[msg, history_state, model_dropdown],
            outputs=[model_status, chatbot, history_state]
        ).then(
            generate_bot_response,
            inputs=[history_state, model_dropdown, temp_slider],
            outputs=[chatbot, history_state]
        ).then(
            lambda: "",
            outputs=msg
        )

        # Clear chat history (display only)
        clear_btn.click(
            clear_chat,
            outputs=[chatbot, history_state]
        )

    return demo

# Main Execution
if __name__ == "__main__":
    print("🐴 Starting Memory-Enhanced Chatbot...")
    print("🧠 Memory system active - remembers last 20 interactions!")
    print("💬 Select your model and start chatting!")

    # Ensure Ollama is started BEFORE Gradio runs
    ollama_status_msg = start_ollama()
    print(ollama_status_msg)

    try:
        demo = create_interface()
        demo.launch()
        default_model = "gemma3:27b"
        default_temp = 0.5
        init_status = setup_chat_model(default_model, default_temp)
    except KeyboardInterrupt:
        print("\n🛑 Shutting down gracefully...")
    except Exception as e:
        print(f"Error during launch: {e}")