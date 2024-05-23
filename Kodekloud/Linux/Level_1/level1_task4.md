# Service User Creation without Home Directory

In response to the latest tool implementation at xFusionCorp Industries, the system admins require the creation of a service user account. Here are the specifics:

Create a user named mark in App Server 2 without a home directory.

### Решение

```bash
[steve@stapp02 ~]$ sudo useradd -M -r mark

[steve@stapp02 ~]$ tail /etc/password
tail: cannot open '/etc/password' for reading: No such file or directory

[steve@stapp02 ~]$ tail /etc/passwd
ftp:x:14:50:FTP User:/var/ftp:/sbin/nologin
nobody:x:65534:65534:Kernel Overflow User:/:/sbin/nologin
dbus:x:81:81:System message bus:/:/sbin/nologin
systemd-coredump:x:999:997:systemd Core Dumper:/:/sbin/nologin
systemd-resolve:x:193:193:systemd Resolver:/:/sbin/nologin
tss:x:59:59:Account used for TPM access:/dev/null:/sbin/nologin
sshd:x:74:74:Privilege-separated SSH:/var/empty/sshd:/sbin/nologin
ansible:x:1000:1000::/home/ansible:/bin/bash
steve:x:1001:1001::/home/steve:/bin/bash
mark:x:998:995::/home/mark:/bin/bash

[steve@stapp02 ~]$ ls /home
ansible  steve
```

Фактически с ключом -M каталог с домашней директорией создается.
