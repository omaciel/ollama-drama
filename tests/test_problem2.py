import importlib.util
import os
import pytest

name = "Mario"
favorite_food = "Lasagna"
favorite_color = "Red"

# Helper to load student_code module
def load_student_code():
    path = os.path.join('problems', 'problem2', 'student_code.py')
    spec = importlib.util.spec_from_file_location('student_code', path)
    student_code = importlib.util.module_from_spec(spec)
    spec.loader.exec_module(student_code)
    return student_code

# Parametrize test cases
@pytest.mark.parametrize("prompt, expected", [
    ("What is your name?", name),
    ("What is your favorite food?", favorite_food),
    ("What is your favorite color?", favorite_color),
])
def test_student_answers(prompt, expected):
    student_code = load_student_code()
    result = student_code.ask_ollama(prompt)
    assert isinstance(result, str)
    assert expected.lower() in result.lower()

# Check that Modelfile contains baked-in values
def test_modelfile():
    modelfile_path = os.path.join("problems", "problem2", "Modelfile")
    assert os.path.exists(modelfile_path), "Modelfile does not exist."

    with open(modelfile_path, "r") as f:
        content = f.read()

    assert name in content, f"Expected name '{name}' not found in Modelfile."
    assert favorite_food in content, f"Expected food '{favorite_food}' not found in Modelfile."
    assert favorite_color in content, f"Expected color '{favorite_color}' not found in Modelfile."
