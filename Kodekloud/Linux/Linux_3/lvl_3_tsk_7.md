# Configure protected directories in Apache

xFusionCorp Industries has hosted several static websites on Nautilus Application Servers in Stratos DC. There are some confidential directories in the document root that need to be password protected. Since they are using Apache for hosting the websites, the production support team has decided to use .htaccess with basic auth. There is a website that needs to be uploaded to /var/www/html/itadmin on Nautilus App Server 2. However, we need to set up the authentication before that.


1. Create /var/www/html/itadmin direcotry if doesn't exist.

2. Add a user javed in htpasswd and set its password to GyQkFRVNr3.

3. There is a file /tmp/index.html present on Jump Server. Copy the same to the directory you created, please make sure default document root should remain /var/www/html. Also website should work on URL http://<app-server-hostname>:8080/itadmin/



### Решение

Переходим на сервер, копируем файл, настраиваем .htaccess, .htpasswd

```bash
mkdir -p /var/www/html/itadmin
htpasswd -c /etc/httpd/.htpasswd javed
vi /var/www/html/itadmin/.htaccess
mv /tmp/index.html /var/www/html/itadmin
systemctl start httpd
curl -u javed stapp02:8080/itadmin

[root@stapp02 ~]# curl -u javed stapp02:8080/itadmin
Enter host password for user 'javed':
<!DOCTYPE HTML PUBLIC "-//IETF//DTD HTML 2.0//EN">
<html><head>
<title>301 Moved Permanently</title>
</head><body>
<h1>Moved Permanently</h1>
<p>The document has moved <a href="http://stapp02:8080/itadmin/">here</a>.</p>
</body></html>
```
Содержимое файл .htaccess

```bash
AuthType Basic
AuthName "Restricted Area"
AuthUserFile /etc/httpd/.htpasswd
Require valid-user
```


