FROM nikolaik/python-nodejs:python3.10-nodejs19

# Ensure noninteractive to avoid tzdata prompts
ENV DEBIAN_FRONTEND=noninteractive

# Update & install ffmpeg safely
RUN apt-get update && \
    apt-get install -y --no-install-recommends ffmpeg && \
    rm -rf /var/lib/apt/lists/*

# Copy app
WORKDIR /app
COPY . /app/

# Install Python deps
RUN pip3 install --no-cache-dir -U -r requirements.txt

CMD ["bash", "start"]
