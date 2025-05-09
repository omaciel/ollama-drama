import json
import requests


def ask_ollama(prompt):
    url = "http://localhost:11434/api/chat"
    headers = {"accept": "application/json", "Content-Type": "application/json"}
    model = "helen-model"  # UPDATE TO YOUR MODEL
    # system_prompt = "You are a helpful LLM."

    payload = {
        "model": model,
        "messages": [
            # Hmmm... should this line be here?
            # {"role": "system", "content": system_prompt},
            {"role": "user", "content": prompt},
        ],
    }

    response = requests.post(url, headers=headers, json=payload, stream=True)

    # Assemble the streamed content
    result = ""
    for line in response.iter_lines():
        if line:
            data = json.loads(line.decode("utf-8"))
            result += data.get("message", {}).get("content", "")
    return result.strip()


if __name__ == "__main__":
    response = ask_ollama("Who are you?")
    print(response)

# Excellent response: "I'm a friendly AI assistant, and I don't have a personal name. However, it seems like we've established that you're Helen, and I'm here to chat with you about your interests, including pizza and teal! How's your day going so far?"
