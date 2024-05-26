# Apache Redirects

The Nautilus devops team got some requirements related to some Apache config changes. They need to setup some redirects for some URLs. There might be some more changes need to be done. Below you can find more details regarding that:


1.) httpd is already installed on app server 2. Configure Apache to listen on port 5001.

    Configure Apache to add some redirects as mentioned below:

    a.) Redirect http://stapp02.stratos.xfusioncorp.com:<Port>/ to http://www.stapp02.stratos.xfusioncorp.com:<Port>/ i.e non www to www. This must be a permanent redirect i.e 301

    b.) Redirect http://www.stapp02.stratos.xfusioncorp.com:<Port>/blog/ to http://www.stapp02.stratos.xfusioncorp.com:<Port>/news/. This must be a temporary redirect i.e 302.



### Решение

1. Настроить порт, запускаем сервис.

`sed -i "s/Listen 8080/Listen 5001" /etc/httpd/conf/httpd.conf`

2. Для настройки редиректа по пункту а(каталог /etc/httpd/conf.d):

```bash
[root@stapp02 conf.d]# cat>www-redirect.conf
<VirtualHost *:5001>
    ServerName http://stapp02.stratos.xfusioncorp.com:5001/
    Redirect permanent / http://www.stapp02.stratos.xfusioncorp.com:5001/
</VirtualHost>

[root@stapp02 conf.d]# systemctl restart httpd


[root@stapp02 conf.d]# curl http://stapp02.stratos.xfusioncorp.com:5001
<!DOCTYPE HTML PUBLIC "-//IETF//DTD HTML 2.0//EN">
<html><head>
<title>301 Moved Permanently</title>
</head><body>
<h1>Moved Permanently</h1>
<p>The document has moved <a href="http://www.stapp02.stratos.xfusioncorp.com:5001">here</a>.</p>
</body></html>
```

3. Для настройки настройки временного редиректа:

Создаем файл 
```bash
[root@stapp02 conf.d]# vi blog-news-redirect.conf

<VirtualHost *:5001>
    ServerName http://www.stapp02.stratos.xfusioncorp.com:5001/blog/
    Redirect 302 /blog/ http://www.stapp02.stratos.xfusioncorp.com:5001/news/
</VirtualHost>

[root@stapp02 conf.d]# systemctl restart httpd
```

[для чего нужен редирект](../docs/apache-redirect.md)

