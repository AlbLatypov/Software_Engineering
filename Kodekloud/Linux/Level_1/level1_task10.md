# File Permission Correction

After conducting a security audit within the Stratos DC, the Nautilus security team discovered misconfigured permissions on critical files. To address this, corrective actions are being taken by the production support team. Specifically, the file named /etc/hosts on Nautilus App 3 server requires adjustments to its Access Control Lists (ACLs) as follows:

1. The file's user owner and group owner should be set to root.

2. Others should possess read only permissions on the file.

3. User james must not have any permissions on the file.

4. User garrett should be granted read only permission on the file.

### Решение

Проверяем:
- root - owner and group owner
- other - read

Остались пользователи. В системе заведены:

```bash
[root@stapp03 ~]# grep -E "james|garret" /etc/passwd
james:x:1002:1002::/home/james:/bin/bash
garrett:x:1003:1003::/home/garrett:/bin/bash


[root@stapp03 ~]# getfacl /etc/hosts
getfacl: Removing leading '/' from absolute path names
# file: etc/hosts
# owner: root
# group: root
user::rw-
group::r--
other::r--

[root@stapp03 ~]# setfacl -m james:--- /etc/hosts
[root@stapp03 ~]# setfacl -m garrett:r-- /etc/hosts

[root@stapp03 ~]# getfacl /etc/hosts
getfacl: Removing leading '/' from absolute path names
# file: etc/hosts
# owner: root
# group: root
user::rw-
user:james:---
user:garrett:r--
group::r--
mask::r--
other::r--
```
