# Application Security

We have a backup management application UI hosted on Nautilus's backup server in Stratos DC. That backup management application code is deployed under Apache on the backup server itself, and Nginx is running as a reverse proxy on the same server. Apache and Nginx ports are 8085 and 8099, respectively. We have iptables firewall installed on this server. Make the appropriate changes to fulfill the requirements mentioned below:


We want to open all incoming connections to Nginx's port and block all incoming connections to Apache's port. Also make sure rules are permanent.



### Решение

Изменение дефолтной политики
`iptables -P INPUT DROP`


Разбор правила ACCEPT     all  --  *      *       0.0.0.0/0            0.0.0.0/0            ctstate RELATED,ESTABLISHED
```bash
Эта строка описывает правило в iptables, которое разрешает (ACCEPT) прохождение сетевых пакетов, если они относятся к уже установленным или связанным соединениям.

Давайте разберем каждый элемент этой строки:

    ACCEPT: действие, которое будет выполнено с пакетом, соответствующим условиям правила. В данном случае пакет будет пропущен.
    all: протокол, к которому применяется правило. all означает, что правило применяется ко всем протоколам (TCP, UDP, ICMP и т.д.).
    --: разделитель между протоколом и источником пакета.
    *: источник пакета. * означает любой источник.
    *: пункт назначения пакета. * означает любое назначение.
    0.0.0.0/0: IP-адрес источника. 0.0.0.0/0 означает любой IP-адрес.
    0.0.0.0/0: IP-адрес назначения. 0.0.0.0/0 означает любой IP-адрес.
    ctstate RELATED,ESTABLISHED: этот параметр относится к модулю conntrack и указывает, что правило применяется только к пакетам, которые относятся к уже установленным (ESTABLISHED) соединениям или связаны (RELATED) с ними.

В итоге, это правило разрешает прохождение всех пакетов, которые являются частью уже установленных соединений, или связаны с ними, независимо от протокола, источника и назначения.

Такое правило часто используется для того, чтобы разрешить ответы на исходящие запросы. Например, если ваш компьютер отправил запрос на веб-сервер, то ответ от сервера будет разрешен этим правилом, так как он связан с установленным соединением.

```


`watch -d iptables -L INPUT -n -v --line-numbers`

Вставить правило в начало цепочки:
`iptables -I INPUT -s 192.168.34.37 -j ACCEPT`

Удалить правило 3
`iptables -D INPUT 3` 

Разрешить соединение на tcp порт всем.
`iptables -A INPUT -p tcp --destination-port 22 -j ACCEPT`

Добавить в начало -I правило разрешить на 8094 всем
`iptables -I INPUT -p tcp --dport 8094 -m comment --comment "accept nginx" -j ACCEPT`

Вставить правило на определеное место, в данном случае 2:
`sudo iptables -I INPUT 2 -p icmp -j REJECT`

Добавить вторым правилом 
`iptables -I  INPUT 2 -p tcp --dport 8084 -m comment --comment "drop apache" -j DROP`

Заменить
Команда iptables -R INPUT 5 -p icmp -j REJECT имеет следующее значение:

    -R INPUT 5: -R стоит для replace, что значит "заменить". Это заменяет правило под номером 5 в цепочке INPUT.

    -p icmp: Это указывает, что правило применяется к ICMP-пакетам. ICMP - это протокол, используемый для отправки сообщений об ошибках и операционной информации, такой как "echo request" (используемый в команде ping) или "destination unreachable".

    -j REJECT: Это говорит iptables отклонить пакеты, которые соответствуют этому правилу. REJECT - это одно из возможных действий, которые iptables может предпринять, и оно означает, что пакет будет отклонен и не будет обработан дальше.

В совокупности, эта команда говорит iptables заменить правило номер 5 в цепочке INPUT на новое правило, которое отклоняет все ICMP-пакеты.


Сохранить конфигурацию
`service iptables save`

Чтобы разрешить все входящие TCP-соединения на порт 8000 в iptables и добавить комментарий "vla", вы можете использовать следующую команду:

sudo iptables -A INPUT -p tcp --dport 8000 -m comment --comment "vla" -j ACCEPT

В этой команде:

    -A INPUT добавляет правило в цепочку INPUT.
    -p tcp указывает на протокол TCP.
    --dport 8000 указывает на порт 8000.
    -m comment --comment "vla" добавляет комментарий "vla" к правилу.
    -j ACCEPT указывает действие, которое следует принять для пакетов, соответствующих правилу (в данном случае, принять их).

```




