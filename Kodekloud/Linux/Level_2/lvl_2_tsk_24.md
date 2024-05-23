# Application Security

We have a backup management application UI hosted on Nautilus's backup server in Stratos DC. That backup management application code is deployed under Apache on the backup server itself, and Nginx is running as a reverse proxy on the same server. _Apache_ and __Nginx__ ports are _6400_ and __8096__, respectively. We have iptables firewall installed on this server. Make the appropriate changes to fulfill the requirements mentioned below:


We want to open all incoming connections to Nginx's port and block all incoming connections to Apache's port. Also make sure rules are permanent.




### Решение

Подключаемся к серверу, смотрим:

```bash
[root@stbkp01 ~]# ss -atlpn
State      Recv-Q Send-Q                   Local Address:Port                                  Peer Address:Port              
LISTEN     0      511                                  *:80                                               *:*  
```

nginx работает на 80 порту. Не соответствует условиям. Вносим изменения в конфиг. Меняем порт на 8096, ipv6 не слушаем... Apache работает на 6400, как и в условии.
```bash
    server {
        listen       8096;
        #listen       [::]:80;
        server_name  _;
        root         /usr/share/nginx/html;
```

`[root@stbkp01 ~]# systemctl restart nginx`

Смотрим правила для INPUT iptables `watch -d iptables -L INPUT -n -v --line-numbers`:
```bash
Chain INPUT (policy ACCEPT 0 packets, 0 bytes)
num   pkts bytes target     prot opt in     out     source               destination
1      682 54306 ACCEPT     all  --  *      *       0.0.0.0/0            0.0.0.0/0            ctstate RELATED,ESTABLISHED
2        4   284 ACCEPT     all  --  lo     *       0.0.0.0/0            0.0.0.0/0
3        2   120 INPUT_direct  all  --  *      *       0.0.0.0/0            0.0.0.0/0
4        2   120 INPUT_ZONES_SOURCE  all  --  *      *       0.0.0.0/0            0.0.0.0/0
5        2   120 INPUT_ZONES  all  --  *      *       0.0.0.0/0            0.0.0.0/0
6        0     0 DROP       all  --  *      *       0.0.0.0/0            0.0.0.0/0            ctstate INVALID
7        0     0 REJECT     all  --  *      *       0.0.0.0/0            0.0.0.0/0            reject-with icmp-host-prohibited

```

Добавлю 3 и 4 правилом:

`iptables -I INPUT 3 -p tcp --dport 8096 -m comment --comment "accept nginx" -j ACCEPT`
`iptables -I INPUT 4 -p tcp --dport 6400 -m comment --comment "drop apache" -j DROP`

До и после применения правил:
```bash
thor@jump_host ~$ telnet stbkp01 8096
Trying 172.16.238.16...
telnet: connect to address 172.16.238.16: No route to host

thor@jump_host ~$ telnet stbkp01 8096
Trying 172.16.238.16...
Connected to stbkp01.
Escape character is '^]'.

Chain INPUT (policy ACCEPT 0 packets, 0 bytes)
num   pkts bytes target     prot opt in     out     source               destination
1     1293 87026 ACCEPT     all  --  *      *       0.0.0.0/0            0.0.0.0/0            ctstate RELATED,ESTABLISHED
2        4   284 ACCEPT     all  --  lo     *       0.0.0.0/0            0.0.0.0/0
3        1    60 ACCEPT     tcp  --  *      *       0.0.0.0/0            0.0.0.0/0            tcp dpt:8096 /* accept nginx */
4        0     0 DROP       tcp  --  *      *       0.0.0.0/0            0.0.0.0/0            tcp dpt:6400 /* drop apache */
5        4   240 INPUT_direct  all  --  *      *       0.0.0.0/0            0.0.0.0/0
6        4   240 INPUT_ZONES_SOURCE  all  --  *      *       0.0.0.0/0            0.0.0.0/0
7        4   240 INPUT_ZONES  all  --  *      *       0.0.0.0/0            0.0.0.0/0
8        0     0 DROP       all  --  *      *       0.0.0.0/0            0.0.0.0/0            ctstate INVALID
9        2   120 REJECT     all  --  *      *       0.0.0.0/0            0.0.0.0/0            reject-with icmp-host-prohibited
```
Сохраним правила:
```bash
[root@stbkp01 ~]# service iptables save
iptables: Saving firewall rules to /etc/sysconfig/iptables:[  OK  ]
```




