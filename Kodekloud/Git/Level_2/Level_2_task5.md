### Git Revert Some Changes

The Nautilus application development team was working on a git repository /usr/src/kodekloudrepos/news present on Storage server in Stratos DC. However, they reported an issue with the recent commits being pushed to this repo. They have asked the DevOps team to revert repo HEAD to last commit. Below are more details about the task:

- In /usr/src/kodekloudrepos/news git repository, revert the latest commit ( HEAD ) to the previous commit (JFYI the previous commit hash should be with initial commit message ).

- Use revert news message (please use all small letters for commit message) for the new revert commit.



### Решение

Авторизовались, получили рут, смотрим репозиторий:

```bash 
[root@ststor01 ~]# cd /usr/src/kodekloudrepos/news

[root@ststor01 news]# git config alias.s "status"
[root@ststor01 news]# git config alias.b "branch -v"

[root@ststor01 news]# git s
On branch master
Your branch is up to date with 'origin/master'.

Untracked files:
  (use "git add <file>..." to include in what will be committed)
        news.txt

nothing added to commit but untracked files present (use "git add" to track)

[root@ststor01 news]# git log --pretty=oneline
9771b02aee0117d293c2ec74de05d919e98d89a5 (HEAD -> master, origin/master) add data.txt file
9578561de9b6c805b8bd4abc71ce45b3d42e176b initial commit
```

Делаем revert

```bash
[root@ststor01 news]# git revert HEAD
[master 78ebe07] Revert "revert news"
 1 file changed, 1 insertion(+)
 create mode 100644 info.txt

 [root@ststor01 news]# git log --pretty=oneline
78ebe0755a1b43878b86471a0167d05c37084c56 (HEAD -> master) Revert "revert news"
9771b02aee0117d293c2ec74de05d919e98d89a5 (origin/master) add data.txt file
9578561de9b6c805b8bd4abc71ce45b3d42e176b initial commit
```


