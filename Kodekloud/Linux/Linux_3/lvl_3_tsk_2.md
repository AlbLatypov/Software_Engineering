#  Install And Configure SFTP

Some of the developers from Nautilus project team have asked for SFTP access to at least one of the app server in Stratos DC. After going through the requirements, the system admins team has decided to configure the SFTP server on App Server 2 server in Stratos Datacenter. Please configure it as per the following instructions:


a. Create a SFTP user kirsty and set its password to GyQkFRVNr3. There is already a group called ftp, you can utilise the same.

b. Password authentication should be enabled for this user.

c. SFTP user should only be allowed to make SFTP connections.

### Решение

1. Подключаемся, проверяем пользователя, создаем при остуствии.
```bash
[root@stapp02 ~]# id kirsty
id: 'kirsty': no such user

useradd kirsty -G ftp
```

2. Вносим изменения /etc/ssh/sshd_config
```bash
# override default of no subsystems
Subsystem       sftp    /usr/libexec/openssh/sftp-server
Match User kirsty
    #ChrootDirectory /home/kirsty # Restrict to their home directory
    ForceCommand internal-sftp # Force SFTP-only connection
    X11Forwarding no
    AllowTcpForwarding no
```
