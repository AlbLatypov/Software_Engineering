### Docker EXEC Operations

One of the Nautilus DevOps team members was working to configure services on a kkloud container that is running on App Server 2 in Stratos Datacenter. Due to some personal work he is on PTO for the rest of the week, but we need to finish his pending work ASAP. Please complete the remaining work as per details given below:

a. Install apache2 in kkloud container using apt that is running on App Server 2 in Stratos Datacenter.

b. Configure Apache to listen on port 6100 instead of default http port. Do not bind it to listen on specific IP or hostname only, i.e it should listen on localhost, 127.0.0.1, container ip, etc.

c. Make sure Apache service is up and running inside the container. Keep the container in running state at the end.

__Решение__

[curl -Ik localhost:6100](../Level_2/info/curl.md)



```bash
thor@jump_host ~$ ssh steve@stapp02

[steve@stapp02 ~]$ docker ps
CONTAINER ID        IMAGE               COMMAND             CREATED             STATUS              PORTS               NAMES
c457f48899de        ubuntu:18.04        "/bin/bash"         2 minutes ago       Up 2 minutes                            kkloud

[steve@stapp02 ~]$ docker exec -it kkloud apt install apache2
Reading package lists... Done
Building dependency tree       
Reading state information... Done
The following additional packages will be installed:
  apache2-bin apache2-data apache2-utils file libapr1 libaprutil1 libaprutil1-dbd-sqlite3 libaprutil1-ldap libexpat1
  libgdbm-compat4 libgdbm5 libicu60 liblua5.2-0 libmagic-mgc libmagic1 libperl5.26 libxml2 mime-support netbase perl
  perl-modules-5.26 ssl-cert xz-utils

[steve@stapp02 ~]$ docker exec -it kkloud /bin/bash

root@c457f48899de:/etc/apache2# cat ports.conf 
# If you just change the port or add more ports here, you will likely also
# have to change the VirtualHost statement in
# /etc/apache2/sites-enabled/000-default.conf

Listen 80

<IfModule ssl_module>
        Listen 443
</IfModule>

<IfModule mod_gnutls.c>
        Listen 443
</IfModule>

# vim: syntax=apache ts=4 sw=4 sts=4 sr noet

root@c457f48899de:/etc/apache2# cp ports.conf ports.conf.bak

root@c457f48899de:/etc/apache2# vi ports.conf
bash: vi: command not found

root@c457f48899de:/etc/apache2# vim ports.conf
bash: vim: command not found

root@c457f48899de:/etc/apache2# nano ports.conf
bash: nano: command not found

root@c457f48899de:/etc/apache2# sed -i 's/^Listen 80/Listen 6100/g' ports.conf

root@c457f48899de:/etc/apache2# cat ports.conf
# If you just change the port or add more ports here, you will likely also
# have to change the VirtualHost statement in
# /etc/apache2/sites-enabled/000-default.conf

Listen 6100

<IfModule ssl_module>
        Listen 443
</IfModule>

<IfModule mod_gnutls.c>
        Listen 443
</IfModule>

# vim: syntax=apache ts=4 sw=4 sts=4 sr noet

root@c457f48899de:/etc/apache2# service apache2 status
 * apache2 is not running

root@c457f48899de:/etc/apache2# service apache2 start 
 * Starting Apache httpd web server apache2
  AH00558: apache2: Could not reliably determine the server's fully
   qualified domain name, using 172.18.0.2. Set the 'ServerName' directive globally to suppress this message

```
В apache2.conf 80 порт не упоминается. И ServerName не прописан. Прописал руками (установил vim)

```bash
ServerName localhost
# Include list of ports to listen on
Include ports.conf


root@c457f48899de:/etc/apache2# service apache2 stop  
 * Stopping Apache httpd web server apache2                                                                                      * 
root@c457f48899de:/etc/apache2# service apache2 start
 * Starting Apache httpd web server apache2   

root@c457f48899de:/etc/apache2# curl -Ik localhost:6100
HTTP/1.1 200 OK
Date: Mon, 06 May 2024 21:33:23 GMT
Server: Apache/2.4.29 (Ubuntu)
Last-Modified: Mon, 06 May 2024 20:52:35 GMT
ETag: "2aa6-617cf3fba5da5"
Accept-Ranges: bytes
Content-Length: 10918
Vary: Accept-Encoding
Content-Type: text/html
```


