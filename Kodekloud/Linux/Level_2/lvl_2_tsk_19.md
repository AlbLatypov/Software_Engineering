# Linux Bash Scripts

The production support team of xFusionCorp Industries is working on developing some bash scripts to automate different day to day tasks. One is to create a bash script for taking websites backup. They have a static website running on App Server 1 in Stratos Datacenter, and they need to create a bash script named blog_backup.sh which should accomplish the following tasks. (Also remember to place the script under /scripts directory on App Server 1).


a. Create a zip archive named xfusioncorp_blog.zip of /var/www/html/blog directory.

b. Save the archive in /backup/ on App Server 1. This is a temporary storage, as backups from this location will be clean on weekly basis. Therefore, we also need to save this backup archive on Nautilus Backup Server.

c. Copy the created archive to Nautilus Backup Server server in /backup/ location.

d. Please make sure script won't ask for password while copying the archive file. Additionally, the respective server user (for example, tony in case of App Server 1) must be able to run it.



### Решение

1. Нужно создать архив zip директории и положить его /backup
2. т.к. эта директории чистится полученный файл нужно скопировать на бэкап сервер (будет пользовать scp) и также просят делать это без пароля, значит прокинуть ключ нужно
3. Сделать скрипт исполняемым для tony, про остальных ничего не сказано, поэтому сделаю только для Tony.

```bash
Скрипт:

#!/bin/bash

#!/bin/bash

zip -r /backup/xfusioncorp_blog.zip /var/www/html/blog

scp /backup/xfusioncorp_blog.zip clint@stbkp01:/backup
```

Не запускаем. Делаем ключ и прокидываем на stbkp01. Под пользователем!!!

```bash
[tony@stapp01 ~]$ ssh-keygen -q
Enter file in which to save the key (/home/tony/.ssh/id_rsa): 
Enter passphrase (empty for no passphrase): 
Enter same passphrase again: 
[tony@stapp01 ~]$ ssh-copy-id clint@stbkp01
/usr/bin/ssh-copy-id: INFO: Source of key(s) to be installed: "/home/tony/.ssh/id_rsa.pub"
The authenticity of host 'stbkp01 (172.16.238.16)' can't be established.
ECDSA key fingerprint is SHA256:Rt6wMUNiEIuubWkZANhIzE+O+xJlfx8EAqAHMNkH0/s.
ECDSA key fingerprint is MD5:fe:62:fe:b3:ce:0c:a0:ac:fd:a6:ed:2c:7c:33:9d:ed.
Are you sure you want to continue connecting (yes/no)? yes
/usr/bin/ssh-copy-id: INFO: attempting to log in with the new key(s), to filter out any that are already installed
/usr/bin/ssh-copy-id: INFO: 1 key(s) remain to be installed -- if you are prompted now it is to install the new keys
clint@stbkp01's password: 

Number of key(s) added: 1

Now try logging into the machine, with:   "ssh 'clint@stbkp01'"
and check to make sure that only the key(s) you wanted were added.

[tony@stapp01 ~]$ ssh clint@stbkp01
[clint@stbkp01 ~]$ 
```

Скрипт должен запускаться под пользователем, в частности под tony
```bash
[tony@stapp01 scripts]$ sudo chmod 775 blog_backup.sh 
[sudo] password for tony: 
Sorry, try again.
[sudo] password for tony: 
[tony@stapp01 scripts]$ ls -al
total 12
drwxrwxrwx 2 root root 4096 May 14 22:09 .
drwxr-xr-x 1 root root 4096 May 14 21:57 ..
-rwxrwxr-x 1 root root  124 May 14 22:09 blog_backup.sh
[tony@stapp01 scripts]$ 
```

Стартуем скрипт, проверяем на бэкапе.
```bash
[tony@stapp01 scripts]$ ./blog_backup.sh 
  adding: var/www/html/blog/ (stored 0%)
  adding: var/www/html/blog/index.html (stored 0%)
  adding: var/www/html/blog/.gitkeep (stored 0%)
xfusioncorp_blog.zip                                                                          100%  588     2.9MB/s   00:00    
[tony@stapp01 scripts]$ 
```





