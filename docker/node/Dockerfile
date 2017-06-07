#node
FROM node:latest

RUN npm install gulp-cli bower npm-check-updates -g \
  && npm -v \
  && gulp -v \
  && bower -v

RUN apt-get update \
  && apt-get clean \
  && yarn -v

WORKDIR /var/www/html
