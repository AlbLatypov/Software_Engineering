# Resolve DockerCompose Issues

To secure our Nautilus infrastructure in Stratos Datacenter we have decided to install and configure firewalld on all app servers. We have Apache and Nginx services running on these apps. Nginx is running as a reverse proxy server for Apache. We might have more robust firewall settings in the future, but for now we have decided to go with the given requirements listed below:


a. Allow all incoming connections on Nginx port, i.e 80.

b. Block all incoming connections on Apache port, i.e 8080.

c. All rules must be permanent.

d. Zone should be public.

e. If Apache or Nginx services aren't running already, please make sure to start them.




#### Решение

```bash
Представлен следующий compose-file:

name: myapp

services:
    web:
        image: ./app
        container_name: python
        port:
            - "5000:5000"
        volumes:
            - ./app:/code
        depends_on:
            - redis
    redis_app:
        image: redis
        container_name: redis

Отредактировал так:

services:
  redis_app:
    image: redis:latest
    container_name: redis
  web:
    build: ./app
    container_name: python
    ports:
      - "5000:5000"
    volumes:
      - ./app:/code
    depends_on:
      - redis_app
```
Должно быть верно.

Содержимое каталога .app:

app.py
```bash
# compose_flask/app.py
from flask import Flask
from redis import Redis

app = Flask(__name__)
redis = Redis(host='redis', port=6379)

@app.route('/')
def hello():
    redis.incr('hits')
    return 'This Compose/Flask demo has been viewed %s time(s).' % redis.get('hits')


if __name__ == "__main__":
    app.run(host="0.0.0.0", debug=True)[steve@stapp02 app]$ 
```

Dockerfile
```bash
FROM python:3.13.0b1-slim-bullseye
ADD . /code
WORKDIR /code
RUN pip install -r requirements.txt
CMD python app.py[steve@stapp02 app]$ 
```

requirements.txt
```bash
flask
```

