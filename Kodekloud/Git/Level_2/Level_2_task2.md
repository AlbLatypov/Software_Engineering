### Git Create Branches

Nautilus developers are actively working on one of the project repositories, /usr/src/kodekloudrepos/media. Recently, they decided to implement some new features in the application, and they want to maintain those new changes in a separate branch. Below are the requirements that have been shared with the DevOps team:


- On Storage server in Stratos DC create a new branch xfusioncorp_media from master branch in /usr/src/kodekloudrepos/media git repo.

- Please do not try to make any changes in the code.

### Решение

Подключаемся SSH, переходим в каталог с репозиторием git. Смотрим, 

```bash
[root@ststor01 ~]# cd /usr/src/kodekloudrepos/media
[root@ststor01 media]# git branch -v
* kodekloud_media 186b7cf add data file
  master          56466c4 initial commit
```
Нужно отбранчеваться от мастера, переходим на него, выполняем:

```bash
[root@ststor01 media]# git switch master
Switched to branch 'master'

Создаем ветку и переключаемся на нее.

[root@ststor01 media]# git switch -c xfusioncorp_media

Switched to a new branch 'xfusioncorp_media'
[root@ststor01 media]# git branch -v
  kodekloud_media   186b7cf add data file
  master            56466c4 initial commit
* xfusioncorp_media 56466c4 initial commit
```
