# syntax = docker/dockerfile:1.0-experimental
FROM node:16-alpine as build

RUN apk add --no-cache bash curl && \
  curl -L -o elm.gz https://github.com/elm/compiler/releases/download/0.19.1/binary-for-linux-64-bit.gz && \
  gunzip elm.gz && \
  chmod +x elm && \
  mv elm /usr/local/bin/ && \
  npm i -g elm-live uglify-js

WORKDIR /app

COPY build.sh .
COPY index.html .

ENTRYPOINT ["elm-live"]

CMD ["/app/src/Main.elm", "--hot", "--pushstate", "--host=0.0.0.0", "--", "--output=index.js", "--debug"]