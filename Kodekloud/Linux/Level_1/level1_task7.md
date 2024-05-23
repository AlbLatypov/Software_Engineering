# Secure Root SSH Access

Following security audits, the xFusionCorp Industries security team has rolled out new protocols, including the restriction of direct root SSH login.

Your task is to disable direct SSH root login on all app servers within the Stratos Datacenter.

### Решение

В конфигурации /etc/ssh/sshd_config изменить:

Проверяем правильность работы однострочника:

`[root@stapp03 ~]# cat /etc/ssh/sshd_config | grep -v "\#" | sed "s/PermitRootLogin yes/PermitRootLogin no/g"`

Делаем изменения в файле:

`root@stapp03 ~]# sed -i "s/PermitRootLogin yes/PermitRootLogin no/g" /etc/ssh/sshd_config`

Последняя проверка:
```bash
[root@stapp03 ~]# grep -i "permitroot" /etc/ssh/sshd_config
PermitRootLogin no
```

Рестарт сервиса:

`systemctl restart sshd`
