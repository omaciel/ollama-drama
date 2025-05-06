# 🦙 Problem 1: Customize the LLM's System Prompt

Your task is to modify the code in `student_code.py` so that the language model responds accurately to specific personal questions.

To complete this exercise:

1. Open the file `student_code.py`.

2. Update the system prompt so the LLM can correctly answer the following questions:
   - What is your name?
   - What is your favorite food?
   - What is your favorite color?

3. Run `pytest -k test_problem1` to verify your solution.

4. Refer to `expected_output.txt` for examples of the correct responses.

✅ **Your goal**: Make the model provide the *expected* answers. The tests will check whether the LLM responds with your customized answers.

---

## 💡 Hint

The system prompt is the first message the model receives. It's like giving it instructions or background information before the user starts asking questions.

In `student_code.py`, you'll find the system prompt inside the payload for the API call. Modify the `"content"` of the `system` message to include your name, favorite food, and favorite color. For example:

```python
{"role": "system", "content": "My name is Mario. My favorite food is Lasagna. My favorite color is Red."}
