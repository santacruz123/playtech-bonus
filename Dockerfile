FROM node:5

RUN mkdir /src

WORKDIR /src
ADD package.json /src/package.json
RUN npm install
COPY . /src
