FROM node:20-slim

RUN apt-get update && apt-get install -y --no-install-recommends \
    wget \
    ca-certificates \
  && rm -rf /var/lib/apt/lists/*

WORKDIR /app

COPY package*.json ./
RUN npm ci --omit=dev

COPY . .
RUN mkdir -p downloads public/sites

ENV NODE_ENV=production
EXPOSE 3000

CMD ["npm", "start"]
