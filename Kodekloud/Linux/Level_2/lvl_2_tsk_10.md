# Linux Services


As per details shared by the development team, the new application release has some dependencies on the back end. There are some packages/services that need to be installed on all app servers under Stratos Datacenter. As per requirements please perform the following steps:


a. Install squid package on all the application servers.

b. Once installed, make sure it is enabled to start during boot.



### Решение

```bash
[tony@stapp01 ~]$ sudo yum install -y squid

[tony@stapp01 ~]$ systemctl status squid
● squid.service - Squid caching proxy
   Loaded: loaded (/usr/lib/systemd/system/squid.service; disabled; vendor preset: disabled)
   Active: inactive (dead)
     Docs: man:squid(8)

May 11 20:58:35 stapp01.stratos.xfusioncorp.com systemd[1]: squid.service: Collecting.

[tony@stapp01 ~]$ sudo systemctl start squid

[tony@stapp01 ~]$ sudo systemctl enable squid
Created symlink /etc/systemd/system/multi-user.target.wants/squid.service → /usr/lib/systemd/system/squid.service.

[tony@stapp01 ~]$ systemctl status squid
● squid.service - Squid caching proxy
   Loaded: loaded (/usr/lib/systemd/system/squid.service; enabled; vendor preset: disabled)
   Active: active (running) since Sat 2024-05-11 21:00:18 UTC; 41s ago
     Docs: man:squid(8)
 Main PID: 1325 (squid)
    Tasks: 1 (limit: 1340692)
   Memory: 30.7M
   CGroup: /docker/ee130a27723da8e9d0123478e2f146f902ae5c47c44055a613b24db3244b93ba/system.slice/squid.service
           ├─1325 /usr/sbin/squid --foreground -f /etc/squid/squid.conf
           ├─1339 (squid-1) --kid squid-1 --foreground -f /etc/squid/squid.conf
           └─1352 (logfile-daemon) /var/log/squid/access.log
```



