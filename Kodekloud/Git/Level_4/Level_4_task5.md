### Git Setup from Scratch

Some new developers have joined xFusionCorp Industries and have been assigned Nautilus project. They are going to start development on a new application, and some pre-requisites have been shared with the DevOps team to proceed with. Please note that all tasks need to be performed on storage server in Stratos DC.



a. Install git, set up any values for user.email and user.name globally and create a bare repository /opt/games.git.


b. There is an update hook (to block direct pushes to the master branch) under /tmp on storage server itself; use the same to block direct pushes to the master branch in /opt/games.git repo.


c. Clone /opt/games.git repo in /usr/src/kodekloudrepos/games directory.


d. Create a new branch named xfusioncorp_games in repo that you cloned under /usr/src/kodekloudrepos directory.


e. There is a readme.md file in /tmp directory on storage server itself; copy that to the repo, add/commit in the new branch you just created, and finally push your branch to the origin.


f. Also create master branch from your branch and remember you should not be able to push to the master directly as per the hook you have set up.

### Решение

1. Устанавливаем git `[root@ststor01 ~]# yum install -y git`

2. Создать голый репо

```bash
[root@ststor01 ~]# git init --bare /opt/games.git
hint: Using 'master' as the name for the initial branch. This default branch name
hint: is subject to change. To configure the initial branch name to use in all
hint: of your new repositories, which will suppress this warning, call:
hint: 
hint:   git config --global init.defaultBranch <name>
hint: 
hint: Names commonly chosen instead of 'master' are 'main', 'trunk' and
hint: 'development'. The just-created branch can be renamed via this command:
hint: 
hint:   git branch -m <name>
Initialized empty Git repository in /opt/games.git/
```
3. Прописываем пользователя и почту, делаю их системными:

```bash
[root@ststor01 ~]# git config --system user.name albert
[root@ststor01 ~]# git config --system user.email alberet@mmmail.com
[root@ststor01 ~]# git config --list --system
user.name=albert
user.email=alberet@mmmail.com
```
4. В /tmp лежит скрипт. Копируем его в .git/hooks

```bash
cat /tmp/update 
#!/bin/sh
if [ "$1" == refs/heads/master ];
then
  echo "Manual pushes to the master branch is restricted!!"
  exit 1

[root@ststor01 games]# cp /tmp/update .git/hooks/

```

5. Клонировать созданный репозиторий в `/usr/src/kodekloudrepos/games`:

```bash
[root@ststor01 hooks]# cd /usr/src/kodekloudrepos

[root@ststor01 kodekloudrepos]# git clone /opt/games.git
Cloning into 'games'...
warning: You appear to have cloned an empty repository.
done.
```

6. Создать ветку, скопировать файл в рабочую директорию, добавить в индекс, сделать коммит. По выполенению сделать пуш в основной репозиторий с этой ветки.

```bash
[root@ststor01 games]# git switch -c xfusioncorp_games
Switched to a new branch 'xfusioncorp_games'

[root@ststor01 games]# cp /tmp/readme.md .

[root@ststor01 games]# git add readme.md 

[root@ststor01 games]# git commit -m "first"
[xfusioncorp_games (root-commit) 642e715] first
 1 file changed, 1 insertion(+)
 create mode 100644 readme.md

[root@ststor01 games]# git branch -v
* xfusioncorp_games 642e715 first

[root@ststor01 games]# git remote -v
origin  /opt/games.git (fetch)
origin  /opt/games.git (push)

[root@ststor01 games]# git push origin xfusioncorp_games
Enumerating objects: 3, done.
Counting objects: 100% (3/3), done.
Writing objects: 100% (3/3), 234 bytes | 234.00 KiB/s, done.
Total 3 (delta 0), reused 0 (delta 0), pack-reused 0
To /opt/games.git
 * [new branch]      xfusioncorp_games -> xfusioncorp_games

[root@ststor01 games]# git reflog
642e715 (HEAD -> xfusioncorp_games, origin/xfusioncorp_games) HEAD@{0}: commit (initial): first
```


7. Отбранчеваться от текущей ветки в master

```bash
[root@ststor01 games]# git checkout -b master
Switched to a new branch 'master'
Your branch is based on 'origin/master', but the upstream is gone.
  (use "git branch --unset-upstream" to fixup)
[root@ststor01 games]# git branch -v
* master            642e715 [gone] first
  xfusioncorp_games 642e715 first
```


8. В конце сказано, что мне нужно помнить, что я не могу пушить в мастер основного репо, т.к. установлен хук. Проверяем.
```bash
[root@ststor01 games]# git push origin master
Total 0 (delta 0), reused 0 (delta 0), pack-reused 0
remote: Manual pushes to the master branch is restricted!!
remote: error: hook declined to update refs/heads/master
To /opt/games.git
 ! [remote rejected] master -> master (hook declined)
error: failed to push some refs to '/opt/games.git'
[root@ststor01 games]# 
```

Работает!
