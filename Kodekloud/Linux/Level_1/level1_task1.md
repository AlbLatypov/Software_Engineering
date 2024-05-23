# Custom Apache User Setup

In response to heightened security concerns, the xFusionCorp Industries security team has opted for custom Apache users for their web applications. Each user is tailored specifically for an application, enhancing security measures. Your task is to create a custom Apache user according to the outlined specifications:

a. Create a user named john on App server 1 within the Stratos Datacenter.

b. Assign a unique UID 1593 and designate the home directory as /var/www/john

### Решение

```bash
thor@jump_host ~$ ssh tony@stapp01

[tony@stapp01 ~]$ sudo useradd -u 1593 -d /var/www/john john

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
john:x:1593:1593::/var/www/john:/bin/bash
```
