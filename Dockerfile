FROM python:3.10-slim

ENV DEBIAN_FRONTEND=noninteractive
ENV GIT_PYTHON_REFRESH=quiet

# Install system dependencies and Node.js 18 (LTS)
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    curl \
    ffmpeg \
    git \  # Added git for GitPython
    gnupg \
    ca-certificates && \
    # Add Node.js 18 repository
    mkdir -p /etc/apt/keyrings && \
    curl -fsSL https://deb.nodesource.com/gpgkey/nodesource-repo.gpg.key | gpg --dearmor -o /etc/apt/keyrings/nodesource.gpg && \
    echo "deb [signed-by=/etc/apt/keyrings/nodesource.gpg] https://deb.nodesource.com/node_18.x nodistro main" > /etc/apt/sources.list.d/nodesource.list && \
    apt-get update && \
    apt-get install -y --no-install-recommends nodejs && \
    # Clean up
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

WORKDIR /app
COPY . /app/

RUN pip3 install --no-cache-dir -U -r requirements.txt

CMD ["bash", "start"]
