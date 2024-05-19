### Git Cherry Pick

The Nautilus application development team has been working on a project repository /opt/beta.git. This repo is cloned at /usr/src/kodekloudrepos on storage server in Stratos DC. They recently shared the following requirements with the DevOps team:

There are two branches in this repository, master and feature. One of the developers is working on the feature branch and their work is still in progress, however they want to merge one of the commits from the feature branch to the master branch, the message for the commit that needs to be merged into master is Update info.txt. Accomplish this task for them, also remember to push your changes eventually.


### Решение

[8.1 Git – Копирование коммитов – Копирование коммитов: cherry-pick](https://www.youtube.com/watch?v=TZJxBSfR0NE&list=PLDyvV36pndZFHXjXuwA_NywNrVQO0aQqb&index=40)

[GIT. Cherry-pick](../docs/git%20cherry-pick.md)

Мы находимся на ветке feature, нужно перенести коммит update.info в мастер ветку. Т.е. будет создан новый коммит в ветке мастер с изменениями сделанными коммитом из другой ветки.

```bash
    8  git config alias.b "branch -v"
   11  git config alias.l "log -pretty=oneline"
   14  git config alias.l "log --pretty=oneline"

[root@ststor01 beta]# git b
* feature c9b264f Update welcome.txt
  master  9bab1dd Add welcome.txt

[root@ststor01 beta]# git l
c9b264f76cd0511379bd60d113b1a296b5d2a046 (HEAD -> feature, origin/feature) Update welcome.txt
d8cd63a908da3f89f4c1d5bed433458d0e479e19 Update info.txt
9bab1dd433f1bc35b675e0d2d95aa59333f80b62 (origin/master, master) Add welcome.txt
eaec7d299d6c51e483f38a9c8e79dee012bc207c initial commit

[root@ststor01 beta]# git switch master
Switched to branch 'master'
Your branch is up to date with 'origin/master'.

[root@ststor01 beta]# git cherry-pick d8cd63a908da3f89f4c1d5bed433458d0e479e19
[master 140ce70] Update info.txt
 Date: Sun May 19 10:57:37 2024 +0000
 1 file changed, 1 insertion(+), 1 deletion(-)

[root@ststor01 beta]# git b
  feature c9b264f Update welcome.txt
* master  140ce70 [ahead 1] Update info.txt

[root@ststor01 beta]# git remote -v
origin  /opt/beta.git (fetch)
origin  /opt/beta.git (push)

[root@ststor01 beta]# git l
140ce702d8a38ff5eaebeeb417b70dee1a669f5e (HEAD -> master) Update info.txt
9bab1dd433f1bc35b675e0d2d95aa59333f80b62 (origin/master) Add welcome.txt
eaec7d299d6c51e483f38a9c8e79dee012bc207c initial commit

[root@ststor01 beta]# git push --all
```


