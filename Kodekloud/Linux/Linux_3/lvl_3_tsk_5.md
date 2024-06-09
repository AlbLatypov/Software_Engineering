# IPtables Installation And Configuration

We have one of our websites up and running on our Nautilus infrastructure in Stratos DC. Our security team has raised a concern that right now Apache’s port i.e 8088 is open for all since there is no firewall installed on these hosts. So we have decided to add some security layer for these hosts and after discussions and recommendations we have come up with the following requirements:


1. Install iptables and all its dependencies on each app host.

2. Block incoming port 6100 on all apps for everyone except for LBR host.

3. Make sure the rules remain, even after system reboot.

### Решение

```bash
sed -i 's/mirrorlist/#mirrorlist/g' /etc/yum.repos.d/CentOS-*
sed -i 's|#baseurl=http://mirror.centos.org|baseurl=http://vault.centos.org|g' /etc/yum.repos.d/CentOS-*
yum update -y && yum install tmux bash-completion iproute -y 

yum install iptables-services -y
```

Для работы bash-completion прописать в .bashrc:
```bash
if [ -f /etc/bash_completion ]; then
 . /etc/bash_completion
fi
```

```bash
iptables -L INPUT -n -v --line-numbers
iptables -F INPUT
iptables -A INPUT -i lo -j ACCEPT
iptables -A INPUT -m state --state ESTABLISHED,RELATED -j ACCEPT
iptables -A INPUT -p tcp --dport 22 -j ACCEPT
iptables -A INPUT -s 172.16.238.14 -p tcp --dport 6100 -j ACCEPT
iptables -P INPUT DROP
service iptables save
systemctl start iptables
systemctl enable iptables


```

