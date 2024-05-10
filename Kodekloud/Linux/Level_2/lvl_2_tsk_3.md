# Linux Collaborative Directories 

Linux Collaborative Directories
The Nautilus team doesn't want its data to be accessed by any of the other groups/teams due to security reasons and want their data to be strictly accessed by the dbadmin group of the team.

Setup a collaborative directory /dbadmin/data on app server 2 in Stratos Datacenter.

The directory should be group owned by the group dbadmin and the group should own the files inside the directory. The directory should be read/write/execute to the user and group owners, and others should not have any access.

### Решение

Создать каталог, группу если ее нет, накинуть прав на каталог и настроить разрешения, рекурсивно.

```bash
[steve@stapp02 /]$ sudo mkdir -p /dbadmin/data

[steve@stapp02 /]$ cat /etc/group | grep dbadmin
dbadmin:x:1002:

[steve@stapp02 /]$ sudo chown -R root:dbadmin /dbadmin/data

[steve@stapp02 /]$ sudo chmod -R 770 /dbadmin/data

[steve@stapp02 /]$ ls -la /dbadmin
total 12
drwxr-xr-x 3 root root    4096 May 10 16:03 .
drwxr-xr-x 1 root root    4096 May 10 16:03 ..
drwxrwx--- 2 root dbadmin 4096 May 10 16:03 data
[steve@stapp02 /]$ 
```



