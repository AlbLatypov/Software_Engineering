# Apache Troubleshooting

xFusionCorp Industries uses some monitoring tools to check the status of every service, application, etc running on the systems. Recently, the monitoring system identified that Apache service is not running on some of the Nautilus Application Servers in Stratos Datacenter.


1. Identify the faulty Nautilus Application Server and fix the issue. Also, make sure Apache service is up and running on all Nautilus Application Servers. Do not try to stop any kind of firewall that is already running.


2. Apache is running on 3004 port on all Nautilus Application Servers and its document root must be /var/www/html on all app servers.


3. Finally you can test from jump host using curl command to access Apache on all app servers and it should be reachable and you should get some static page. E.g. curl http://172.16.238.10:3004/


### Решение

Ни один из 3х серверов не отвечает.

```bash
thor@jump_host ~$ curl 172.16.238.11:3004
curl: (7) Failed to connect to 172.16.238.11 port 3004: Connection refused
thor@jump_host ~$ curl 172.16.238.12:3004
curl: (7) Failed to connect to 172.16.238.12 port 3004: Connection refused
```
На 2х серверах только запустить сервис, он был остановлен

`systemctl start httpd`

На 3м сервис не запустился с ошибкой:

```bash
May 19 18:55:59 stapp03.stratos.xfusioncorp.com httpd[996]: httpd: Syntax error on line 34 of /etc/httpd/conf/httpd.conf: ServerRoot must be a valid directory
```
Смотрим 34 строку

`ServerRoot "/etc/httpd;"`

Еще всплывает `"Listen 3004"` в кавычках

и еще `DocumentRoot /var/www/html;`

Все исправляем, стратуем сервис. ОК.










