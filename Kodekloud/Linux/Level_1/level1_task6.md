# Linux User Data Transfer

Due to an accidental data mix-up, user data was unintentionally mingled on Nautilus App Server 3 at the /home/usersdata location by the Nautilus production support team in Stratos DC. To rectify this, specific user data needs to be filtered and relocated. Here are the details:

Locate all files (excluding directories) owned by user anita within the /home/usersdata directory on App Server 3. Copy these files while preserving the directory structure to the /news directory.

### Решение

```bash
[root@stapp03 news]# find /home/usersdata -type f -user anita -exec cp -p --parents {} /news \;

```
