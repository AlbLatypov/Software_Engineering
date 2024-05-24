# Copy Data to App Servers using Ansible

The Nautilus DevOps team needs to copy data from the jump host to all application servers in Stratos DC using Ansible. Execute the task with the following details:


a. Create an inventory file /home/thor/ansible/inventory on jump_host and add all application servers as managed nodes.


b. Create a playbook /home/thor/ansible/playbook.yml on the jump host to copy the /usr/src/devops/index.html file to all application servers, placing it at /opt/devops.


Note: Validation will run the playbook using the command ansible-playbook -i inventory playbook.yml. Ensure the playbook functions properly without any extra arguments.

### Решение

1. Вариантов решения 2:
 - прописывать в инвентори логин и пароль ssh админов указанных серверов
 - зашел на каждый из серверов и увидел, что везде присутствует пользователь ansible, и везде в группе wheel. Можно для него прокинуть ключ SSH, предварительно сбросив пароль на сервере и задания запускать уже из под него. Делаем по этому варианту...

 ```bash
[tony@stapp01 ~]$ grep ansible /etc/group
wheel:x:10:ansible,tony
ansible:x:1000:
 ```

1. На всех серверах поочередно сбрасываем пароль для ansible, т.к. он нигде не указан.
```bash
[tony@stapp01 ~]$ sudo passwd ansible
Changing password for user ansible.
New password: 
BAD PASSWORD: The password is shorter than 8 characters
Retype new password: 
passwd: all authentication tokens updated successfully.
```

2. Группе wheel через visudo даем права на выполнение команд от имени рута без запроса пароля.

```bash
## Allows people in group wheel to run all commands
#%wheel ALL=(ALL)       ALL

## Same thing without a password
%wheel  ALL=(ALL)       NOPASSWD: ALL
```

3. Генерируем ключ и пробрасываем для ansible на все сервера. Отражаю только для одного.
```bash
thor@jump_host ~/ansible$ ssh-keygen -q
Enter file in which to save the key (/home/thor/.ssh/id_rsa): 
Enter passphrase (empty for no passphrase): 
Enter same passphrase again: 

thor@jump_host ~/ansible$ ssh-copy-id ansible@stapp01
/usr/bin/ssh-copy-id: INFO: Source of key(s) to be installed: "/home/thor/.ssh/id_rsa.pub"
/usr/bin/ssh-copy-id: INFO: attempting to log in with the new key(s), to filter out any that are already installed
/usr/bin/ssh-copy-id: INFO: 1 key(s) remain to be installed -- if you are prompted now it is to install the new keys
ansible@stapp01's password: 

Number of key(s) added: 1

Now try logging into the machine, with:   "ssh 'ansible@stapp01'"
and check to make sure that only the key(s) you wanted were added.
```

4. Создаем инвентори в указанном каталоге. Хосты присутствуют в /etc/hosts
```bash
[app]
stapp01
stapp02
stapp03

[app:vars]
ansible_user=ansible
ansible_private_key_file=/home/thor/.ssh/id_rsa
```

5. Проверяем.
```bash
thor@jump_host ~/ansible$ ansible all -i inventory -m ping
stapp01 | SUCCESS => {
    "ansible_facts": {
        "discovered_interpreter_python": "/usr/libexec/platform-python"
    },
    "changed": false,
    "ping": "pong"
}
stapp03 | SUCCESS => {
    "ansible_facts": {
        "discovered_interpreter_python": "/usr/libexec/platform-python"
    },
    "changed": false,
    "ping": "pong"
}
stapp02 | SUCCESS => {
    "ansible_facts": {
        "discovered_interpreter_python": "/usr/libexec/platform-python"
    },
    "changed": false,
    "ping": "pong"
}
```

6. Пишем плейбук.
```bash
---
- name: copy files
  become: yes
  gather_facts: no
  hosts: app
  tasks:

  - name: copy /usr/src/devops/index.html ---> /opt/devops
    ansible.builtin.copy:
      src: /usr/src/devops/index.html
      dest: /opt/devops
```

7. Выполняем
```bash
thor@jump_host ~/ansible$ ansible-playbook -i inventory playbook.yml

PLAY [copy files] **************************************************************************************************************

TASK [copy /usr/src/devops/index.html ---> /opt/devops] ************************************************************************
changed: [stapp01]
changed: [stapp02]
changed: [stapp03]

PLAY RECAP *********************************************************************************************************************
stapp01                    : ok=1    changed=1    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0   
stapp02                    : ok=1    changed=1    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0   
stapp03                    : ok=1    changed=1    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0  
```

Проверяем:
```bash
thor@jump_host ~/ansible$ ansible all -i inventory -a "ls -laF /opt/devops"
stapp01 | CHANGED | rc=0 >>
total 12
drwxr-xr-x 2 root root 4096 May 24 21:33 ./
drwxr-xr-x 1 root root 4096 May 24 21:05 ../
-rw-r--r-- 1 root root   35 May 24 21:33 index.html
stapp03 | CHANGED | rc=0 >>
total 12
drwxr-xr-x 2 root root 4096 May 24 21:33 ./
drwxr-xr-x 1 root root 4096 May 24 21:05 ../
-rw-r--r-- 1 root root   35 May 24 21:33 index.html
stapp02 | CHANGED | rc=0 >>
total 12
drwxr-xr-x 2 root root 4096 May 24 21:33 ./
drwxr-xr-x 1 root root 4096 May 24 21:05 ../
-rw-r--r-- 1 root root   35 May 24 21:33 index.html
```
