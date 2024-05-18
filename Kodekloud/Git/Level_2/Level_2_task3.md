### Git Merge Branches

The Nautilus application development team has been working on a project repository /opt/cluster.git. This repo is cloned at /usr/src/kodekloudrepos on storage server in Stratos DC. They recently shared the following requirements with DevOps team:


Create a new branch devops in /usr/src/kodekloudrepos/cluster repo from master and copy the /tmp/index.html file (present on storage server itself) into the repo. Further, add/commit this file in the new branch and merge back that branch into master branch. Finally, push the changes to the origin for both of the branches.



### Решение

1. Создать ветку devops от master
2. скопировать файл
3. добавить в индекс, сделать коммит в новой ветке
4. сделать merge в мастер.
5. push обе ветки

```bash
[root@ststor01 cluster]# git branch -v
* master 5e6353f initial commit

[root@ststor01 cluster]# git switch -c devops
Switched to a new branch 'devops'

[root@ststor01 cluster]# git branch -v
* devops 5e6353f initial commit
  master 5e6353f initial commit

[root@ststor01 cluster]# git config alias.s "status"

[root@ststor01 cluster]# cp /tmp/index.html .

[root@ststor01 cluster]# git s

On branch devops
Untracked files:
  (use "git add <file>..." to include in what will be committed)
        index.html

nothing added to commit but untracked files present (use "git add" to track)

[root@ststor01 cluster]# git add .

[root@ststor01 cluster]# git commit -m "add:file"
[devops 70348de] add:file
 1 file changed, 1 insertion(+)
 create mode 100644 index.html

 [root@ststor01 cluster]# git merge devops
Updating 5e6353f..70348de
Fast-forward
 index.html | 1 +
 1 file changed, 1 insertion(+)
 create mode 100644 index.html

 [root@ststor01 cluster]# git push --all origin
Enumerating objects: 4, done.
Counting objects: 100% (4/4), done.
Delta compression using up to 36 threads
Compressing objects: 100% (2/2), done.
Writing objects: 100% (3/3), 325 bytes | 325.00 KiB/s, done.
Total 3 (delta 0), reused 0 (delta 0), pack-reused 0
To /opt/cluster.git
   5e6353f..70348de  master -> master
 * [new branch]      devops -> devops
```

