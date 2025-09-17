FROM python:3.10-slim

ENV DEBIAN_FRONTEND=noninteractive

# Install system dependencies and Node.js 19
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    curl \
    ffmpeg \
    gnupg \
    ca-certificates && \
    # Install Node.js using the official NodeSource script
    curl -fsSL https://deb.nodesource.com/setup_19.x | bash - && \
    apt-get install -y --no-install-recommends nodejs && \
    # Clean up
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

WORKDIR /app
COPY . /app/

RUN pip3 install --no-cache-dir -U -r requirements.txt

CMD ["bash", "start"]
