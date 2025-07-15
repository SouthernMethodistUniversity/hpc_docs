import gradio as gr
import os
import subprocess
from langchain_community.chat_models import ChatOllama

# Global variables
chat_model = None

def start_ollama():
    """Execute the ollama serve command in the background"""
    try:
        # Execute the command in the background
        process = subprocess.Popen(
            ["/projects/egodat/smugpt/models/models/Ollama/bin/ollama", "serve"], 
            stdout=subprocess.DEVNULL, 
            stderr=subprocess.DEVNULL,
            preexec_fn=os.setsid  # Start in new process group
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
            base_url="http://localhost:11434", 
            model=model_name, 
            temperature=temperature
        )
        return f"✅ Chat model '{model_name}' initialized successfully with temperature {temperature}"
    except Exception as e:
        return f"❗ Error initializing chat model: {str(e)}"

def chat_with_model(user_input, chat_history, model_name, temperature):
    """
    Process user input and generate response using the selected LLM.
    
    Args:
        user_input: User's message
        chat_history: Current chat history
        model_name: Selected model name
        temperature: Temperature setting
    
    Returns:
        Updated chat history
    """
    if not user_input.strip():
        return chat_history, chat_history
    
    try:
        # Initialize or update model if needed
        global chat_model
        if chat_model is None:
            chat_model = ChatOllama(
                base_url="http://localhost:11434", 
                model=model_name, 
                temperature=temperature
            )
        
        print(f"Processing message: {user_input}")
        
        # Generate response using the chat model
        response = chat_model.invoke(user_input)
        
        # Extract content from response
        if hasattr(response, 'content'):
            bot_response = response.content
        else:
            bot_response = str(response)
        
        print(f"Generated response: {bot_response[:100] if bot_response else 'No response'}...")
        
        # Add to chat history
        chat_history.append((user_input, bot_response))
        
    except Exception as e:
        error_response = f"❗ Error generating response: {str(e)}"
        print(f"Error in chat_with_model: {str(e)}")
        chat_history.append((user_input, error_response))
    
    return chat_history, chat_history

def create_interface():
    """Create and return the Gradio interface."""
    
    with gr.Blocks(
        title="🐴 Peruna Simple Chatbot",
        theme=gr.themes.Soft(),
        css="""
        .gradio-container {
            max-width: 1800px !important;
        }
        """
    ) as demo:
        
        gr.Markdown("# 🐴 Peruna Simple Chatbot")
        gr.Markdown("Chat with advanced AI models powered by Ollama.")

        with gr.Row():
            # Left Column - Controls and Settings
            with gr.Column(scale=1):

                # Start Ollama Server Button
                start_button = gr.Button("Start Ollama Server")
                output_box = gr.Textbox(label="", interactive=False)
                start_button.click(fn=start_ollama, outputs=output_box)

                # Settings
                gr.Markdown("### ⚙️ Settings")
                
                # Language Model
                model_dropdown = gr.Dropdown(
                    choices=["gemma3:27b","gemma3:12b","qwen3:32b","qwen3:14b","llama3-chatqa:8b","deepseek-r1:32b","deepseek-r1:14b","mistral:7b","phi3:14b"], 
                    value="gemma3:27b", 
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
                
                # Logo display
                gr.Image(
                    value="./pony.jpeg", 
                    label="🐴 Peruna",
                    show_label=True,
                    height=200,
                    width=200
                )

            # Right Column - Chat Interface
            with gr.Column(scale=4):

                # Chat Interface Title
                gr.Markdown("### 💬 Chat Interface")
                
                # Chatbot - Main Chat Interface
                chatbot = gr.Chatbot(
                    show_label=False,
                    height=500,
                    bubble_full_width=False,
                    avatar_images=(None, "./pony.jpeg")
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
                    clear_btn = gr.Button("🗑️ Clear Chat", variant="secondary")
                    send_btn = gr.Button("📤 Send", variant="primary")

        # State variables
        history_state = gr.State([])

        # Event handlers
        def clear_chat():
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

        # Handle message submission (Enter key)
        def handle_submit(user_input, chat_history, model_name, temperature):
            print(f"Submit triggered with input: '{user_input}'")
            if user_input.strip():  # Only process non-empty messages
                return chat_with_model(user_input, chat_history, model_name, temperature)
            return chat_history, chat_history
        
        msg.submit(
            handle_submit,
            inputs=[msg, history_state, model_dropdown, temp_slider], 
            outputs=[chatbot, history_state]
        ).then(
            lambda: "", 
            outputs=msg
        )

        # Handle send button click
        send_btn.click(
            handle_submit,
            inputs=[msg, history_state, model_dropdown, temp_slider], 
            outputs=[chatbot, history_state]
        ).then(
            lambda: "", 
            outputs=msg
        )

        # Clear chat history
        clear_btn.click(
            clear_chat,
            outputs=[chatbot, history_state]
        )

    return demo

# Main Execution
if __name__ == "__main__":
    # Create and launch the interface
    demo = create_interface()
    
    print("🐴 Starting Simple Chatbot...")
    print("📋 Make sure Ollama is running on localhost:11434")
    print("💬 Select your model and start chatting!")
    
    try:
        demo.launch()
        
    except KeyboardInterrupt:
        print("\n🛑 Shutting down gracefully...")
    except Exception as e:
        print(f"Error during launch: {e}") 