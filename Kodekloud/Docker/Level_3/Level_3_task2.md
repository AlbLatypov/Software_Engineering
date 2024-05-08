# Docker Volumes Mapping

The Nautilus DevOps team is testing applications containerization, which issupposed to be migrated on docker container-based environments soon. In today's stand-up meeting one of the team members has been assigned a task to create and test a docker container with certain requirements. Below are more details:

a. On App Server  3 in Stratos DC pull __nginx__ image (preferably latest tag but others should work too).

b. Create a new container with name __ecommerce__ from the image you just pulled.

c. Map the host volume __/opt/sysops__ with container volume __/home__. There is an sample.txt file present on same server under /tmp; copy that file to /opt/sysops. Also please keep the container in running state.

[Документация по задаче. Docker Volumes](../Docs/volumes.md)

#### Решение

Подключаемся и создаем контейнер согласно требованиям:
```bash
thor@jump_host ~$ ssh banner@stapp03

[banner@stapp03 ~]$ docker run --name ecommerce -d -v /opt/sysops:/home nginx:latest
de101a22ea8bdb058186c07d9a85f4a0de8726756db4edb3280e8e891aa781d0

[banner@stapp03 ~]$ docker ps
CONTAINER ID        IMAGE               COMMAND                  CREATED             STATUS              PORTS               NAMES
de101a22ea8b        nginx:latest        "/docker-entrypoint.…"   13 seconds ago      Up 10 seconds       80/tcp              ecommerce

[banner@stapp03 ~]$ sudo cp /tmp/sample.txt /opt/sysops/

Проверяем на контейнере
[banner@stapp03 ~]$ docker exec -it de101a22ea8b ls -l /home
total 4
-rw-r--r-- 1 root root 23 May  8 20:13 sample.txt
```


