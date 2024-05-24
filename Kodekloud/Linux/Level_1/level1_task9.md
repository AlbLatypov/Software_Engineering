# Script Execution Permissions

In a bid to automate backup processes, the xFusionCorp Industries sysadmin team has developed a new bash script named xfusioncorp.sh. While the script has been distributed to all necessary servers, it lacks executable permissions on App Server 2 within the Stratos Datacenter.

Your task is to grant executable permissions to the /tmp/xfusioncorp.sh script on App Server 2. Additionally, ensure that all users have the capability to execute it.

### Решение

Подключаемся по ssh, смотрим разрешения, даем исполнение, проверяем:
```bash
[steve@stapp02 tmp]$ sudo chmod 755 xfusioncorp.sh 

[steve@stapp02 tmp]$ alias ll="ls -laF"

[steve@stapp02 tmp]$ ll
total 1
-rwxr-xr-x 1 root root   40 May 24 19:18 xfusioncorp.sh*


[steve@stapp02 tmp]$ ./xfusioncorp.sh 
Welcome To KodeKloud
```
