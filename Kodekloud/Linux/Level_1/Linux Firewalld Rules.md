# Linux Firewalld Rules

The Nautilus system admins team recently deployed a web UI application for their backup utility running on the Nautilus backup server in Stratos Datacenter. The application is running on port 8088. They have firewalld installed on that server. The requirements that have come up include the following:


Open all incoming connection on 8088/tcp port. Zone should be public.

### Решение

Теперь backup сервер stbkp01 

Состояние:
```bash
[clint@stbkp01 ~]$ sudo firewall-cmd --state
running
```

Смотрим:
```bash
[clint@stbkp01 ~]$ sudo firewall-cmd --zone=public --list-all
public
  target: default
  icmp-block-inversion: no
  interfaces: 
  sources: 
  services: dhcpv6-client ssh
  ports: 
  protocols: 
  masquerade: no
  forward-ports: 
  source-ports: 
  icmp-blocks: 
  rich rules: 

[clint@stbkp01 ~]$ sudo firewall-cmd --zone=public --list-port
```

Добавляем порт перманентно:
```bash
[clint@stbkp01 ~]$ sudo firewall-cmd --zone=public --add-port=8088/tcp --permanent
success
[clint@stbkp01 ~]$ sudo firewall-cmd --reload
success
[clint@stbkp01 ~]$ sudo firewall-cmd --list-all
public
  target: default
  icmp-block-inversion: no
  interfaces: 
  sources: 
  services: dhcpv6-client ssh
  ports: 8088/tcp
  protocols: [clint@stbkp01 ~]$ sudo firewall-cmd --state
running
```
