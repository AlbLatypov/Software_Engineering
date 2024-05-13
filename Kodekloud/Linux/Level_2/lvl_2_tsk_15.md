# Linux Postfix Troubleshooting


Some users of the monitoring app have reported issues with xFusionCorp Industries mail server. They have a mail server in Stork DC where they are using postfix mail transfer agent. Postfix service seems to fail. Try to identify the root cause and fix it.



### Решение

Подключаемся, проверяем сервис, Выключен, стартуем, ошибка. Смотрим логи.

```bash
[root@stmail01 ~]# systemctl status postfix
● postfix.service - Postfix Mail Transport Agent
   Loaded: loaded (/usr/lib/systemd/system/postfix.service; disabled; vendor preset: disabled)
   Active: inactive (dead)

May 13 18:38:10 stmail01.stratos.xfusioncorp.com systemd[1]: postfix.service: Collecting.

[root@stmail01 ~]# systemctl start postfix
Job for postfix.service failed because the control process exited with error code.
See "systemctl status postfix.service" and "journalctl -xe" for details.
[root@stmail01 ~]# 
```
Первое, что вижу

```bash

Systemctl start postfix

May 13 18:56:48 stmail01.stratos.xfusioncorp.com postfix[914]: warning: /etc/postfix/main.cf, line 135: overriding earlier entry: inet_interfaces=all
May 13 18:56:48 stmail01.stratos.xfusioncorp.com postfix[914]: fatal: parameter inet_interfaces: no local interface found for ::1
May 13 18:56:49 stmail01.stratos.xfusioncorp.com systemd[1]: postfix.service: Child 914 belongs to postfix.service.
May 13 18:56:49 stmail01.stratos.xfusioncorp.com systemd[1]: postfix.service: Control process exited, code=exited status=1
May 13 18:56:49 stmail01.stratos.xfusioncorp.com systemd[1]: postfix.service: Got final SIGCHLD for state start.
May 13 18:56:49 stmail01.stratos.xfusioncorp.com systemd[1]: postfix.service: Failed with result 'exit-code'.
May 13 18:56:49 stmail01.stratos.xfusioncorp.com systemd[1]: postfix.service: Changed start -> failed
May 13 18:56:49 stmail01.stratos.xfusioncorp.com systemd[1]: postfix.service: Job postfix.service/start finished, result=failed
May 13 18:56:49 stmail01.stratos.xfusioncorp.com systemd[1]: Failed to start Postfix Mail Transport Agent.
May 13 18:56:49 stmail01.stratos.xfusioncorp.com systemd[1]: postfix.service: Unit entered failed state.

Был расскоменчен inet_interfaces = localhost. После этого сервис запустился.

# Note: you need to stop/start Postfix when this parameter changes.
#
inet_interfaces = all
#inet_interfaces = $myhostname
#inet_interfaces = $myhostname, localhost
#inet_interfaces = localhost

root@stmail01 log]# systemctl start postfix
[root@stmail01 log]# systemctl status postfix.service
● postfix.service - Postfix Mail Transport Agent
   Loaded: loaded (/usr/lib/systemd/system/postfix.service; disabled; vendor preset: disabled)
   Active: active (running) since Mon 2024-05-13 18:59:04 UTC; 2s ago
  Process: 1007 ExecStart=/usr/sbin/postfix start (code=exited, status=0/SUCCESS)
  Process: 1006 ExecStartPre=/usr/libexec/postfix/chroot-update (code=exited, status=0/SUCCESS)
  Process: 984 ExecStartPre=/usr/libexec/postfix/aliasesdb (code=exited, status=0/SUCCESS)
  Process: 970 ExecStartPre=/usr/sbin/restorecon -R /var/spool/postfix/pid/master.pid (code=exited, status=0/SUCCESS)
 Main PID: 1270 (master)
    Tasks: 3 (limit: 1340692)
   Memory: 14.8M
   CGroup: /docker/8e1c3cabc42ccc2ddcfa44dbbbff029d3b05d83614df143cf0eb0a56389e3a89/system.slice/postfix.service
           ├─1270 /usr/libexec/postfix/master -w
           ├─1271 pickup -l -t unix -u
           └─1272 qmgr -l -t unix -u

May 13 18:59:04 stmail01.stratos.xfusioncorp.com postfix/master[1270]: daemon started -- version 3.5.8, configuration /etc/postfix
May 13 18:59:04 stmail01.stratos.xfusioncorp.com systemd[1]: postfix.service: Child 1007 belongs to postfix.service.
May 13 18:59:04 stmail01.stratos.xfusioncorp.com systemd[1]: postfix.service: Control process exited, code=exited status=0
May 13 18:59:04 stmail01.stratos.xfusioncorp.com systemd[1]: postfix.service: Got final SIGCHLD for state start.
May 13 18:59:04 stmail01.stratos.xfusioncorp.com systemd[1]: postfix.service: New main PID 1270 belongs to service, we are happy.
May 13 18:59:04 stmail01.stratos.xfusioncorp.com systemd[1]: postfix.service: Main PID loaded: 1270
May 13 18:59:04 stmail01.stratos.xfusioncorp.com systemd[1]: postfix.service: Changed start -> running
May 13 18:59:04 stmail01.stratos.xfusioncorp.com systemd[1]: postfix.service: Job postfix.service/start finished, result=done
May 13 18:59:04 stmail01.stratos.xfusioncorp.com systemd[1]: Started Postfix Mail Transport Agent.
May 13 18:59:04 stmail01.stratos.xfusioncorp.com systemd[1]: postfix.service: Failed to send unit change signal for postfix.service: Connection reset by pe
er
[root@stmail01 log]# vi /etc/postfix/main.cf
```


