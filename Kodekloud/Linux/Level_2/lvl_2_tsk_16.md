# Install and Configure Ha Proxy LBR

There is a static website running in Stratos Datacenter. They have already configured the app servers and code is already deployed there. To make it work properly, they need to configure LBR server. There are number of options for that, but team has decided to go with HAproxy. FYI, apache is running on port 3004 on all app servers. Complete this task as per below details.


a. Install and configure HAproxy on LBR server using yum only and make sure all app servers are added to HAproxy load balancer. HAproxy must serve on default http port (Note: Please do not remove stats socket /var/lib/haproxy/stats entry from haproxy default config.).

b. Once done, you can access the website using StaticApp button on the top bar.

### Решение

Дополнительно по [Install and Configure Ha Proxy LBR](../docs/Install%20and%20Configure%20Ha%20Proxy%20LBR.md)

Подключаемся впервые к новому серверу stlb01 и получаем рут

```bash
thor@jump_host ~$ ssh loki@stlb01
sudo -i

Установим iproute для ss

[root@stlb01 ~]# yum install iproute

[root@stlb01 ~]# rpm -qa | grep -i "HAproxy"

Не установлен. Устанавливаем:

[root@stlb01 ~]# rpm -qa | grep -i "HAproxy"
haproxy-1.8.27-5.el8.x86_64

[root@stlb01 ~]# ss -atlnp
State      Recv-Q      Send-Q           Local Address:Port            Peer Address:Port     Process                             
LISTEN     0           4096                127.0.0.11:38867                0.0.0.0:*                                            
LISTEN     0           128                    0.0.0.0:22                   0.0.0.0:*         users:(("sshd",pid=2327,fd=3))     
LISTEN     0           128                       [::]:22                      [::]:*         users:(("sshd",pid=2327,fd=4)) 

Смотрим и корректируем файл конфигурации /etc/haproxy/haproxy.cfg

Изменил на порт 80

#---------------------------------------------------------------------
# main frontend which proxys to the backends
#---------------------------------------------------------------------
frontend main
    bind *:80


Прописал сервера app
#---------------------------------------------------------------------
# round robin balancing between the various backends
#---------------------------------------------------------------------
backend app
    balance     roundrobin
    server  stapp1 172.16.238.10:3004 check
    server  stapp2 172.16.238.11:3004 check
    server  stapp3 172.16.238.12:3004 check

Проверяем файл конфигурации

[root@stlb01 ~]# haproxy -c -f /etc/haproxy/haproxy.cfg
Configuration file is valid


[root@stlb01 ~]# systemctl restart haproxy

[root@stlb01 ~]# systemctl status haproxy
● haproxy.service - HAProxy Load Balancer
   Loaded: loaded (/usr/lib/systemd/system/haproxy.service; disabled; vendor preset: disabled)
   Active: active (running) since Tue 2024-05-14 21:07:58 UTC; 7s ago
  Process: 3153 ExecStartPre=/usr/sbin/haproxy -f $CONFIG -f $CFGDIR -c -q $OPTIONS (code=exited, status=0/SUCCESS)
 Main PID: 3180 (haproxy)
    Tasks: 2 (limit: 1340692)
   Memory: 4.1M
   CGroup: /docker/2a06e5ac14567a1a12633f634f429dd2c48c4769a51338f1ec3e9ea72508fc66/system.slice/haproxy.service
           ├─3180 /usr/sbin/haproxy -Ws -f /etc/haproxy/haproxy.cfg -f /etc/haproxy/conf.d -p /run/haproxy.pid
           └─3194 /usr/sbin/haproxy -Ws -f /etc/haproxy/haproxy.cfg -f /etc/haproxy/conf.d -p /run/haproxy.pid

May 14 21:07:58 stlb01.stratos.xfusioncorp.com systemd[1]: Starting HAProxy Load Balancer...
May 14 21:07:58 stlb01.stratos.xfusioncorp.com systemd[1]: Started HAProxy Load Balancer.
[root@stlb01 ~]# 
```



