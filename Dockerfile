FROM node:lts-buster

# Use Debian archive mirrors since buster is deprecated
RUN sed -i 's|deb.debian.org|archive.debian.org|g' /etc/apt/sources.list && \
    sed -i '/security.debian.org/d' /etc/apt/sources.list

RUN apt-get update && \
  apt-get install -y \
  ffmpeg \
  imagemagick \
  webp && \
  apt-get upgrade -y && \
  rm -rf /var/lib/apt/lists/*

COPY package.json .

RUN npm install && npm install -g qrcode-terminal pm2

COPY . .

EXPOSE 3000

CMD ["pm2-runtime", "start", "index.js"]
