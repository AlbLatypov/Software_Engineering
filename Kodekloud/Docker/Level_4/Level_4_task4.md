#  Docker Node App

There is a requirement to Dockerize a Node app and to deploy the same on __App Server 2__. Under __/node_app__ directory on __App Server 2__, we have already placed a __package.json__ file that describes the app dependencies and __server.js__ file that defines a web app framework.


- Create a __Dockerfile__ (name is case sensitive) under __/node_app__ directory:
    - Use any node image as the base image.
    - Install the dependencies using package.json file.
    - Use server.js in the CMD.
    - Expose port 3001.

- The build image should be named as nautilus/node-web-app.

- Now run a container named nodeapp_nautilus using this image.
    - Map the container port 3001 with the host port 8098.

- Once deployed, you can test the app using a curl command on App Server 2:


`curl http://localhost:8098`





#### Решение

Это файл package.json

```bash
{
  "name": "docker_web_app",
  "version": "1.0.0",
  "description": "Node.js on Docker",
  "author": "Sample Test <sample.test@example.com>",
  "main": "server.js",
  "keywords": [
    "nodejs",
    "bootstrap",
    "express"
  ],
  "scripts": {
    "start": "node server.js"
  },
  "dependencies": {
    "express": "^4.16.1"
  }
}
```
Это файл server.js

```bash
'use strict';

const express = require('express');

// Constants
const PORT = 3001;
const HOST = '0.0.0.0';

// App
const app = express();
app.get('/', (req, res) => {
  res.send('Welcome to xFusionCorp Industries!');
});

app.listen(PORT, HOST);
console.log(`Running on http://${HOST}:${PORT}`);
```
Пробуем создать Dockerfile. Существует необходимость установки npm install для работы js приложений. Типа requirment.txt в Python я думаю...

```bash
FROM node:20.13.1-alpine

WORKDIR /app

COPY . . 

RUN npm install

EXPOSE 3000

CMD ["node","server.js"]
```
`docker build -t nautilus/node-web-app .`

```bash
[root@stapp02 node_app]# docker run --name \
 nodeapp_nautilus -d -p 8091:3000 nautilus/node-web-app

```
