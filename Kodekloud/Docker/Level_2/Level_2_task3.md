### Create a Docker Image From Container

One of the Nautilus developer was working to test new changes on a container. He wants to keep a backup of his changes to the container. A new request has been raised for the DevOps team to create a new image from this container. Below are more details about it:

a. Create an image blog:datacenter on Application Server 1 from a container ubuntu_latest that is running on same server.


__Решение__

[Docs | Docker Container Commit](../Docs/docker%20container%20commit.md)

```bash
thor@jump_host ~$ ssh tony@stapp01

[tony@stapp01 ~]$ docker ps
CONTAINER ID        IMAGE               COMMAND             CREATED              STATUS              PORTS               NAMES
29c3df054f80        ubuntu              "/bin/bash"         About a minute ago   Up About a minute                       ubuntu_latest

[tony@stapp01 ~]$ docker image ls
REPOSITORY          TAG                 IMAGE ID            CREATED             SIZE
ubuntu              latest              bf3dc08bfed0        7 days ago          76.2MB

[tony@stapp01 ~]$ docker commit 29c3df054f80 blog:datacenter
sha256:cc596e49248b33fea125d1988e7fcf76173aa2c3617b3a6319e9d0818974cd67

[tony@stapp01 ~]$ docker images
REPOSITORY          TAG                 IMAGE ID            CREATED             SIZE
blog                datacenter          cc596e49248b        8 seconds ago       112MB
ubuntu              latest              bf3dc08bfed0        7 days ago          76.2MB
```
