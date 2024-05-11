# Install a package

As per new application requirements shared by the Nautilus project development team, serveral new packages need to be installed on all app servers in Stratos Datacenter. Most of them are completed except for samba.


Therefore, install the samba package on all app-servers.


### Решение

На 3х серверах установить samba. Отражаю только для одного. Идентично.

```bash

[tony@stapp01 ~]$ sudo yum update
[tony@stapp01 ~]$ sudo yum install samba
```



