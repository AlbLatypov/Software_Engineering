# Linux String Substitute

## task:

The backup server in the Stratos DC contains several template XML files used by the Nautilus application. However, these template XML files must be populated with valid data before they can be used. One of the daily tasks of a system admin working in the xFusionCorp industries is to apply string and file manipulation commands!


Replace all occurances of the string __Text__ to __Maritime__ on the XML file __/root/nautilus.xml__ located in the backup server.

### Решение

stbkp01 172.16.238.16 Nautilus Backup Server
user:clint 	
password: H@wk3y3
```bash
thor@jump_host ~$ history 
    1  ssh-keygen 
    2  ssh-copy-id clint@stbkp01
    3  ssh clint@stbkp01
```
Файл находится в рутовом каталоге, проверим сможем ли провалиться туда
```bash
[clint@stbkp01 ~]$ groups
clint wheel
``` 
Файл не маленький, руками не поправишь, да и не в этом суть задачи\
`[clint@stbkp01 ~]$ sudo cat /root/nautilus.xml`

Делаю резервную копию, на всякий случай:\
`[clint@stbkp01 ~]$ sudo cp /root/nautilus.xml /root/nautilus.xml.bak`

__SED__\
`sudo sed -i 's/Text/Maritime/g' /root/nautilus.xml`

Используем опцию -i для применения непосредственно в файле, а не в stdout.
s - срока\
g - во всем файле

