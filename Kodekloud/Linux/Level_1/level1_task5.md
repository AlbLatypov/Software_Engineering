# Temporary User Setup with Expiry

As part of the temporary assignment to the Nautilus project, a developer named john requires access for a limited duration. To ensure smooth access management, a temporary user account with an expiry date is needed. Here's what you need to do:

Create a user named john on App Server 1 in Stratos Datacenter. Set the expiry date to 2024-01-28, ensuring the user is created in lowercase as per standard protocol.

### Решение

Подключаемся по ssh, логин пароль известен.

```bash
[tony@stapp01 ~]$ sudo useradd john

[tony@stapp01 ~]$ tail /etc/passwd
ftp:x:14:50:FTP User:/var/ftp:/sbin/nologin
nobody:x:65534:65534:Kernel Overflow User:/:/sbin/nologin
dbus:x:81:81:System message bus:/:/sbin/nologin
systemd-coredump:x:999:997:systemd Core Dumper:/:/sbin/nologin
systemd-resolve:x:193:193:systemd Resolver:/:/sbin/nologin
tss:x:59:59:Account used for TPM access:/dev/null:/sbin/nologin
sshd:x:74:74:Privilege-separated SSH:/var/empty/sshd:/sbin/nologin
ansible:x:1000:1000::/home/ansible:/bin/bash
tony:x:1001:1001::/home/tony:/bin/bash
john:x:1002:1002::/home/john:/bin/bash

[tony@stapp01 ~]$ sudo chage -E 2024-01-28

[tony@stapp01 ~]$ sudo chage -l john
Last password change                                    : May 23, 2024
Password expires                                        : never
Password inactive                                       : never
Account expires                                         : Jan 28, 2024
Minimum number of days between password change          : 0
Maximum number of days between password change          : 99999
Number of days of warning before password expires       : 7
```

Фактически с ключом -M каталог с домашней директорией создается.
