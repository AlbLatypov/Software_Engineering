### Git hard reset

The Nautilus application development team was working on a git repository /usr/src/kodekloudrepos/official present on Storage server in Stratos DC. This was just a test repository and one of the developers just pushed a couple of changes for testing, but now they want to clean this repository along with the commit history/work tree, so they want to point back the HEAD and the branch itself to a commit with message add data.txt file. Find below more details:



In /usr/src/kodekloudrepos/official git repository, reset the git commit history so that there are only two commits in the commit history i.e initial commit and add data.txt file.


Also make sure to push your changes.


### Решение

Подключаемся, переходим в каталог с репозиторием:

```bash
[root@ststor01 official]# git config alias.l "log --pretty=oneline"

[root@ststor01 official]# git l
f91323a20ef480a5203ec8b69b2fc3423ea70ba3 (HEAD -> master, origin/master) Test Commit10
8af8f928400618aa87b98b142097dc8a067cac92 Test Commit9
7a155310947ddbe1f9888a7d0949472650067913 Test Commit8
835bd470d22f10374613a05f17e10f10cb0378a6 Test Commit7
bbdeb1751406a150dad9b0baada323edc45cb785 Test Commit6
c1b4c2a692ca8e26a2ef669300182d389d6234dc Test Commit5
a5bf8214547cff929cf4a45428502271100b61f2 Test Commit4
9f034fddebedfd8216496301da4eddead27e88d8 Test Commit3
9bb846ae29a588dd03a8c3c367afce5fc90a6eb0 Test Commit2
91c76397700ebe90be2705c27ed332d52af3e7dc Test Commit1
a6472c81c799b956cbd343b061d58865f89035dc add data.txt file
cb6cba628c6ed170ed401cd60c4612b192b7973f initial commit
```
Нужно перейти на add data.txt file

```bash
[root@ststor01 official]# git reset --hard 
ia6472c81c799b956cbd343b061d58865f89035dc
HEAD is now at a6472c8 add data.txt file

[root@ststor01 official]# git l
a6472c81c799b956cbd343b061d58865f89035dc (HEAD -> master) add data.txt file
cb6cba628c6ed170ed401cd60c4612b192b7973f initial commit
```

Чтобы пушить в удаленный репозиторий, где другая хронология коммитов нужно это делать через `--force`

```bash
[root@ststor01 official]# git push --force
Total 0 (delta 0), reused 0 (delta 0), pack-reused 0
To /opt/official.git
 + f91323a...a6472c8 master -> master (forced update)
[root@ststor01 official]# git l
a6472c81c799b956cbd343b061d58865f89035dc (HEAD -> master, origin/master) add data.txt file
cb6cba628c6ed170ed401cd60c4612b192b7973f initial commit
[root@ststor01 official]# git pull
Already up to date.

```
