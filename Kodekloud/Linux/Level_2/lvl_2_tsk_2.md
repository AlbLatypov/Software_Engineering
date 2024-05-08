# Linux banner

During the monthly compliance meeting, it was pointed out that several servers in the Stratos DC do not have a valid banner. The security team has provided serveral approved templates which should be applied to the servers to maintain compliance. These will be displayed to the user upon a successful login.


Update the message of the day on all application and db servers for Nautilus. Make use of the approved template located at /home/thor/nautilus_banner on jump host


### Решение

Для всех пользователей перечисленных серверов проделать:
```bash
thor@jump_host ~$ scp nautilus_banner peter@stdb01:/tmp

thor@jump_host ~$ ssh peter@stdb01
peter@stdb01's password: 
Last login: Wed May  8 21:56:33 2024 from 172.16.239.4

[peter@stdb01 ~]$ sudo mv /tmp/nautilus_banner /etc/motd
```



