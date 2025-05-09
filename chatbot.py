import json
import requests
import gradio as gr

# Ollama local API endpoint
api = "http://localhost:11434/api/chat"


def greet(query):
    headers = {"accept": "application/json", "Content-Type": "application/json"}

    payload = {
        "model": "qwen3:0.6b",  # Adjust if you're using another local model
        "messages": [
            {"role": "system", "content": "You are a helpful assistant."},
            {"role": "user", "content": query},
        ],
    }

    response = requests.post(api, headers=headers, json=payload, stream=True)

    result = ""
    try:
        for line in response.iter_lines():
            if line:
                data = json.loads(line.decode("utf-8"))
                message = data.get("message", {}).get("content", "")
                result += message
    except Exception as e:
        return f"❌ Error: {e}\n\nRaw response:\n{response.text if 'response' in locals() else ''}"

    return result


# Gradio interface
demo = gr.Interface(
    fn=greet,
    inputs=gr.Textbox(label="Ask something..."),
    outputs=gr.Textbox(label="Ollama Drama says:"),
    title="🐑 Ollama Drama Chatbot",
    description="Talk to your local llama! Powered by Ollama running locally.",
)

demo.launch()
