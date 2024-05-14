# Maria DB Troubleshooting

There is a critical issue going on with the Nautilus application in Stratos DC. The production support team identified that the application is unable to connect to the database. After digging into the issue, the team found that mariadb service is down on the database server.


Look into the issue and fix the same.



### Решение

Подключаемся, стартуем сервис марии.

```bash
[root@stdb01 ~]# systemctl start mariadb
Job for mariadb.service failed because the control process exited with error code.
See "systemctl status mariadb.service" and "journalctl -xe" for details.

смотрим логи:
journalctl -all --unit=mariadb
```
В логах вижу следующее, как мне кажется причину.
```bash
May 14 21:45:14 stdb01.stratos.xfusioncorp.com mysql-prepare-db-dir[1010]: Database MariaDB is not initialized, but the directory /var/lib/mysql is not empty, so initialization ca
nnot be done.
May 14 21:45:14 stdb01.stratos.xfusioncorp.com mysql-prepare-db-dir[1010]: Make sure the /var/lib/mysql is empty before running mysql-prepare-db-dir.
```

Похоже название директории изменено

```bash
[root@stdb01 ~]# cd /var/lib/mysql
-bash: cd: /var/lib/mysql: No such file or directory
[root@stdb01 ~]# cd /var/lib
[root@stdb01 lib]# ls
alternatives  dbus  dnf  games  misc  mysqld  portables  private  rhsm  rpm  rpm-state  selinux  systemd
[root@stdb01 lib]# ls -la
total 80
drwxr-xr-x 1 root  root  4096 May 14 21:43 .
drwxr-xr-x 1 root  root  4096 May 14 21:43 ..
drwxr-xr-x 1 root  root  4096 Feb  8  2023 alternatives
drwxr-xr-x 1 root  root  4096 Feb  7  2023 dbus
drwxr-xr-x 1 root  root  4096 Mar  4  2023 dnf
drwxr-xr-x 1 root  root  4096 Jun 21  2021 games
drwxr-xr-x 1 root  root  4096 Jun 21  2021 misc
drwxr-xr-x 4 mysql mysql 4096 May 14 21:43 mysqld   <---------------------------------------- вот это
drwx------ 1 root  root  4096 Feb  7  2023 portables
drwx------ 1 root  root  4096 Feb  7  2023 private
drwxr-x--- 1 root  root  4096 Feb  8  2023 rhsm
drwxr-xr-x 1 root  root  4096 May 14 21:43 rpm
drwxr-xr-x 1 root  root  4096 Jun 21  2021 rpm-state
drwxr-xr-x 1 root  root  4096 Feb  7  2023 selinux
drwxr-xr-x 1 root  root  4096 Feb  8  2023 systemd
```

[root@stdb01 lib]# mv mysqld mysql

Решено!
```bash
[root@stdb01 lib]# systemctl start mariadb

[root@stdb01 lib]# systemctl status mariadb
● mariadb.service - MariaDB 10.3 database server
   Loaded: loaded (/usr/lib/systemd/system/mariadb.service; enabled; vendor preset: disabled)
   Active: active (running) since Tue 2024-05-14 21:53:26 UTC; 9s ago                <-----------------------------------------------------------------Active
     Docs: man:mysqld(8)
           https://mariadb.com/kb/en/library/systemd/
  Process: 1293 ExecStartPost=/usr/libexec/mysql-check-upgrade (code=exited, status=0/SUCCESS)
  Process: 1188 ExecStartPre=/usr/libexec/mysql-prepare-db-dir mariadb.service (code=exited, status=0/SUCCESS)
  Process: 1152 ExecStartPre=/usr/libexec/mysql-check-socket (code=exited, status=0/SUCCESS)
 Main PID: 1250 (mysqld)
   Status: "Taking your SQL requests now..."
    Tasks: 30 (limit: 1340692)
   Memory: 77.5M
   CGroup: /docker/ba28dbd3eccea0a4b6cf18990a15c2ec84565994bcd911329d6fc7d7f017f560/system.slice/mariadb.service
           └─1250 /usr/libexec/mysqld --basedir=/usr

May 14 21:53:26 stdb01.stratos.xfusioncorp.com systemd[1293]: Applying namespace mount on /run/systemd/unit-root/var/tmp
May 14 21:53:26 stdb01.stratos.xfusioncorp.com systemd[1293]: Successfully mounted /var/tmp/systemd-private-5f48d68aa7254e83a527aee671bda79c-mariadb.servic
e-CEQhNe/tmp to /run/systemd/unit-root/var/tmp
May 14 21:53:26 stdb01.stratos.xfusioncorp.com systemd[1293]: mariadb.service: Executing: /usr/libexec/mysql-check-upgrade
May 14 21:53:26 stdb01.stratos.xfusioncorp.com systemd[1]: mariadb.service: Child 1293 belongs to mariadb.service.
May 14 21:53:26 stdb01.stratos.xfusioncorp.com systemd[1]: mariadb.service: Control process exited, code=exited status=0
May 14 21:53:26 stdb01.stratos.xfusioncorp.com systemd[1]: mariadb.service: Got final SIGCHLD for state start-post.
May 14 21:53:26 stdb01.stratos.xfusioncorp.com systemd[1]: mariadb.service: Changed start-post -> running
May 14 21:53:26 stdb01.stratos.xfusioncorp.com systemd[1]: mariadb.service: Job mariadb.service/start finished, result=done
May 14 21:53:26 stdb01.stratos.xfusioncorp.com systemd[1]: Started MariaDB 10.3 database server.
May 14 21:53:26 stdb01.stratos.xfusioncorp.com systemd[1]: mariadb.service: Failed to send unit change signal for mariadb.service: Connection reset by peer
```
