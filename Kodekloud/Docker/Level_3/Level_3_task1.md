### Pull Docker Image

The Nautilus DevOps team needs to set up several docker environments for different applications. One of the team members has been assigned a ticket where he has been asked to create some docker networks to be used later. Complete the task based on the following ticket description:

a. Create a docker network named as __official__ on App Server 1 in Stratos DC.

b. Configure it to use __macvlan__ drivers.

c. Set it to use subnet __10.10.1.0/24__ and iprange __10.10.1.1/24__.


#### Решение

```bash
thor@jump_host ~$ ssh tony@stapp01

[tony@stapp01 ~]$ docker network create --driver macvlan --subnet 10.10.1.0/24 --ip-range 10.10.1.1/24 official
8a8a02033142221800ff7f1d1f51f963c37cb17ca425e085647a3cecbc59f7d8

[tony@stapp01 ~]$ docker network ls
NETWORK ID          NAME                DRIVER              SCOPE
aa0880bc9d67        bridge              bridge              local
1d8d5fc2b095        host                host                local
fabd8b1308b1        none                null                local
8a8a02033142        official            macvlan             local

```
