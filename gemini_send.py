import sys
import os
import google.generativeai as genai

# Get key from environment variable
api_key = os.environ.get("GOOGLE_API_KEY")

# Configure Gemini
genai.configure(api_key=api_key)


#for m in genai.list_models():
#    print(m.name, m.supported_generation_methods)

#prompt = sys.stdin.read()
user_input = sys.stdin.read().strip()
prompt = "請用台灣常用的繁體中文回答以下問題：\n" + user_input

model = genai.GenerativeModel('gemini-2.5-pro')
response = model.generate_content(prompt)
print(response.text)
