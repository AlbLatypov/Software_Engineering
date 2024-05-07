### Docker Update Permissions

One of the Nautilus project developers need access to run docker commands on App Server 2. This user is already created on the server. Accomplish this task as per details given below:


User rose is not able to run docker commands on App Server 2 in Stratos DC, make the required changes so that this user can run docker commands without sudo.


__Решение__

Разрешить выполнение команд docker без Sudo.

```bash
tail /etc/group
systemd-resolve:x:193:
tss:x:59:
ssh_keys:x:996:
sshd:x:74:
ansible:x:1000:
steve:x:1001:
apache:x:48:
docker:x:995:steve
cgred:x:994:
rose:x:1002:

sudo usermod -aG docker rose

[steve@stapp02 ~]$ su - rose

[rose@stapp02 ~]$ groups
rose docker

[rose@stapp02 ~]$ docker ps
CONTAINER ID        IMAGE               COMMAND             CREATED             STATUS              PORTS               NAMES
```
