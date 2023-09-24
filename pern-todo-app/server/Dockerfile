FROM node:alpine

WORKDIR /app
COPY ./package*.json ./

RUN npm ci

COPY . .
ENTRYPOINT [ "node", "index.js" ]
