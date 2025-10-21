# Dockerfile - recommended: simple node run, Debian bookworm (supported)
FROM node:20-bookworm

# noninteractive apt
ENV DEBIAN_FRONTEND=noninteractive

WORKDIR /app

# copy package.json first for caching
COPY package*.json ./

# update & install native deps
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
      ffmpeg \
      imagemagick \
      webp && \
    apt-get upgrade -y && \
    rm -rf /var/lib/apt/lists/*

# install node deps
RUN npm ci --production || npm install

# copy app files
COPY . .

# (optional) expose port so hosts can detect it
EXPOSE 3000

# run directly (no PM2)
CMD ["node", "index.js"]
