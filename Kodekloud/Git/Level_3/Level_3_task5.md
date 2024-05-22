### Git Stash

The Nautilus application development team was working on a git repository /usr/src/kodekloudrepos/ecommerce present on Storage server in Stratos DC. One of the developers stashed some in-progress changes in this repository, but now they want to restore some of the stashed changes. Find below more details to accomplish this task:



Look for the stashed changes under /usr/src/kodekloudrepos/ecommerce git repository, and restore the stash with stash@{1} identifier. Further, commit and push your changes to the origin.


### Решение

Подключаемся. Смотрим, что в листе stash
```bash
[root@ststor01 ecommerce]# git stash list
stash@{0}: WIP on master: 32f8717 initial commit
stash@{1}: WIP on master: 32f8717 initial commit

[root@ststor01 ecommerce]# git stash pop --index 1
```
