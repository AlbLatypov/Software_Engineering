# 

The Nautilus application development team recently finished the beta version of one of their Java-based applications, which they are planning to deploy on one of the app servers in Stratos DC. After an internal team meeting, they have decided to use the tomcat application server. Based on the requirements mentioned below complete the task:


a. Install tomcat server on App Server 1.

b. Configure it to run on port 5000.

c. There is a ROOT.war file on Jump host at location /tmp.

Deploy it on this tomcat server and make sure the webpage works directly on base URL i.e curl http://stapp01:5000
 


### Решение

1. Устанавливаем
`[root@stapp01 ~]# yum install tomcat`

2. [Дополнительная информация](../docs/tomcat_about.md)

3. Вносим изменения в файл `/etc/tomcat/server.xml`
```bash
    <Connector port="5000" protocol="HTTP/1.1"
               connectionTimeout="20000"
               redirectPort="8443" />
```
4. Копируем в директорию по умолчанию для приложений tomcat `/usr/share/tomcat/webapps`
```bash
thor@jump_host ~$ scp /tmp/ROOT.war tony@stapp01:/tmp
[root@stapp01 webapps]# cp /tmp/ROOT.war .

[root@stapp01 webapps]# systemctl restart tomcat

[root@stapp01 webapps]# curl http://stapp01:5000
<!DOCTYPE html>
<!--
To change this license header, choose License Headers in Project Properties.
To change this template file, choose Tools | Templates
and open the template in the editor.
-->
<html>
    <head>
        <title>SampleWebApp</title>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
    </head>
    <body>
        <h2>Welcome to xFusionCorp Industries!</h2>
        <br>
    
    </body>
</html>
```
