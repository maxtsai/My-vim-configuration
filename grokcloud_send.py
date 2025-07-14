# ~/.vim/groq_qwen_send.py

import sys
from groq import Groq

# Read prompt from stdin (used by your Vim function)
user_input = sys.stdin.read().strip()
prompt = "請用台灣常用的繁體中文回答以下問題：\n" + user_input

# Initialize Groq client (uses GROQ_API_KEY from environment if not specified here)
client = Groq()

# Call the Qwen model
completion = client.chat.completions.create(
    # or use another Groq-supported model if needed
    #model="qwen-qwq-32b",
    model="deepseek-r1-distill-llama-70b",
    messages=[
        {"role": "user", "content": prompt}
    ],
    temperature=0.6,
    max_tokens=1024,
    top_p=0.95,
    stream=True,
)

# Collect output from streaming chunks
output = ""
for chunk in completion:
    content = chunk.choices[0].delta.content
    if content:
        output += content

print(output)

