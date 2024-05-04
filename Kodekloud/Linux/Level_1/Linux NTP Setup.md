# Linux NTP Setup

The system admin team of xFusionCorp Industries has noticed an issue with some servers in Stratos Datacenter where some of the servers are not in sync w.r.t time. Because of this, several application functionalities have been impacted. To fix this issue the team has started using common/standard NTP servers. They are finished with most of the servers except App Server 2. Therefore, perform the following tasks on this server:


1. Install and configure NTP server on App Server 2.

2. Add NTP server 3.pool.ntp.org in NTP configuration on App Server 2.

3. Please do not try to start/restart/stop ntp service, as we already have a restart for this service scheduled for tonight and we don't want these changes to be applied right now.


### Решение:

проблема только на втором stapp02

Нужно инсталлировать ntp сервер
Есть ли /etc/ntp.conf? файла нет.
``` bash
[steve@stapp02 ~]$ sudo vi /etc/ntp.conf
```
Сервис:
```bash
[steve@stapp02 ~]$ sudo systemctl status ntpd
Unit ntpd.service could not be found.
```

Пробуем установить:
``` bash
sudo yum update
sudo yum install ntp
```

Смотрим /etc/ntp.conf. Присутствуют публичные сервера. Ничего про то, оставлять или убирать их не написано. Просто выполняем условие. Добавляем.
``` bash
# Use public servers from the pool.ntp.org project.
# Please consider joining the pool (http://www.pool.ntp.org/join.html).
server 0.centos.pool.ntp.org iburst
server 1.centos.pool.ntp.org iburst
server 2.centos.pool.ntp.org iburst
#server 3.centos.pool.ntp.org iburst
server 3.pool.ntp.org iburst
```

Сервис сказано не трогать:
```bash
[steve@stapp02 ~]$ sudo systemctl status ntpd
● ntpd.service - Network Time Service
   Loaded: loaded (/usr/lib/systemd/system/ntpd.service; disabled; vendor preset: disabled)
   Active: inactive (dead)
```

Про 123 порт и приоритетность также ничего не сказано. Оставляем так.
