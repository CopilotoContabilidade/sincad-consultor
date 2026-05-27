FROM python:3.11-slim

RUN apt-get update && apt-get install -y \
    wget gnupg curl ca-certificates \
    && wget -q -O /usr/share/keyrings/google-chrome.gpg \
       https://dl-ssl.google.com/linux/linux_signing_key.pub \
    && echo "deb [arch=amd64 signed-by=/usr/share/keyrings/google-chrome.gpg] \
       http://dl.google.com/linux/chrome/deb/ stable main" \
       > /etc/apt/sources.list.d/google-chrome.list \
    && apt-get update \
    && apt-get install -y google-chrome-stable \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

WORKDIR /app
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

COPY . .

EXPOSE 5000
CMD ["python", "app.py"]
