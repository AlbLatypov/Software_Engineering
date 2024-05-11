# Linux Configure sudo


We have some users on all app servers in Stratos Datacenter. Some of them have been assigned some new roles and responsibilities, therefore their users need to be upgraded with sudo access so that they can perform admin level tasks.


a. Provide sudo access to user ravi on all app servers.

b. Make sure you have set up password-less sudo for the user.



### Решение

Нужно сделать sudo без пароля для ravi.

```bash
На первом сервере пользователь уже заведен. Допускаю, что и на остальных также

[root@stapp01 ~]# cat /etc/group
wheel:x:10:ansible,tony
ansible:x:1000:
tony:x:1001:
ravi:x:1002:

в группе wheel не состоит. Добавим

[root@stapp01 ~]# sudo usermod -aG wheel ravi

Правим visudo для выполнения sudo без пароля. Закоментил группу wheel без NOPASSWD. Пускай все члены ходят теперь без пароля!=)

[root@stapp01 ~]# sudo visudo

## Allows people in group wheel to run all commands
#%wheel ALL=(ALL)       ALL

## Same thing without a password
%wheel  ALL=(ALL)       NOPASSWD: ALL

Заходим под ravi и пробуем открыть visudo

[root@stapp01 ~]# su - ravi
[ravi@stapp01 ~]$ sudo visudo
visudo: /etc/sudoers.tmp unchanged
```

По идее все. Делаем так для всех серверов.



