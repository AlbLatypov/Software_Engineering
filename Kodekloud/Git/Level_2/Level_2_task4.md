### Git Manage Remotes

The xFusionCorp development team added updates to the project that is maintained under /opt/demo.git repo and cloned under /usr/src/kodekloudrepos/demo. Recently some changes were made on Git server that is hosted on Storage server in Stratos DC. The DevOps team added some new Git remotes, so we need to update remote on /usr/src/kodekloudrepos/demo repository as per details mentioned below:

a. In __/usr/src/kodekloudrepos/demo__ repo add a new remote __dev_demo__ and point it to /opt/xfusioncorp_demo.git repository.

b. There is a file /tmp/index.html on same server; copy this file to the repo and add/commit to master branch.

c. Finally push master branch to this new remote origin.



### Решение
Подключились, перешли в указанный репо, одна ветка.

```bash
[root@ststor01 demo]# git branch -v
* master 6f9a60b initial commit

Добавляем новый удаленный репо

git remote add dev_demo /opt/xfusioncorp_demo.git

[root@ststor01 demo]# git remote -v
dev_demo        /opt/xfusioncorp_demo.git (fetch)
dev_demo        /opt/xfusioncorp_demo.git (push)
origin  /opt/demo.git (fetch)
origin  /opt/demo.git (push)
```

Копируем файл в рабочую директорию, добавляем в индекс, делаем коммит.

```bash
[root@ststor01 demo]# git s
On branch master
Your branch is up to date with 'origin/master'.

Untracked files:
  (use "git add <file>..." to include in what will be committed)
        index.html

nothing added to commit but untracked files present (use "git add" to track)
[root@ststor01 demo]# git add .
[root@ststor01 demo]# git commit -m "dff"
[master d4949e5] dff
 1 file changed, 10 insertions(+)
 create mode 100644 index.html
```
Пушим все это дело в новый удаленный репозиторий:
`[root@ststor01 branches]# git push dev_demo master`



