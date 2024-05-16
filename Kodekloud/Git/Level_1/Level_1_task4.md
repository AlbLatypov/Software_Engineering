### Git Repository Update

The Nautilus development team started with new project development. They have created different Git repositories to manage respective project's source code. One of the repositories /opt/blog.git was created recently. The team has given us a sample index.html file that is currently present on jump host under /tmp directory. The repository has been cloned at /usr/src/kodekloudrepos on storage server in Stratos DC.

Copy sample index.html file from jump host to storage server under cloned repository at /usr/src/kodekloudrepos/blog, further add/commit the file and push to the master branch.

### Решение

Склонирован репозиторий на сервер ststor1 ранее. На удаленном сервере это каталог `/usr/src/kodekloudrepos/blog`. Подключаемся, смотрим:

```bash
thor@jump_host ~$ ssh natasha@ststor01

[root@ststor01 blog]# pwd
/usr/src/kodekloudrepos/blog

[root@ststor01 blog]# git status
On branch master
Your branch is up to date with 'origin/master'.

nothing to commit, working tree clean
```

Далее нужно скопировать файл с рабочего хоста на удаленный. Сделать add/commit

```bash
thor@jump_host /tmp$ scp index.html natasha@ststor01:/tmp

[root@ststor01 blog]# cp /tmp/index.html .

[root@ststor01 blog]# git status
On branch master
Your branch is up to date with 'origin/master'.

Untracked files:
  (use "git add <file>..." to include in what will be committed)
        index.html

nothing added to commit but untracked files present (use "git add" to track) 

$git add .

[root@ststor01 blog]# git status
On branch master
Your branch is up to date with 'origin/master'.

Changes to be committed:
  (use "git restore --staged <file>..." to unstage)
        new file:   index.html

[root@ststor01 blog]# git commit -m "task4"
[master 7abd28b] task4
 1 file changed, 1 insertion(+)
 create mode 100644 index.html

[root@ststor01 blog]# git status
On branch master
Your branch is ahead of 'origin/master' by 1 commit.
  (use "git push" to publish your local commits)

nothing to commit, working tree clean

 [root@ststor01 blog]# git push origin master
Enumerating objects: 4, done.
Counting objects: 100% (4/4), done.
Delta compression using up to 36 threads
Compressing objects: 100% (2/2), done.
Writing objects: 100% (3/3), 323 bytes | 323.00 KiB/s, done.
Total 3 (delta 0), reused 0 (delta 0), pack-reused 0
To /opt/news.git
   04750cb..deca4d6  master -> master


```
