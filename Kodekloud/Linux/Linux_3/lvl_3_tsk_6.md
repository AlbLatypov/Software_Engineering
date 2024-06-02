# Linux Nginx as Reverse Proxy

Nautilus system admin's team is planning to deploy a front end application for their backup utility on Nautilus Backup Server, so that they can manage the backups of different websites from a graphical user interface. They have shared requirements to set up the same; please accomplish the tasks as per detail given below:


a. Install Apache Server on Nautilus Backup Server and configure it to use 8082 port (do not bind it to 127.0.0.1 only, keep it default i.e let Apache listen on server's IP, hostname, localhost, 127.0.0.1 etc).

b. Install Nginx webserver on Nautilus Backup Server and configure it to use 8091.

c. Configure Nginx as a reverse proxy server for Apache.

d. There is a sample index file /home/thor/index.html on Jump Host, copy that file to Apache's document root.

e. Make sure to start Apache and Nginx services.

f. You can test final changes using curl command, e.g curl http://<backup server IP or Hostname>:8091.


### Решение

```bash
[root@stbkp01 ~]# yum install httpd-devel.x86_64 -y

[root@stbkp01 ~]# yum install nginx

[root@stbkp01 ~]# sed -i 's/Listen 80/Listen 8082/g' /etc/httpd/conf/httpd.conf

[root@stbkp01 ~]# systemctl status httpd
● httpd.service - The Apache HTTP Server
   Loaded: loaded (/usr/lib/systemd/system/httpd.service; disabled; vendor preset: disabled)
   Active: active (running) since Sun 2024-06-02 16:27:04 UTC; 14s ago
     Docs: man:httpd.service(8)
 Main PID: 4025 (httpd)
   Status: "Running, listening on: port 8082"

thor@jump_host ~$ scp index.html clint@stbkp01:/tmp

[root@stbkp01 ~]# cp /tmp/index.html /var/www/html/
[root@stbkp01 ~]# curl localhost:8082
Welcome to xFusionCorp Industries![root@stbkp01 ~]# 
```

Файл скопирован. Можем читать index.html

Конфигурируем nginx в качестве реверс прокси для апачи.

```bash
    server {
        listen       8091 default_server; #<-----------------------
        #listen       [::]:80 default_server;
        server_name  _;
        root         /usr/share/nginx/html;

        # Load configuration files for the default server block.
        include /etc/nginx/default.d/*.conf;

        location / {
           proxy_pass http://stbkp01:8082; #<---------------------
        }

```
Проверяем:

```bash
thor@jump_host ~$ curl stbkp01:8091
Welcome to xFusionCorp Industries!thor@jump_host ~$
```

