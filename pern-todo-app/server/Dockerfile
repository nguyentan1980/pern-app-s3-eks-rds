FROM node:alpine

WORKDIR /app

RUN apk --update add postgresql-client 

COPY ./package*.json ./

RUN npm ci

COPY . .
ENTRYPOINT [ "node", "index.js" ]
