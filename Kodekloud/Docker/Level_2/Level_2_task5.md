### Write a Docker File

As per recent requirements shared by the Nautilus application development team, they need custom images created for one of their projects. Several of the initial testing requirements are already been shared with DevOps team. Therefore, create a docker file /opt/docker/Dockerfile (please keep D capital of Dockerfile) on App server 3 in Stratos DC and configure to build an image with the following requirements:


a. Use ubuntu as the base image.

b. Install apache2 and configure it to work on 8084 port. (do not update any other Apache configuration settings like document root etc).


__Решение__

```bash
thor@jump_host ~$ ssh banner@stapp03

[banner@stapp03 docker]$ sudo vi Dockerfile
FROM ubuntu

RUN apt update 

RUN apt install-y apache2

RUN sed -i "s/^Listen 80/Listen 8084/g" /etc/apache2/ports.conf
```


