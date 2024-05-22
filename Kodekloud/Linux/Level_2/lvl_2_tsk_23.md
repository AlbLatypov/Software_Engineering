# Linux Log Rotate

The Nautilus DevOps team is ready to launch a new application, which they will deploy on app servers in Stratos Datacenter. They are expecting significant traffic/usage of __tomcat__ on __app servers__ after that. This will generate massive logs, creating huge log files. To utilise the storage efficiently, they need to compress the log files and need to rotate old logs. Check the requirements shared below:


a. In all app servers install tomcat package.

b. Using logrotate configure tomcat logs rotation to monthly and keep only 3 rotated logs.

(If by default log rotation is set, then please update configuration as needed)





### Решение

Подключаемся, устанавливаем:

`[root@stapp02 ~]# yum update -y && yum install tomcat -y`

После установки /etc/logrotate.d/tomcat.disabled присутствует
```bash
# This is an example config only and is disabled by default
# If you wish to use it, you'll need to update /etc/tomcat/logging.properties
# to prevent catalina*.log from being rotated by Tomcat
/var/log/tomcat/catalina*.log {
    copytruncate
    weekly
    rotate 52
    compress
    missingok
    create 0644 tomcat tomcat
}

```

переименуем его, почему он disabled?

```bash
[root@stapp01 tomcat]# cd /etc/logrotate.d/

[root@stapp01 logrotate.d]# mv tomcat.disabled tomcat

[root@stapp01 tomcat]# vi /etc/logrotate.d/tomcat

# This is an example config only and is disabled by default
# If you wish to use it, you'll need to update /etc/tomcat/logging.properties
# to prevent catalina*.log from being rotated by Tomcat
/var/log/tomcat/catalina*.log {
    copytruncate
    monthly
    rotate 3
    compress
    missingok
    create 0644 tomcat tomcat
```

что будет делать logrotate

```bash
[root@stapp01 logrotate.d]# logrotate -d /etc/logrotate.d/tomcat 
WARNING: logrotate in debug mode does nothing except printing debug messages!  Consider using verbose mode (-v) instead if this is not what you want.

reading config file /etc/logrotate.d/tomcat
Reading state from file: /var/lib/logrotate/logrotate.status
Allocating hash table for state file, size 64 entries
Creating new state
Creating new state
Creating new state
Creating new state

Handling 1 logs

rotating pattern: /var/log/tomcat/catalina*.log  monthly (3 rotations)
empty log files are rotated, old logs are removed
considering log /var/log/tomcat/catalina*.log
  log /var/log/tomcat/catalina*.log does not exist -- skipping
Creating new state
```





