import sys
import google.generativeai as genai

genai.configure(api_key="KEY")


#for m in genai.list_models():
#    print(m.name, m.supported_generation_methods)

prompt = sys.stdin.read()
model = genai.GenerativeModel('gemini-2.5-pro')
response = model.generate_content(prompt)
print(response.text)
