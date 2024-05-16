#  Docker Python App

A python app needed to be Dockerized, and then it needs to be deployed on App Server 2. We have already copied a requirements.txt file (having the app dependencies) under /python_app/src/ directory on App Server 2. Further complete this task as per details mentioned below:


    Create a Dockerfile under /python_app directory:
        Use any python image as the base image.
        Install the dependencies using requirements.txt file.
        Expose the port 8086.
        Run the server.py script using CMD.

    Build an image named nautilus/python-app using this Dockerfile.

    Once image is built, create a container named pythonapp_nautilus:
        Map port 8086 of the container to the host port 8097.

    Once deployed, you can test the app using curl command on App Server 2.


#### Решение

Создаем образ для приложения на python, стартуем контейнер:

Содержимое Dockerfile

```bash
FROM python:3.10.11-alpine3.18

WORKDIR /app

COPY ./src .

RUN pip install -r requirements.txt

EXPOSE 8086

CMD ["python", "server.py"]
```
Содержимое requirements.txt
`flask`

Содержимое server.py
```python
from flask import Flask

# the all-important app variable:
app = Flask(__name__)

@app.route("/")
def hello():
    return "Welcome to xFusionCorp Industries!"

if __name__ == "__main__":
        app.config['TEMPLATES_AUTO_RELOAD'] = True
        app.run(host='0.0.0.0', debug=True, port=8086)
```

Создаем образ и стартуем контейнер:
```bash
[root@stapp02 python_app]# docker build -t nautilus/python-app .


docker run --name pythonapp_nautilus -d -p 8097:8086 nautilus/python-app

[root@stapp02 python_app]# docker ps
CONTAINER ID        IMAGE                 COMMAND              CREATED             STATUS              PORTS                    NAMES
5cb650660f17        nautilus/python-app   "python server.py"   36 seconds ago      Up 34 seconds       0.0.0.0:8097->8086/tcp   pythonapp_nautilus

[root@stapp02 python_app]# curl localhost:8097
Welcome to xFusionCorp Industries![root@stapp02 python_app]# 

```
