# Selinux Installation

The xFusionCorp Industries security team recently did a security audit of their infrastructure and came up with ideas to improve the application and server security. They decided to use SElinux for an additional security layer. They are still planning how they will implement it; however, they have decided to start testing with app servers, so based on the recommendations they have the following requirements:


Install the required packages of SElinux on App server 3 in Stratos Datacenter and disable it permanently for now; it will be enabled after making some required configuration changes on this host. Don't worry about rebooting the server as there is already a reboot scheduled for tonight's maintenance window. Also ignore the status of SElinux command line right now; the final status after reboot should be __disabled__.


### Решение

Сервер stapp03, пользователь banner, подключение по SSH
`ssh banner@stapp93`

Вношу изменения 
`sudo visudo` , чтобы wheel могли работать без запроса пароля sudo, а то запарно на стендовом сервере постоянно авторизовываться.

Честно говоря, никогда не ставил SElinux. Воспользовался chatgpt

```bash
[banner@stapp03 ~]$ sudo yum install selinux-policy \
selinux-policy-targeted libselinux-utils \
setroubleshoot-server setools setools-console mcstrans
```

Проверяю наличие конфига и статус:
```bash
[banner@stapp03 ~]$ ls -la /etc/selinux/config
-rw-r--r-- 1 root root 548 May  4 09:16 /etc/selinux/config
[banner@stapp03 ~]$ sudo sestatus
SELinux status:                 disabled
```

Вроде все. Подтверждаю выполнение. Неверно!!!

`- required state of 'SElinux' does not match on App Server 3`

Пробую еще раз...

Вообщем нужно было все таки поправить конфиг:
```bash

# This file controls the state of SELinux on the system.
# SELINUX= can take one of these three values:
#     enforcing - SELinux security policy is enforced.
#     permissive - SELinux prints warnings instead of enforcing.
#     disabled - No SELinux policy is loaded.

#SELINUX=enforcing
SELINUX=disabled

# SELINUXTYPE= can take one of these three values:
#     targeted - Targeted processes are protected,
#     minimum - Modification of targeted policy. Only selected processes are protected.
#     mls - Multi Level Security protection.
SELINUXTYPE=targeted
```
Засчитано!!
