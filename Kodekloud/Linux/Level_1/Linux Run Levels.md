# Linux Run Levels

New tools have been installed on the app servers in Stratos Datacenter. Some of these tools can only be managed from the graphical user interface. Therefore, there are some requirements for these app servers as below.

On __all App servers__ in Stratos Datacenter, change the default runlevel so that they can boot in GUI (graphical user interface) by default. Please do not try to reboot these servers after completing this task.


### Решение

Нужно подключаться ко всем трем серверам: stapp01, stapp02,stapp03. Пользователи и пароли известны.
На всех серверах даю возможность sudo выполнять без пароля:
`sudo visudo`

```bash
## Allows people in group wheel to run all commands
#%wheel ALL=(ALL)       ALL

## Same thing without a password
%wheel  ALL=(ALL)       NOPASSWD: ALL
```

- смотрим /etc/inittab
```bash
# inittab is no longer used.
#
# ADDING CONFIGURATION HERE WILL HAVE NO EFFECT ON YOUR SYSTEM.
#
# Ctrl-Alt-Delete is handled by /usr/lib/systemd/system/ctrl-alt-del.target
#
# systemd uses 'targets' instead of runlevels. By default, there are two main targets:
#
# multi-user.target: analogous to runlevel 3
# graphical.target: analogous to runlevel 5
#
# To view current default target, run:
# systemctl get-default
#
# To set a default target, run:
# systemctl set-default TARGET.target
```

- `who -a`
```bash
[tony@stapp01 ~]$ who -a
           system boot  May  4 06:36
           run-level 3  May  4 06:36
tony     + pts/0        May  4 06:43   .           590 (172.16.238.3)
```

```bash
[tony@stapp01 ~]$ sudo systemctl get-default
multi-user.target

[tony@stapp01 ~]$ sudo systemctl set-default graphical.target
Removed /etc/systemd/system/default.target.
Created symlink /etc/systemd/system/default.target → /usr/lib/systemd/system/graphical.target.

[tony@stapp01 ~]$ who -a
           system boot  May  4 06:36
           run-level 3  May  4 06:36
tony     + pts/0        May  4 06:43   .           590 (172.16.238.3)

[tony@stapp01 ~]$ sudo systemctl get-default
graphical.target
```

Смотрим init --help:
```bash
[tony@stapp01 ~]$ init --help
init [OPTIONS...] {COMMAND}

Send control commands to the init daemon.

     --help      Show this help
     --no-wall   Don't send wall message before halt/power-off/reboot

Commands:
  0              Power-off the machine
  6              Reboot the machine
  2, 3, 4, 5     Start runlevelX.target unit
  1, s, S        Enter rescue mode
  q, Q           Reload init daemon configuration
  u, U           Reexecute init daemon
```

Выполняем:
```bash
[tony@stapp01 ~]$ sudo init 5
[tony@stapp01 ~]$ who -a
           system boot  May  4 06:36
           run-level 5  May  4 07:04                   last=3
tony     + pts/0        May  4 06:43   .           590 (172.16.238.3)

[tony@stapp01 ~]$ sudo systemctl daemon-reload
```
И так на всех трех серверах.



