import json
import requests


def ask_ollama(prompt):
    url = "http://localhost:11434/api/chat"
    headers = {
        'accept': 'application/json',
        'Content-Type': 'application/json'
    }
    model = "qwen3:0.6b" # UPDATE TO YOUR MODEL
    system_name = "mario" # CHANGE
    system_favorite_food = "lasagna" # CHANGE
    system_favorite_color = "red" # CHANGE
    system_prompt = f"""
    Your name is {system_name}.
    Your favorite food is {system_favorite_food}.
    Your favorite color is {system_favorite_color}.
    """

    payload = {
        "model": model,
        "messages": [
            {"role": "system", "content": system_prompt},
            {"role": "user", "content": prompt}
        ]
    }

    response = requests.post(url, headers=headers, json=payload, stream=True)

    # Assemble the streamed content
    result = ""
    for line in response.iter_lines():
        if line:
            data = json.loads(line.decode("utf-8"))
            result += data.get("message", {}).get("content", "")

    return result.strip()

