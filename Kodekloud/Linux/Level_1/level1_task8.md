# Data Backup for Developer

Within the Stratos DC, the Nautilus storage server hosts a directory named /data, serving as a repository for various developers non-confidential data. Developer anita has requested a copy of their data stored in /data/anita. The System Admin team has provided the following steps to fulfill this request:

a. Create a compressed archive named anita.tar.gz of the /data/anita directory.

b. Transfer the archive to the /home directory on the Storage Server.

### Решение

`[root@ststor01 ~]# tar -cvzf anita.tar.gz /data/anita && cp anita.tar.gz /home`