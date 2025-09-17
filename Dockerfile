FROM python:3.10-slim

ENV DEBIAN_FRONTEND=noninteractive

# Install Node.js 19 + ffmpeg
RUN apt-get update && apt-get install -y curl ffmpeg gnupg && \
    curl -fsSL https://deb.nodesource.com/setup_19.x | bash - && \
    apt-get install -y nodejs && \
    rm -rf /var/lib/apt/lists/*

WORKDIR /app
COPY . /app/

RUN pip3 install --no-cache-dir -U -r requirements.txt

CMD ["bash", "start"]
