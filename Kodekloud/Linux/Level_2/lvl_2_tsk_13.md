# Linux Firewalld Setup

Забыл написать задание. Необходимо на трех серверах, пароли логины известны выполнить:
- установку firewalld
- разрешить nginx 80 порт
- запретить apache 8080 порт
- проверить что эти сервисы запущены и в работе.






### Решение

Firewalld ни на одном из серверов не установлен. Устанавливаем. Nginx и apache установлены, сервисы запущены.

```bash
Даем wheel возможность выполнять действия без запроса пароля
sudo visudo

Проделывать типовые операции придется на 3х серверах. Создаем скрипт:
#!/bin/bash

sudo yum install -y firewalld
sudo systemctl start firewalld
sudo systemctl enable firewalld
sudo firewall-cmd --state

#Проверяем состояние сервисов:
systemctl | grep -E "httpd|nginx"
#  httpd.service                                     loaded active running   The Apache HTTP Server                               
#  nginx.service                                     loaded active running   The nginx HTTP and reverse proxy server 
```

Прописываю алиасы для удобства:

```bash
alias fla="sudo firewall-cmd --list-all-zones"
alias flab="sudo firewall-cmd --list-all --zone=public"
alias fr="sudo firewall-cmd --reload"
```
#Какая зона дефолтная?
#[tony@stapp01 ~]$ sudo firewall-cmd --get-default-zone
#public

#Задам правило DROP для зоны:
#[tony@stapp01 ~]$ sudo firewall-cmd --permanent --zone=public --set-target=DROP


Попробуем сделать так:
``` bash
sudo firewall-cmd --zone=public --add-rich-rule='rule family="ipv4" port protocol="tcp" port="80" accept' --permanent
sudo firewall-cmd --zone=public --add-rich-rule='rule family="ipv4" port protocol="tcp" port="8080" reject' --permanent

[tony@stapp01 ~]$ flab
public
  target: default
  icmp-block-inversion: no
  interfaces: 
  sources: 
  services: cockpit dhcpv6-client ssh
  ports: 
  protocols: 
  forward: no
  masquerade: no
  forward-ports: 
  source-ports: 
  icmp-blocks: 
  rich rules: 
        rule family="ipv4" port port="8080" protocol="tcp" reject
        rule family="ipv4" port port="80" protocol="tcp" accept

Проверим какие порты открыты для сервисов.
[tony@stapp01 ~]$ sudo firewall-offline-cmd --info-service=ssh
ssh
  ports: 22/tcp
  protocols: 
  source-ports: 
  modules: 
  destination: 
  includes: 
  helpers: 

С удаленной машины можно проверить доступность по порту: все сервера stapp01, stapp02, stapp03 в одной сети
[steve@stapp02 ~]$ :> /dev/tcp/172.16.238.10/80 | echo $?
0
[steve@stapp02 ~]$ :> /dev/tcp/172.16.238.10/8080 | echo $?
0
-bash: connect: Connection refused
-bash: /dev/tcp/172.16.238.10/8080: Connection refused
[steve@stapp02 ~]$ :> /dev/tcp/172.16.238.12/8080 | echo $?
0
-bash: connect: Connection refused
-bash: /dev/tcp/172.16.238.12/8080: Connection refused
[steve@stapp02 ~]$ :> /dev/tcp/172.16.238.12/80 | echo $?
0

```

Должно работать. Подтверждаю выполнение. ВЕРНО!!!
