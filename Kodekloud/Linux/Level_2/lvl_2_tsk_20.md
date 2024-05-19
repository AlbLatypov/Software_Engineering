# Add Response Headers in Apache

We are working on hardening Apache web server on all app servers. As a part of this process we want to add some of the Apache response headers for security purpose. We are testing the settings one by one on all app servers. As per details mentioned below enable these headers for Apache:

- Install httpd package on App Server 1 using yum and configure it to run on 3000 port, make sure to start its service.

- Create an index.html file under Apache's default document root i.e /var/www/html and add below given content in it.

- Welcome to the xFusionCorp Industries!

- Configure Apache to enable below mentioned headers:

    - X-XSS-Protection header with value 1; mode=block

    - X-Frame-Options header with value SAMEORIGIN

    - X-Content-Type-Options header with value nosniff

Note: You can test using curl on the given app server as LBR URL will not work for this task.




### Решение

Подключаемся, создаем файл, наполняем содержимым согласно условию.
```bash
[root@stapp03 ~]# cat>/var/www/html/index.html
Welcome to the xFusionCorp Industries!
[root@stapp03 ~]# cat /var/www/html/index.html
Welcome to the xFusionCorp Industries!`
```

Корректируем httpd.conf

```bash
[root@stapp01 conf]# sed -i 's/Listen 80/Listen 3000/' httpd.conf
```
В конец конфигурационного файла добавляем:

```bash
<IfModule mod_headers.c>
    Header set X-XSS-Protection "1; mode=block"
    Header set X-Frame-Options "SAMEORIGIN"
    Header set X-Content-Type-Options "nosniff"
</IfModule>
```

Запускаем сервис:
```bash
[root@stapp03 ~]# systemctl start httpd
[root@stapp03 ~]# systemctl status httpd
● httpd.service - The Apache HTTP Server
   Loaded: loaded (/usr/lib/systemd/system/httpd.service; disabled; vendor preset: disabled)
   Active: active (running) since Sun 2024-05-19 18:33:01 UTC; 5s ago
     Docs: man:httpd.service(8)
 Main PID: 1031 (httpd)
   Status: "Started, listening on: port 3000"
    Tasks: 213 (limit: 1340692)
   Memory: 19.5M
   CGroup: /docker/482eb33c92290ba04feb1e7d7bd4a8e35ec0da71590a75b2c5927bb80ce3b1ab/system.slice/httpd.service
           ├─1031 /usr/sbin/httpd -DFOREGROUND
           ├─1057 /usr/sbin/httpd -DFOREGROUND
           ├─1058 /usr/sbin/httpd -DFOREGROUND
           ├─1059 /usr/sbin/httpd -DFOREGROUND
           └─1060 /usr/sbin/httpd -DFOREGROUND

```

Проверяем:
```bash
[root@stapp03 ~]# curl -i localhost:3000
HTTP/1.1 200 OK
Date: Sun, 19 May 2024 18:33:27 GMT
Server: Apache/2.4.37 (CentOS Stream)
Last-Modified: Sun, 19 May 2024 18:29:09 GMT
ETag: "27-618d2c2c0a766"
Accept-Ranges: bytes
Content-Length: 39
X-XSS-Protection: 1; mode=block
X-Frame-Options: SAMEORIGIN
X-Content-Type-Options: nosniff
Content-Type: text/html; charset=UTF-8

Welcome to the xFusionCorp Industries!
```


### Заголовки безопасности

Конечно, давайте подробнее рассмотрим эти заголовки и другие варианты, которые можно использовать в конфигурационном файле Apache.

    X-XSS-Protection заголовок:
        Этот заголовок используется для включения встроенной защиты браузера от XSS (Cross-Site Scripting) атак.
        Значение 1; mode=block указывает браузеру блокировать страницу, если обнаружена XSS атака.
        Другие возможные значения:
            0: Отключает защиту XSS в браузере.
            1: Включает защиту XSS и санитизирует страницу, если обнаружена атака.

    X-Frame-Options заголовок:
        Этот заголовок контролирует, может ли страница быть встроена в iframe на других сайтах, помогая предотвратить атаки clickjacking.
        Значение SAMEORIGIN разрешает встраивание только на том же домене.
        Другие возможные значения:
            DENY: Запрещает встраивание страницы в iframe на любом сайте.
            ALLOW-FROM uri: Разрешает встраивание только на указанном URI.

    X-Content-Type-Options заголовок:
        Этот заголовок предотвращает интерпретацию браузером типа контента отлично от указанного сервером, помогая предотвратить атаки путаницы MIME типов.
        Значение nosniff указывает браузеру не пытаться угадывать тип контента.

Другие заголовки безопасности, которые можно установить в конфигурации Apache:

    Strict-Transport-Security (HSTS):
        Этот заголовок указывает браузеру взаимодействовать с сайтом только по HTTPS.
        Пример: Header set Strict-Transport-Security "max-age=31536000; includeSubDomains"

    Content-Security-Policy (CSP):
        Этот заголовок позволяет указать разрешенные источники контента для страницы, помогая предотвратить XSS и другие атаки инъекций.
        Пример: Header set Content-Security-Policy "default-src 'self'; script-src 'self' 'unsafe-inline'"

    Referrer-Policy:
        Этот заголовок контролирует, какая информация отправляется в заголовке Referer при переходах со страницы.
        Пример: Header set Referrer-Policy "strict-origin-when-cross-origin"

    Feature-Policy:
        Этот заголовок позволяет указать, какие функции браузера разрешены на странице.
        Пример: Header set Feature-Policy "geolocation 'none'; camera 'none'"

Это лишь некоторые из заголовков безопасности, которые можно установить. Точные заголовки и их значения зависят от требований вашего приложения и политик безопасности.

Помните, что для использования директивы Header в Apache, необходимо включить модуль mod_headers. Это можно сделать, добавив следующую строку в конфигурацию Apache:

LoadModule headers_module modules/mod_headers.so

Надеюсь, эта информация поможет вам лучше понять заголовки безопасности и как их настроить в Apache!


