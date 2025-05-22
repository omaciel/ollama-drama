# 🏆 Bonus Problem: Publish Like a Pro

You’ve built your own custom LLM. You’ve taught it your name, your favorite food, and your deep love of the color red. Now it’s time to **unleash it upon the world** and join the elite squad of LLM artisans brave enough to publish publicly.

This bonus mission celebrates the courageous few who dare to push their models beyond localhost. 💪

---

## 🛰 Step-by-Step: Launch Your Model Into the Wild

1. **Create an Ollama account**  
   Boldly go to [ollama.com](https://ollama.com) and sign up. It’s free, painless, and only slightly judgmental about your email address.

1. **Add your public key**  
   Like any good hacker, you’ll need to prove you own your machine. Paste your public key at [https://ollama.com/settings/keys](https://ollama.com/settings/keys).  

```bash
cat ~/.ollama/id_ed25519.pub
```

1. Build your masterpiece (but now with a public name!)
Give your model a proper title and your username for global fame:

```bash
ollama create <username>/mario-model -f problems/problem2/Modelfile
```

1. Push it to the big stage
Time to publish your model. Just one command:

```bash
ollama push <username>/mario-model
```

1. Once published, anyone can run:

```bash
ollama pull <username>/mario-model
```

And just like that, you’ve gone from llama herder to llama legend. 🌍🦙

⸻

✅ To validate your brilliance:

Run the following to check that your model meets the bonus criteria:

```bash
pytest -k test_bonus
```

if it fails, and it *should* 😜, edit `tests/test_bonus.py` and replace `YOUR_OLLAMA_USERNAME` with your actual username and `MODEL_NAME` with the name you chose for your model.

If it passes, you’re not just Ollama Drama certified—you’re globally available.

Welcome to the big leagues.
