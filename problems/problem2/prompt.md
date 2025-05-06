
# 🦙 Problem 2: Create Your Own Customized LLM

In this exercise, you'll personalize your own local language model by modifying a `Modelfile` and using `ollama create` to generate a custom model.

---

## 🔧 Steps to Complete:

1. Open the provided `Modelfile` in the project.

2. Edit it to include the following personalized details:
   - **Name**: `"Mario"`
   - **Favorite food**: `"Lasagna"`
   - **Favorite color**: `"Red"`

3. Use the [`ollama create`](https://github.com/ollama/ollama/blob/main/docs/modelfile.md#create-a-model) command to generate your custom model locally:

   ```bash
   ollama create mario-model -f problems/problem2/Modelfile
   ```

4. Verify that the `student_code.py` script uses your new model name in the API payload:

   ```python
   "model": "mario-model"
   ```

5. ⚠️ **Important Note**: The current `student_code.py` includes a hardcoded system prompt. This will override your customized model's built-in behavior and cause the tests to fail.

   👉 **To fix this**, either:
   - Comment out or delete the `"system"` message from the `messages` list in `student_code.py`.
   - Or adjust it to be empty like: `{"role": "system", "content": ""}`

6. Run the tests to validate your model:

   ```bash
   pytest -k test_problem2.py
   ```

7. Use `expected_output.txt` to confirm that your model's answers match the expected output.

---

### 💡 Hint

Ollama’s `Modelfile` lets you bake your own system prompt directly into the model. Once created, your custom model will always respond with the baked-in answers — unless overridden by an explicit system prompt in your code.

Make sure your Python code **lets the model speak for itself**.
