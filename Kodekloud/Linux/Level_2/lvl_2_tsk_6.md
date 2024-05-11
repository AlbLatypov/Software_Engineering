# Linux Find Command

During a routine security audit, the team identified an issue on the Nautilus App Server. Some malicious content was identified within the website code. After digging into the issue they found that there might be more infected files. Before doing a cleanup they would like to find all similar files and copy them to a safe location for further investigation. Accomplish the task as per the following requirements:


a. On App Server 3 at location /var/www/html/official find out all files (not directories) having .php extension.

b. Copy all those files along with their parent directory structure to location /official on same server.

c. Please make sure not to copy the entire /var/www/html/official directory content.


### Решение

скопировать файлы php из /var/www/html/official, учитывая структуру каталога 

```bash
Файлов немного, можно и просто через cp, но просят родительскую структуру каталогов, тогда можно и файндом усложнить

[banner@stapp03 ~]$ sudo find /var/www/html/official/*php -type f -exec cp --parents {} /official/ \;

[banner@stapp03 official]$ ls -la
total 184
drwxr-xr-x 2 root root  4096 May 11 19:33 .
drwxr-xr-x 3 root root  4096 May 11 19:33 ..
-rw-r--r-- 1 root root   405 May 11 19:33 index.php
-rw-r--r-- 1 root root  7205 May 11 19:33 wp-activate.php
-rw-r--r-- 1 root root   351 May 11 19:33 wp-blog-header.php
-rw-r--r-- 1 root root  2338 May 11 19:33 wp-comments-post.php
-rw-r--r-- 1 root root  3001 May 11 19:33 wp-config-sample.php
-rw-r--r-- 1 root root  5543 May 11 19:33 wp-cron.php
-rw-r--r-- 1 root root  2494 May 11 19:33 wp-links-opml.php
-rw-r--r-- 1 root root  3985 May 11 19:33 wp-load.php
-rw-r--r-- 1 root root 49135 May 11 19:33 wp-login.php
-rw-r--r-- 1 root root  8522 May 11 19:33 wp-mail.php
-rw-r--r-- 1 root root 24587 May 11 19:33 wp-settings.php
-rw-r--r-- 1 root root 34350 May 11 19:33 wp-signup.php
-rw-r--r-- 1 root root  4914 May 11 19:33 wp-trackback.php
-rw-r--r-- 1 root root  3236 May 11 19:33 xmlrpc.php

[banner@stapp03 official]$ pwd
/official/var/www/html/official
```
НЕВЕРНО!!!

Запускаю заново! Там еще в поддиректориях куча файлов php, условия немного изменились в контексте каталогов, но суть нет. Вообщем зря указал в каталоге `/var/www/html/official/*php`. Сузил до локального каталога ранее. Сейчас будет смотреть всю внутрянку.

```bash
[tony@stapp01 news]$ pwd
/var/www/html/news

[tony@stapp01 news]$ sudo find ./ -type f -name "*.php" -exec cp --parents {} /news/ \;
```
ВЕРНО!

