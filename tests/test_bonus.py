import pytest
import requests

user_name = "YOUR_OLLAMA_USERNAME"
model_name = "MODEL_NAME"

# Test that the custom model exists on Ollama website
def test_fetch_ollama_page():
    url = f"https://ollama.com/{user_name}/{model_name}"
    response = requests.get(url)
    assert response.status_code == 200, f"Failed to fetch Ollama page for {user_name}/{model_name}"
    assert model_name in response.text, f"Expected model name '{model_name}' not found in Ollama page."
