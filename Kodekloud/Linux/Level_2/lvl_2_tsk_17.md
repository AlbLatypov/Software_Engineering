# Haproxy LBR Troubleshooting

xFusionCorp Industries has an application running on Nautlitus infrastructure in Stratos Datacenter. The monitoring tool recognised that there is an issue with the haproxy service on LBR server. That needs to fixed to make the application work properly.


Troubleshoot and fix the issue, and make sure haproxy service is running on Nautilus LBR server. Once fixed, make sure you are able to access the website using StaticApp button on the top bar.



### Решение

Подключаемся SSH, смотрим статус HAProxy

```bash

[root@stlb01 ~]# systemctl status haproxy
● haproxy.service - HAProxy Load Balancer
   Loaded: loaded (/usr/lib/systemd/system/haproxy.service; disabled; vendor preset: disabled)
   Active: inactive (dead)

May 14 21:26:38 stlb01.stratos.xfusioncorp.com systemd[1]: Collecting haproxy.service

Пытаеся стартануть сервис.

[root@stlb01 ~]# systemctl start haproxy
[root@stlb01 ~]# systemctl status haproxy
● haproxy.service - HAProxy Load Balancer
   Loaded: loaded (/usr/lib/systemd/system/haproxy.service; disabled; vendor preset: disabled)
   Active: failed (Result: exit-code) since Tue 2024-05-14 21:29:37 UTC; 3s ago
  Process: 359 ExecStart=/usr/sbin/haproxy-systemd-wrapper -f /etc/haproxy/haproxy.cfg -p /run/haproxy.pid $OPTIONS (code=exited, status=1/FAILURE)
 Main PID: 359 (code=exited, status=1/FAILURE)

May 14 21:29:37 stlb01.stratos.xfusioncorp.com haproxy-systemd-wrapper[359]: haproxy-systemd-wrapper: executing /usr/sbin/...-Ds
May 14 21:29:37 stlb01.stratos.xfusioncorp.com haproxy-systemd-wrapper[359]: [ALERT] 134/212937 (360) : Proxy 'main': unab...p'.
May 14 21:29:37 stlb01.stratos.xfusioncorp.com haproxy-systemd-wrapper[359]: [ALERT] 134/212937 (360) : Fatal errors found...on.
May 14 21:29:37 stlb01.stratos.xfusioncorp.com haproxy-systemd-wrapper[359]: haproxy-systemd-wrapper: exit, haproxy RC=1
May 14 21:29:37 stlb01.stratos.xfusioncorp.com systemd[1]: Child 359 belongs to haproxy.service
May 14 21:29:37 stlb01.stratos.xfusioncorp.com systemd[1]: haproxy.service: main process exited, code=exited, status=1/FAILURE
May 14 21:29:37 stlb01.stratos.xfusioncorp.com systemd[1]: haproxy.service changed running -> failed
May 14 21:29:37 stlb01.stratos.xfusioncorp.com systemd[1]: Unit haproxy.service entered failed state.
May 14 21:29:37 stlb01.stratos.xfusioncorp.com systemd[1]: haproxy.service failed.
May 14 21:29:37 stlb01.stratos.xfusioncorp.com systemd[1]: haproxy.service: cgroup is empty
Hint: Some lines were ellipsized, use -l to show in full.
```

Смотрим журнал
```bash
journalctl --unit=haproxy

Обрезает строки
journalctl -all --unit=haproxy

-- Logs begin at Tue 2024-05-14 21:24:38 UTC, end at Tue 2024-05-14 21:34:14 UTC. --
May 14 21:26:38 stlb01.stratos.xfusioncorp.com systemd[1]: Collecting haproxy.service
May 14 21:29:37 stlb01.stratos.xfusioncorp.com systemd[1]: Trying to enqueue job haproxy.service/start/replace
May 14 21:29:37 stlb01.stratos.xfusioncorp.com systemd[1]: Installed new job haproxy.service/start as 112
May 14 21:29:37 stlb01.stratos.xfusioncorp.com systemd[1]: Enqueued job haproxy.service/start as 112
May 14 21:29:37 stlb01.stratos.xfusioncorp.com systemd[1]: About to execute: /usr/sbin/haproxy-systemd-wrapper -f /etc/haproxy/haproxy.cfg -p /run/haproxy.pid $OPTI
ONS
May 14 21:29:37 stlb01.stratos.xfusioncorp.com systemd[1]: Forked /usr/sbin/haproxy-systemd-wrapper as 359
May 14 21:29:37 stlb01.stratos.xfusioncorp.com systemd[1]: haproxy.service changed dead -> running
May 14 21:29:37 stlb01.stratos.xfusioncorp.com systemd[1]: Job haproxy.service/start finished, result=done
May 14 21:29:37 stlb01.stratos.xfusioncorp.com systemd[1]: Started HAProxy Load Balancer.
May 14 21:29:37 stlb01.stratos.xfusioncorp.com systemd[359]: Executing: /usr/sbin/haproxy-systemd-wrapper -f /etc/haproxy/haproxy.cfg -p /run/haproxy.pid
May 14 21:29:37 stlb01.stratos.xfusioncorp.com haproxy-systemd-wrapper[359]: haproxy-systemd-wrapper: executing /usr/sbin/haproxy -f /etc/haproxy/haproxy.cfg -p /ru
n/haproxy.pid -Ds
May 14 21:29:37 stlb01.stratos.xfusioncorp.com haproxy-systemd-wrapper[359]: [ALERT] 134/212937 (360) : Proxy 'main': unable to find required default_backend: 'app'
.
May 14 21:29:37 stlb01.stratos.xfusioncorp.com haproxy-systemd-wrapper[359]: [ALERT] 134/212937 (360) : Fatal errors found in configuration.
May 14 21:29:37 stlb01.stratos.xfusioncorp.com haproxy-systemd-wrapper[359]: haproxy-systemd-wrapper: exit, haproxy RC=1
May 14 21:29:37 stlb01.stratos.xfusioncorp.com systemd[1]: Child 359 belongs to haproxy.service
May 14 21:29:37 stlb01.stratos.xfusioncorp.com systemd[1]: haproxy.service: main process exited, code=exited, status=1/FAILURE
May 14 21:29:37 stlb01.stratos.xfusioncorp.com systemd[1]: haproxy.service changed running -> failed
May 14 21:29:37 stlb01.stratos.xfusioncorp.com systemd[1]: Unit haproxy.service entered failed state.
May 14 21:29:37 stlb01.stratos.xfusioncorp.com systemd[1]: haproxy.service failed.
May 14 21:29:37 stlb01.stratos.xfusioncorp.com systemd[1]: haproxy.service: cgroup is empty
```

Говорит, что Proxy 'main': unable to find required default_backend: 'app', смотрим конфиг
```bash
/etc/haproxy/haproxy.cfg

и почему то в разделе backend ремарка

#---------------------------------------------------------------------
# round robin balancing between the various backends
#---------------------------------------------------------------------
#backend app
    balance     roundrobin
    server  app1 stapp01:3004 check
    server  app2 stapp02:3004 check
    server  app3 stapp03:3004 check

```

Убираем ремарку с backend app, стартуем сервис. Сервис запущен, все в порядке.


