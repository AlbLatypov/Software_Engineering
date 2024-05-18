### Git Install and Create Repository

The Nautilus development team shared with the DevOps team requirements for new application development, setting up a Git repository for that project. Create a Git repository on Storage server in Stratos DC as per details given below:


- Install git package using yum on Storage server.

- After that, create/init a git repository named /opt/apps.git (use the exact name as asked and make sure not to create a bare repository).



### Решение

Подключаемся по SSH, переключаемся на рута, ставим git. Создаем репозиторий git, без --bare

```bash
thor@jump_host ~$ ssh natasha@ststor01
The authenticity of host 'ststor01 (172.16.238.15)' can't be established.
ECDSA key fingerprint is SHA256:qxyAd4hEs4OKm/1nnhEUVFTASW+VX/W3GRTmFYTEmrQ.
Are you sure you want to continue connecting (yes/no/[fingerprint])? yes
Warning: Permanently added 'ststor01,172.16.238.15' (ECDSA) to the list of known hosts.
natasha@ststor01's password: 
[natasha@ststor01 ~]$ sudo -i

We trust you have received the usual lecture from the local System
Administrator. It usually boils down to these three things:

    #1) Respect the privacy of others.
    #2) Think before you type.
    #3) With great power comes great responsibility.

[sudo] password for natasha: 
[root@ststor01 ~]# yum install git -y

[root@ststor01 ~]# git init /opt/apps.git

```
