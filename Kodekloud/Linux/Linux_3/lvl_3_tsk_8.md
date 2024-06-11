# Linux Process Troubleshooting
The production support team of xFusionCorp Industries has deployed some of the latest monitoring tools to keep an eye on every service, application, etc. running on the systems. One of the monitoring systems reported about Apache service unavailability on one of the app servers in Stratos DC.


Identify the faulty app host and fix the issue. Make sure Apache service is up and running on all app hosts. They might not hosted any code yet on these servers so you need not to worry about if Apache isn't serving any pages or not, just make sure service is up and running. Also, make sure Apache is running on port 5004 on all app servers.


### Решение

Проверить открыть или закрыт порт без всяких утилит можно так. 
``` bash
thor@jumphost ~$ :>/dev/tcp/stapp01/5004;echo $?
bash: connect: Connection refused
bash: /dev/tcp/stapp01/5004: Connection refused
1
thor@jumphost ~$ :>/dev/tcp/stapp02/5004;echo $?
0
thor@jumphost ~$ :>/dev/tcp/stapp03/5004;echo $?
0
thor@jumphost ~$ 
```

Юнит senmail запущен на том же порту, что и httpd. Посмотреть информацию по unit

```bash
[root@stapp01 ~]# systemctl edit --full --force sendmail

[Unit]
Description=Sendmail Mail Transport Agent
After=syslog.target network.target
Conflicts=postfix.service exim.service
Wants=sm-client.service

[Service]
Type=forking
StartLimitInterval=0
PIDFile=/run/sendmail.pid
Environment=SENDMAIL_OPTS=-q1h
EnvironmentFile=-/etc/sysconfig/sendmail
ExecStartPre=-/etc/mail/make
ExecStartPre=-/etc/mail/make aliases
ExecStart=/usr/sbin/sendmail -bd $SENDMAIL_OPTS $SENDMAIL_OPTARG

[Install]
WantedBy=multi-user.target
Also=sm-client.service
```

Смотрю сервисы, увидел такую ошибку, загуглил.
`● network.service                                   loaded failed failed    LSB: Bring up/down networking`

Решение:

Нужно создать пустой файл network в директории /etc/sysconfig.

`touch /etc/sysconfig/network`

Перезапускаем сеть:

`systemctl restart network`

Ошибок нет, сеть поднялась.

Вообщем. Посмотрел через SS, кто что слушает и убил процесс, который висел на порту 5004
`kill -15 674`
