# Create a Cron Job

The Nautilus system admins team has prepared scripts to automate several day-to-day tasks. They want them to be deployed on all app servers in Stratos DC on a set schedule. Before that they need to test similar functionality with a sample cron job. Therefore, perform the steps below:


a. Install cronie package on all Nautilus app servers and start crond service.

b. Add a cron */5 * * * * echo hello > /tmp/cron_text for root user.




__Решение__

Хочу сделать через Ansible
``` bash
sudo yum update
sudo yum install ansible
```

На всех серверах всегда присутствует пользователь ansible. Замечал ранее, вот только пароля я его не знаю. К каждому серверу подключаюсь последовательно и через `sudo passwd ansible` ставлю пароль.
Генерирую ssh ключ и копирирую на каждый сервер под ansible.
``` bash

   13  ssh-keygen -q
   14  ssh tony@stapp01
   15  ssh-copy-id ansible@stapp01
   16  ssh ansible@stapp01

```
В результате имею возможность под пользователем ansible подключаться. На каждом из серверов он wheel NO PASSWORD. Создаем инвентори. В /etc/hosts имена и айпишники прописаны.
``` bash
[app]

stapp01
stapp02
stapp03

[app:vars]

ansible_user=ansible
ansible_private_key_file=~/.ssh/id_rsa

```
Все пингуются, пишем плейбук. 
```bash
thor@jump_host ~/ansible$ ansible all -i inventory -m ping
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
stapp01 | SUCCESS => {
    "ansible_facts": {
        "discovered_interpreter_python": "/usr/libexec/platform-python"
    },
    "changed": false,
    "ping": "pong"
}
```
Получился такой плейбук
```bash
---
- name: installing and start service
  hosts: app
  become : true
  gather_facts: true
  tasks:

  - name: installing cronie
    ansible.builtin.package:
      name: cronie
      state: present
    notify:
      - start-service

  - name: Add cron job
    ansible.builtin.cron:
      name: hello
      user: root
      minute: "*/5"
      job: "echo hello > /tmp/cron_text"

  handlers:
    - name: start-service
      ansible.builtin.service:
        name: crond
        state: start
```

Стартуем. Проверяем.
```bash
thor@jump_host ~/ansible$ ansible-playbook -i inventory cron_me.yml 

PLAY [installing and start service] ********************************************************************************************

TASK [Gathering Facts] *********************************************************************************************************
ok: [stapp01]
ok: [stapp03]
ok: [stapp02]

TASK [installing cronie] *******************************************************************************************************
ok: [stapp01]
ok: [stapp03]
ok: [stapp02]

TASK [Add cron job] ************************************************************************************************************
changed: [stapp01]
changed: [stapp02]
changed: [stapp03]

PLAY RECAP *********************************************************************************************************************
stapp01                    : ok=3    changed=1    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0   
stapp02                    : ok=3    changed=1    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0   
stapp03                    : ok=3    changed=1    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0  
```

Подключаюсь к одному из серверов. Проверяю.
```bash
[ansible@stapp03 ~]$ crontab -u root -l
must be privileged to use -u
[ansible@stapp03 ~]$ sudo !!
sudo crontab -u root -l
#Ansible: hello
*/5 * * * * echo hello > /tmp/cron_text
```

Выполнено. Дольше, в разовом исполнении, но интереснее.


