# 🦙 Ollama Drama

Welcome to **Ollama Drama**, a hands-on workshop where you'll learn to run, prompt, and customize LLMs locally using [Ollama](https://ollama.com/).

## 🎯 Goals

By the end of this workshop, you will:

- Run and interact with language models locally using the `ollama` CLI
- Use Python (`chatbot.py`) to call Ollama’s API
- Create a custom model using a `Modelfile`
- Solve programming challenges and submit them via Pull Request
- Pass automated tests triggered on GitHub

---

## 🧰 Prerequisites

Make sure you have the following installed **before** the workshop:

- Python 3.10+
- [Ollama](https://ollama.com/download) (with at least one model pulled locally, like `qwen3:0.6b`)
- Git
- A GitHub account

---

## 🚀 Getting Started

1. **Fork this repository** to your own GitHub account.
2. **Clone your fork** to your local machine:

   ```bash
   git clone https://github.com/YOUR_USERNAME/ollama-drama.git
   cd ollama-drama
   ```

3. **Install dependencies:**

   ```bash
   python3 -m venv .venv
   source ./venv/bin/activate
   pip install -r requirements.txt
   ```

---

## 🧪 Solving Problems

Each problem lives in a subfolder like:

```bash
problems/question1/
├── prompt.md            # Problem description
├── expected_output.txt  # Hints or expected structure
└── student_code.py      # This is what you edit
```

To test your solution locally:

```bash
pytest -k test_problem1
```

---

## 🛠 Example Ollama CLI Commands

- Pull a model:

  ```bash
  ollama pull qwen3:0.6b
  ```

- Run a prompt:

  ```bash
  ollama run qwen3:0.6b "What is the capital of Peru?"
  ```

- Summarize a file:

  ```bash
  ollama run qwen3:0.6b "Summarize this file: $(cat README.md)"
  ```

---

## 💬 Help & Questions

If you get stuck:

- Check your local `ollama` service: [http://localhost:11434](http://localhost:11434)
- Ask your workshop host or teammates!
- Or open a GitHub Issue if it's repo-related.

---

## 🤘 Bonus Challenges

We'll add extra challenges if you complete the first one early, including:

- Embedding generation
- RAG (retrieval-augmented generation) basics

---

Enjoy the chaos. Herd your llamas.  
**– The Ollama Drama Team**
