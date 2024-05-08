#  Docker Ports Mapping

The Nautilus DevOps team is planning to host an application on a nginx-based container. There are number of tickets already been created for similar tasks. One of the tickets has been assigned to set up a nginx container on Application Server 1 in Stratos Datacenter. Please perform the task as per details mentioned below:

a. Pull nginx:alpine-perl docker image on Application Server 1.

b. Create a container named ecommerce using the image you pulled.

c. Map host port 8083 to container port 80. Please keep the container in running state.

[Документация по задаче. Docker RUN](../Docs/docker-RUN.md)

#### Решение

```bash
[tony@stapp01 ~]$ docker run -d --name ecommerce -p 8083:80 nginx:alpine-perl

Unable to find image 'nginx:alpine-perl' locally
alpine-perl: Pulling from library/nginx
4abcf2066143: Pull complete 
fc21a1d387f5: Pull complete 
e6ef242c1570: Pull complete 
13fcfbc94648: Pull complete 
d4bca490e609: Pull complete 
5406ed7b06d9: Pull complete 
8a3742a9529d: Pull complete 
0d0c16747d2c: Pull complete 
c364652da0ee: Pull complete 
Digest: sha256:3670fea93f4d7e825fa02ef4140c8eab76cdcf7e1ef6f2573e7587b58eff1993
Status: Downloaded newer image for nginx:alpine-perl
6711d505fa55c2fba188d9382f36241d44e661da241331f16deb031aaa98bc4a

[tony@stapp01 ~]$ docker ps
CONTAINER ID        IMAGE               COMMAND                  CREATED             STATUS              PORTS                  NAMES
6711d505fa55        nginx:alpine-perl   "/docker-entrypoint.…"   15 seconds ago      Up 12 seconds       0.0.0.0:8083->80/tcp   ecommerce

[tony@stapp01 ~]$ docker port 6711d505fa55
80/tcp -> 0.0.0.0:8083

[tony@stapp01 ~]$ curl localhost:8083
<!DOCTYPE html>
<html>
<head>
<title>Welcome to nginx!</title>
<style>
html { color-scheme: light dark; }
body { width: 35em; margin: 0 auto;
font-family: Tahoma, Verdana, Arial, sans-serif; }
</style>
</head>
<body>
<h1>Welcome to nginx!</h1>
<p>If you see this page, the nginx web server is successfully installed and
working. Further configuration is required.</p>

<p>For online documentation and support please refer to
<a href="http://nginx.org/">nginx.org</a>.<br/>
Commercial support is available at
<a href="http://nginx.com/">nginx.com</a>.</p>

<p><em>Thank you for using nginx.</em></p>
</body>
</html>
[tony@stapp01 ~]$
```
