# Ansible Install Package

The Nautilus Application development team wanted to test some applications on app servers in Stratos Datacenter. They shared some pre-requisites with the DevOps team, and packages need to be installed on app servers. Since we are already using Ansible for automating such tasks, please perform this task using Ansible as per details mentioned below:


 - Create an inventory file /home/thor/playbook/inventory on jump host and add all app servers in it.

 - Create an Ansible playbook /home/thor/playbook/playbook.yml to install httpd package on all app servers using Ansible yum module.

 - Make sure user thor should be able to run the playbook on jump host.

Note: Validation will try to run playbook using command `ansible-playbook -i inventory playbook.yml` so please make sure playbook works this way, without passing any extra arguments.


#### Решение

Нужно создать инвентори файл для развертывания httpd на серверах app. Создаем инвентори. Хочу запускать от имени пользователя ansible. Смотрю на stapp01:
```bash
sudo visudo

## Read drop-in files from /etc/sudoers.d (the # here does not mean a comment)
#includedir /etc/sudoers.d
ansible    ALL=(ALL)   NOPASSWD:ALL
%wheel        ALL=(ALL)       NOPASSWD: ALL
```

Пользователь ansible может запускать без пароля на stapp01,02,03. Остается настоить ему вход по ключу ssh. Сбрасываю ему пароль на сервере:
```bash
sudo passwd ansible
```

и с сервера откуда запускаем playbook настриваю вход по ключу ssh
``` bash
thor@jump_host ~/playbook$ ssh-keygen
thor@jump_host ~/playbook$ ssh-copy-id ansible@stapp01
```
На всех трех серверах.

Пишем инвентори. В /etc/hosts имена с ip соотнесены

```bash
[app]
stapp01
stapp02
stapp03

[app:vars]
ansible_user=ansible
ansible_private_key_file=/home/thor/.ssh/id_rsa
```
Проверяем:
```bash
thor@jump_host ~/playbook$ ansible all -i inventory -m ping
stapp01 | SUCCESS => {
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
stapp03 | SUCCESS => {
    "ansible_facts": {
        "discovered_interpreter_python": "/usr/libexec/platform-python"
    },
    "changed": false,
    "ping": "pong"
}
```

Пишем playbook:
```bash
---

- name: Nautilus app
  hosts: app
  become: true
  tasks:

  - name: install package
    ansible.builtin.yum:
      name: httpd
      state: latest
```

Запускаем:
```bash
thor@jump_host ~/playbook$ ansible-playbook -i inventory playbook.yml

PLAY [Nautilus app] *********************************************************************************************

TASK [Gathering Facts] ******************************************************************************************
ok: [stapp03]
ok: [stapp02]
ok: [stapp01]

TASK [install package] ******************************************************************************************
changed: [stapp02]
changed: [stapp01]
changed: [stapp03]

PLAY RECAP ******************************************************************************************************
stapp01                    : ok=2    changed=1    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0   
stapp02                    : ok=2    changed=1    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0   
stapp03                    : ok=2    changed=1    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0   
```

Выполнено. Верно
