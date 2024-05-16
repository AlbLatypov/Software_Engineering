### Git Clone Repositories

DevOps team created a new Git repository last week; however, as of now no team is using it. The Nautilus application development team recently asked for a copy of that repo on Storage server in Stratos DC. Please clone the repo as per details shared below:

The repo that needs to be cloned is /opt/cluster.git


Clone this git repository under /usr/src/kodekloudrepos directory. Please do not try to make any changes in the repo.

### Решение

```bash
[root@ststor01 ~]# cd /usr/src/kodekloudrepos
[root@ststor01 kodekloudrepos]# 

[root@ststor01 kodekloudrepos]# git clone /opt/cluster.git
Cloning into 'cluster'...
warning: You appear to have cloned an empty repository.
done.
[root@ststor01 kodekloudrepos]# ls -la
total 12
drwxr-xr-x 3 root root 4096 May 16 08:53 .
drwxr-xr-x 1 root root 4096 May 16 08:28 ..
drwxr-xr-x 3 root root 4096 May 16 08:53 cluster
```
