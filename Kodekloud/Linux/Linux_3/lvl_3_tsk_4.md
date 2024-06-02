# Linux Network Services

Our monitoring tool has reported an issue in Stratos Datacenter. One of our app servers has an issue, as its Apache service is not reachable on port 5003 (which is the Apache port). The service itself could be down, the firewall could be at fault, or something else could be causing the issue.


Use tools like telnet, netstat, etc. to find and fix the issue. Also make sure Apache is reachable from the jump host without compromising any security settings.

Once fixed, you can test the same using command curl http://stapp01:5003 command from jump host.

### Решение

Проверяем Apache:
```bash
thor@jump_host ~$ curl http://stapp01:5003
curl: (7) Failed to connect to stapp01 port 5003: No route to host
```

Идем на сервер, состояние службы httpd, логи:
```bash
[root@stapp01 conf]# systemctl status httpd
● httpd.service - The Apache HTTP Server
   Loaded: loaded (/usr/lib/systemd/system/httpd.service; disabled; vendor preset: disabled)
   Active: failed (Result: exit-code) since Sun 2024-06-02 15:21:33 UTC; 6min ago
     Docs: man:httpd.service(8)
  Process: 748 ExecStart=/usr/sbin/httpd $OPTIONS -DFOREGROUND (code=exited, status=1/FAILURE)
 Main PID: 748 (code=exited, status=1/FAILURE)
   Status: "Reading configuration..."

Jun 02 15:21:33 stapp01.stratos.xfusioncorp.com httpd[748]: (98)Address already in use: AH00072: make_sock: could not bind to ad
dress 0.0.0.0:5003
```

```bash
[root@stapp01 conf]# journalctl -u httpd
Jun 02 15:21:33 stapp01.stratos.xfusioncorp.com httpd[748]: AH00558: httpd: Could not reliably determine the server's fully qualified domain name, using stapp01.s
tratos.xfusioncorp.com. Set the 'ServerName' directive globally to suppress this message
Jun 02 15:21:33 stapp01.stratos.xfusioncorp.com httpd[748]: (98)Address already in use: AH00072: make_sock: could not bind to address 0.0.0.0:5003
Jun 02 15:21:33 stapp01.stratos.xfusioncorp.com httpd[748]: no listening sockets available, shutting down
```
Смотрим netstat. Порт 5003 уже занят процессом 685-sendmail.
```bash
[root@stapp01 conf]# netstat -atlpn
Active Internet connections (servers and established)
Proto Recv-Q Send-Q Local Address           Foreign Address         State       PID/Program name    
tcp        0      0 127.0.0.1:5003          0.0.0.0:*               LISTEN      685/sendmail: accep 
tcp        0      0 0.0.0.0:22              0.0.0.0:*               LISTEN      542/sshd            
tcp        0      0 127.0.0.11:33829        0.0.0.0:*               LISTEN      -                   
tcp        0      0 172.16.238.10:22        172.16.238.3:36402      ESTABLISHED 815/sshd: tony [pri 
tcp6       0      0 :::22                   :::*                    LISTEN      542/sshd   
```

Нам он не нужен. Остановим сервис и проверим.

Проверил правила iptables. Одно запрещающее удалил. Провеяем.
`[root@stapp01 html]# iptables -D INPUT 5`



