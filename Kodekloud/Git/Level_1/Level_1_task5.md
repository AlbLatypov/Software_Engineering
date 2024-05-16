### Git Delete Branches

Nautilus developers are actively working on one of the project repositories, /usr/src/kodekloudrepos/apps. They were doing some testing and created few test branches, now they want to clean those test branches. Below are the requirements that have been shared with the DevOps team:

On Storage server in Stratos DC delete a branch named xfusioncorp_apps from /usr/src/kodekloudrepos/apps git repo.

### Решение

Нужно удалить ветку.

```bash
[root@ststor01 apps]# git status
On branch xfusioncorp_apps
nothing to commit, working tree clean

[root@ststor01 apps]# git branch -v
  master           b819f36 initial commit
* xfusioncorp_apps b819f36 initial commit

[root@ststor01 apps]# git switch master
Switched to branch 'master'
Your branch is up to date with 'origin/master'.

[root@ststor01 apps]# git branch -d xfusioncorp_apps
Deleted branch xfusioncorp_apps (was b819f36).

[root@ststor01 apps]# git branch -v
* master b819f36 initial commit
```
