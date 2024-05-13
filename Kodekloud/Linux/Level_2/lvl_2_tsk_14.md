# Linux Postfix Mail Server

xFusionCorp Industries has planned to set up a common email server in Stork DC. After several meetings and recommendations they have decided to use postfix as their mail transfer agent and dovecot as an IMAP/POP3 server. We would like you to perform the following steps:


1. Install and configure postfix on Stork DC mail server.

2. Create an email account kirsty@stratos.xfusioncorp.com identified by GyQkFRVNr3.

3. Set its mail directory to /home/kirsty/Maildir.

4. Install and configure dovecot on the same server.



### Решение

Ранее подобного не проделывал. Гуглим, чат gpt

```bash
Подключаемся к серверу. Ранее не был на нем.

thor@jump_host ~$ cat /etc/hosts
127.0.0.1       localhost
172.16.238.17   stmail01
172.16.238.3    jump_host.stratos.xfusioncorp.com jump_host
172.16.239.3    jump_host.stratos.xfusioncorp.com jump_host
172.17.0.5      jump_host.stratos.xfusioncorp.com jump_host

thor@jump_host ~$ ssh groot@stmail01

[groot@stmail01 ~]$ sudo visudo

Устанавливаем запрашиваемое:
[groot@stmail01 ~]$ sudo yum -y update && sudo yum install -y postfix && sudo yum install -y dovecot

[groot@stmail01 ~]$ rpm -qa | grep -E "dovecot|postfix"
postfix-3.5.8-7.el8.x86_64
dovecot-2.3.16-5.el8.x86_64

Открываем файл /etc/postfix/main.cf и вносим следующие изменения:

Добавляем myhostname

# INTERNET HOST AND DOMAIN NAMES
#
# The myhostname parameter specifies the internet hostname of this
# mail system. The default is to use the fully-qualified domain name
# from gethostname(). $myhostname is used as a default value for many
# other configuration parameters.
#
#myhostname = host.domain.tld
#myhostname = virtual.domain.tld
myhostname = stmail01.stratos.xfusioncorp.com

Добавляем mydomain

# The mydomain parameter specifies the local internet domain name.
# The default is to use $myhostname minus the first component.
# $mydomain is used as a default value for many other configuration
# parameters.
#
#mydomain = domain.tld
mydomain = stratos.xfusioncorp.com

myorigin = $mydomain убираем из закомменченных полей.

# SENDING MAIL
#
# The myorigin parameter specifies the domain that locally-posted
# mail appears to come from. The default is to append $myhostname,
# which is fine for small sites.  If you run a domain with multiple
# machines, you should (1) change this to $mydomain and (2) set up
# a domain-wide alias database that aliases each user to
# user@that.users.mailhost.
#
# For the sake of consistency between sender and recipient addresses,
# myorigin also specifies the default domain name that is appended
# to recipient addresses that have no @domain part.
#
#myorigin = $myhostname
myorigin = $mydomain

inet_inerfaces = all, осталяем all, если был включен localhost - комментим

# RECEIVING MAIL

# The inet_interfaces parameter specifies the network interface
# addresses that this mail system receives mail on.  By default,
# the software claims all active interfaces on the machine. The
# parameter also controls delivery of mail to user@[ip.address].
#
# See also the proxy_interfaces parameter, for network addresses that
# are forwarded to us via a proxy or network address translator.
#
# Note: you need to stop/start Postfix when this parameter changes.
#
inet_interfaces = all
#inet_interfaces = $myhostname
#inet_interfaces = $myhostname, localhost
#inet_interfaces = localhost


Оставляем только указанную запись mydestination = $myhostname, localhost.$mydomain, localhost, $mydomain

# See also below, section "REJECTING MAIL FOR UNKNOWN LOCAL USERS".
#
#mydestination = $myhostname, localhost.$mydomain, localhost
mydestination = $myhostname, localhost.$mydomain, localhost, $mydomain
#mydestination = $myhostname, localhost.$mydomain, localhost, $mydomain,

прописываем сеть

# You can also specify the absolute pathname of a pattern file instead
# of listing the patterns here. Specify type:table for table-based lookups
# (the value on the table right-hand side is not used).
#
mynetworks = 172.16.238.0/24, 127.0.0.0/8
#mynetworks = $config_directory/mynetworks
#mynetworks = hash:/etc/postfix/network_table

Расскоменчиваем. Соответствует каталогу из задания

# DELIVERY TO MAILBOX
#
# The home_mailbox parameter specifies the optional pathname of a
# mailbox file relative to a user's home directory. The default
# mailbox file is /var/spool/mail/user or /var/mail/user.  Specify
# "Maildir/" for qmail-style delivery (the / is required).
#
#home_mailbox = Mailbox
home_mailbox = Maildir/

сохраняем

Стартуем postfix и проверяем статус службы

[root@stmail01 ~]# systemctl start postfix

[root@stmail01 ~]# systemctl status postfix
● postfix.service - Postfix Mail Transport Agent
   Loaded: loaded (/usr/lib/systemd/system/postfix.service; disabled; vendor preset: disabled)
   Active: active (running) since Mon 2024-05-13 17:38:11 UTC; 12s ago
  Process: 3659 ExecStart=/usr/sbin/postfix start (code=exited, status=0/SUCCESS)
  Process: 3658 ExecStartPre=/usr/libexec/postfix/chroot-update (code=exited, status=0/SUCCESS)
  Process: 3636 ExecStartPre=/usr/libexec/postfix/aliasesdb (code=exited, status=0/SUCCESS)
  Process: 3623 ExecStartPre=/usr/sbin/restorecon -R /var/spool/postfix/pid (code=exited, status=0/SUCCESS)
 Main PID: 3922 (master)
    Tasks: 3 (limit: 1340692)
   Memory: 16.3M
   CGroup: /docker/152e2ca256c19251a5786872aa1a3855c0e1eac1aa619c100c51940eed603605/system.slice/postfix.service
           ├─3922 /usr/libexec/postfix/master -w
           ├─3923 pickup -l -t unix -u
           └─3924 qmgr -l -t unix -u

May 13 17:38:10 stmail01.stratos.xfusioncorp.com systemd[1]: Starting Postfix Mail Transport Agent...
May 13 17:38:11 stmail01.stratos.xfusioncorp.com postfix/postfix-script[3908]: starting the Postfix mail system
May 13 17:38:11 stmail01.stratos.xfusioncorp.com postfix/master[3922]: daemon started -- version 3.5.8, configuration /etc/postfix
May 13 17:38:11 stmail01.stratos.xfusioncorp.com systemd[1]: Started Postfix Mail Transport Agent.

Добавляем пользователя:

[root@stmail01 ~]# useradd -m -s /bin/bash kirsty
[root@stmail01 ~]# tail /etc/passwd

Так можно отправить почту:

[root@stmail01 ~]# telnet stmail01 25
Trying 172.16.238.17...
Connected to stmail01.
Escape character is '^]'.
220 stmail01.stratos.xfusioncorp.com ESMTP Postfix
EHLO localost
250-stmail01.stratos.xfusioncorp.com
250-PIPELINING
250-SIZE 10240000
250-VRFY
250-ETRN
250-STARTTLS
250-ENHANCEDSTATUSCODES
250-8BITMIME
250-DSN
250 SMTPUTF8
mail from: ammar@stratos.xfusioncorp.com
250 2.1.0 Ok
rcpt to: ammar@stratos.xfusioncorp.com
250 2.1.5 Ok
DATA 
354 End data with <CR><LF>.<CR><LF>
test mail
.
250 2.0.0 Ok: queued as 9E6E36955E6C
quit
221 2.0.0 Bye
Connection closed by foreign host.

Теперь в директории пользователя должно быть письмо. Можно перейти и проверить. Я проверил, норм.

Настройка dovecot

vi /etc/dovecot/dovecot.conf

убираем коммент с protocols и сохраняем

# Protocols we want to be serving.
protocols = imap pop3 lmtp submission

vi /etc/dovecot/conf.d/10-mail.conf

Раскомменчиваем и сохраняем

# See doc/wiki/Variables.txt for full list. Some examples:
#
   mail_location = maildir:~/Maildir
#   mail_location = mbox:~/mail:INBOX=/var/mail/%u
#   mail_location = mbox:/var/mail/%d/%1n/%n:INDEX=/var/indexes/%d/%1n/%n

vi /etc/dovecot/conf.d/10-auth.conf

# Disable LOGIN command and all other plaintext authentications unless
# SSL/TLS is used (LOGINDISABLED capability). Note that if the remote IP
# matches the local IP (ie. you're connecting from the same computer), the
# connection is considered secure and plaintext authentication is allowed.
# See also ssl=required setting.
disable_plaintext_auth = yes

# Space separated list of wanted authentication mechanisms:
#   plain login digest-md5 cram-md5 ntlm rpa apop anonymous gssapi otp
#   gss-spnego
# NOTE: See also disable_plaintext_auth setting.
auth_mechanisms = plain login

vi /etc/dovecot/conf.d/10-master.conf

service auth {
  # auth_socket_path points to this userdb socket by default. It's typically
  # used by dovecot-lda, doveadm, possibly imap process, etc. Users that have
  # full permissions to this socket are able to get a list of all usernames and
  # get the results of everyone's userdb lookups.
  #
  # The default 0666 mode allows anyone to connect to the socket, but the
  # userdb lookups will succeed only if the userdb returns an "uid" field that
  # matches the caller process's UID. Also if caller's uid or gid matches the
  # socket's uid or gid the lookup succeeds. Anything else causes a failure.
  #
  # To give the caller full permissions to lookup all users, set the mode to
  # something else than 0666 and Dovecot lets the kernel enforce the
  # permissions (e.g. 0777 allows everyone full permissions).
  unix_listener auth-userdb {
    #mode = 0666
    user = postfix
    group = potsfix
  }

  [root@stmail01 ~]# systemctl start dovecot

  Проверяем 

  [root@stmail01 ~]# telnet stmail01 110
Trying 172.16.238.17...
Connected to stmail01.
Escape character is '^]'.
+OK Dovecot ready.
user ammar
+OK
pass
-ERR [AUTH] Authentication failed.
pass ksH85UJjhb
-ERR No username given.
quit
+OK Logging out
Connection closed by foreign host.
[root@stmail01 ~]# telnet stmail01 110
Trying 172.16.238.17...
Connected to stmail01.
Escape character is '^]'.
+OK Dovecot ready.
user ammar
+OK
pass ksH85UJjhb
+OK Logged in.
retr 1
+OK 512 octets
Return-Path: <ammar@stratos.xfusioncorp.com>
X-Original-To: ammar@stratos.xfusioncorp.com
Delivered-To: ammar@stratos.xfusioncorp.com
Received: from localost (stmail01 [172.16.238.17])
        by stmail01.stratos.xfusioncorp.com (Postfix) with ESMTP id 9E6E36955E6C
        for <ammar@stratos.xfusioncorp.com>; Mon, 13 May 2024 18:20:30 +0000 (UTC)
Message-Id: <20240513182045.9E6E36955E6C@stmail01.stratos.xfusioncorp.com>
Date: Mon, 13 May 2024 18:20:30 +0000 (UTC)
From: ammar@stratos.xfusioncorp.com

test mail
.
quit
```

ВЕРНО! Но это конечно забавно!


