### Git Install and Create Bare Repository

The Nautilus development team shared requirements with the DevOps team regarding new application development.—specifically, they want to set up a Git repository for that project. Create a Git repository on Storage server in Stratos DC as per details given below:



Install git package using yum on Storage server.


After that create a __bare repository__ /opt/apps.git (make sure to use exact name).

### Решение

Подключаемся по SSH к серверу. Логин пароль известны. Необходимо ицициализировать чистый репозиторий.


```bash
thor@jump_host ~$ ssh natasha@ststor01

[root@ststor01 ~]# yum install git -y

Инициализируем чистый репо.

[root@ststor01 opt]# git init --bare /opt/apps.git

[root@ststor01 opt]# ls -la
total 12
drwxr-xr-x 1 root root 4096 May 16 08:19 .
drwxr-xr-x 1 root root 4096 May 16 07:49 ..
drwxr-xr-x 7 root root 4096 May 16 08:19 apps.git

```
