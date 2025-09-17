FROM node:18-slim as node-base

FROM python:3.10-slim

ENV DEBIAN_FRONTEND=noninteractive
ENV GIT_PYTHON_REFRESH=quiet

# Copy Node.js from the node base image
COPY --from=node-base /usr/local/bin/node /usr/local/bin/node
COPY --from=node-base /usr/local/bin/npm /usr/local/bin/npm
COPY --from=node-base /usr/local/bin/npx /usr/local/bin/npx
COPY --from=node-base /usr/local/lib/node_modules /usr/local/lib/node_modules

# Install ffmpeg and other system dependencies
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    ffmpeg \
    git \
    && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

WORKDIR /app
COPY . /app/

RUN pip3 install --no-cache-dir -U -r requirements.txt

CMD ["bash", "start"]
