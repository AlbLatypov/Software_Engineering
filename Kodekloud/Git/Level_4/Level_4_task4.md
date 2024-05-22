### Git Hook

The Nautilus application development team was working on a git repository /opt/media.git which is cloned under /usr/src/kodekloudrepos directory present on Storage server in Stratos DC. The team want to setup a hook on this repository, please find below more details:



Merge the feature branch into the master branch`, but before pushing your changes complete below point.

Create a post-update hook in this git repository so that whenever any changes are pushed to the master branch, it creates a release tag with name release-2023-06-15, where 2023-06-15 is supposed to be the current date. For example if today is 20th June, 2023 then the release tag must be release-2023-06-20. Make sure you test the hook at least once and create a release tag for today's release.

Finally remember to push your changes.

### Решение

[git hooks](../docs/git_hooks.md)

```bash
[root@ststor01 ~]# cd /usr/src/kodekloudrepos/ecommerce/

[root@ststor01 ecommerce]# git reflog
306d2bc (HEAD -> feature, origin/feature) HEAD@{0}: commit: Add feature
617fbd4 (origin/master, master) HEAD@{1}: checkout: moving from master to feature
617fbd4 (origin/master, master) HEAD@{2}: commit (initial): initial commit
```

Необходимо создать скрипт хука, причем это нужно сделать в hooks именно репозитория основного, не склонированного! Переходим 
```bash
root@ststor01 ~]# cd /opt/media.git/

[root@ststor01 media.git]# ls
HEAD  branches  config  description  hooks  info  objects  refs

[root@ststor01 media.git]# cd hooks/

[root@ststor01 hooks]# cp post-update.sample post-update

[root@ststor01 hooks]# vi post-update

#!/bin/sh

release_date=$(date +"%Y-%m-%d")
tag_name="release-${release_date}"
git tag -a "$tag_name" -m "Automated release for ${release_date}"
```

Далее переходим в склонированный репозиторий и выполняем:

```bash
[root@ststor01 hooks]# cd /usr/src/kodekloudrepos/media/

[root@ststor01 media]# git branch -v
* feature f54b0bd Add feature
  master  cfa22b0 initial commit
[root@ststor01 media]# git switch master
Switched to branch 'master'
Your branch is up to date with 'origin/master'.
```

Выполняем merge, смотрим логи, push
```bash
[root@ststor01 media]# git merge feature
Updating cfa22b0..f54b0bd
Fast-forward
 feature.txt | 1 +
 1 file changed, 1 insertion(+)
 create mode 100644 feature.txt

[root@ststor01 media]# git log
commit f54b0bdc689c9e7bb02e9a509ab27d78c5f2d057 (HEAD -> master, origin/feature, feature)
Author: Admin <admin@kodekloud.com>
Date:   Wed May 22 10:45:17 2024 +0000

    Add feature

[root@ststor01 media]# git push origin master
Total 0 (delta 0), reused 0 (delta 0), pack-reused 0
To /opt/media.git
   cfa22b0..f54b0bd  master -> master
```

Переходим в основной репозиторий, посмотреть тэги и логи там.
```bash
cd /opt/media.git/

[root@ststor01 media.git]# git tag -l
release-2024-05-22

[root@ststor01 media.git]# git log
commit f54b0bdc689c9e7bb02e9a509ab27d78c5f2d057 (HEAD -> master, tag: release-2024-05-22, feature)
Author: Admin <admin@kodekloud.com>
Date:   Wed May 22 10:45:17 2024 +0000

    Add feature
```

и в логах видно тэг.
