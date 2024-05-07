### Pull Docker Image

Nautilus project developers are planning to start testing on a new project. As per their meeting with the DevOps team, they want to test containerized environment application features. As per details shared with DevOps team, we need to accomplish the following task:

a. Pull busybox:musl image on App Server 3 in Stratos DC and re-tag (create new tag) this image as busybox:local.

__Решение__

Сделать новый тэг на образе.

[Docs | Docker image tag](../Level_2/info/docker%20image%20tag.md)

Выполнение на сервере:
```bash
[banner@stapp03 ~]$ docker pull busybox:musl
musl: Pulling from library/busybox
d6e6e2f0bb21: Pull complete 
Digest: sha256:1a617013d77460b35b07911fd056bd5fc3b0964f8a29d2f582c12f2000ea4da3
Status: Downloaded newer image for busybox:musl
docker.io/library/busybox:musl

[banner@stapp03 ~]$ docker image ls
REPOSITORY          TAG                 IMAGE ID            CREATED             SIZE
busybox             musl                6e5e0f90c009        11 months ago       1.45MB

[banner@stapp03 ~]$ docker image tag busybox:musl busybox:local

[banner@stapp03 ~]$ docker image ls
REPOSITORY          TAG                 IMAGE ID            CREATED             SIZE
busybox             local               6e5e0f90c009        11 months ago       1.45MB
busybox             musl                6e5e0f90c009        11 months ago       1.45MB
[banner@stapp03 ~]$ 
```
