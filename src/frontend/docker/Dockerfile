ARG NODEJS_VERSION=16.13.0

FROM node:${NODEJS_VERSION}-buster-slim

WORKDIR /opt/app

COPY ["./src/frontend/package.json", "./src/frontend/package-lock.json*", "./"]

RUN npm install --include=dev && npm install -g parcel@2.0.0-beta.2

COPY ["./src/frontend/bundles-src/", "./bundles-src/"]

RUN parcel build bundles-src/index.js --dist-dir bundles --public-url="./"
