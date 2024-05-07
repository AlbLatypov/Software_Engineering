# Ansible Archive Module

The Nautilus DevOps team has some data on each app server in Stratos DC that they want to copy to a different location. However, they want to create an archive of the data first, then they want to copy the same to a different location on the respective app server. Additionally, there are some specific requirements for each server. Perform the task using Ansible playbook as per requirements mentioned below:


Create a playbook named playbook.yml under /home/thor/ansible directory on jump host, an inventory file is already placed under /home/thor/ansible/ directory on Jump Server itself.

    Create an archive media.tar.gz (make sure archive format is tar.gz) of /usr/src/data/ directory ( present on each app server ) and copy it to /opt/data/ directory on all app servers. The user and group owner of archive media.tar.gz should be tony for App Server 1, steve for App Server 2 and banner for App Server 3.

Note: Validation will try to run playbook using command ansible-playbook -i inventory playbook.yml so please make sure playbook works this way, without passing any extra arguments.


#### Решение

Нужно создать архив директории (на апп) и копировать в другую директорию (также на апп) с учетом owner. Инвентори есть, правильный проверил:
```bash
thor@jump_host ~/ansible$ ansible all -i inventory -m ping
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
stapp03 | SUCCESS => {
    "ansible_facts": {
        "discovered_interpreter_python": "/usr/libexec/platform-python"
    },
    "changed": false,
    "ping": "pong"
}
```

Осталось написать playbook.yml и запустить.
```bash
---
- name: create tar.gz
  become: true
  hosts: all
  gather_facts: true
  tasks:


  - name: arhive stapp01
    community.general.archive:
      path: /usr/src/data/
      dest: /opt/data/media.tar.gz
      owner: tony
      group: tony
      format: gz
    when: ansible_hostname == "stapp01"

  - name: arhive stapp02
    community.general.archive:
      path: /usr/src/data/
      dest: /opt/data/media.tar.gz
      owner: steve
      group: steve
      format: gz
    when: ansible_hostname == "stapp02"


  - name: arhive stapp03
    community.general.archive:
      path: /usr/src/data/
      dest: /opt/data/media.tar.gz
      owner: banner
      group: banner
      format: gz
    when: ansible_hostname == "stapp03"
```

Выполнение (предварительно сделал limit для stapp01 для проверки)
```bash
thor@jump_host ~/ansible$ ansible-playbook -i inventory playbook.yml

PLAY [create tar.gz] ***********************************************************************************************************

TASK [Gathering Facts] *********************************************************************************************************
ok: [stapp01]
ok: [stapp02]
ok: [stapp03]

TASK [arhive stapp01] **********************************************************************************************************
skipping: [stapp02]
skipping: [stapp03]
ok: [stapp01]

TASK [arhive stapp02] **********************************************************************************************************
skipping: [stapp01]
skipping: [stapp03]
changed: [stapp02]

TASK [arhive stapp03] **********************************************************************************************************
skipping: [stapp01]
skipping: [stapp02]
changed: [stapp03]

PLAY RECAP *********************************************************************************************************************
stapp01                    : ok=2    changed=0    unreachable=0    failed=0    skipped=2    rescued=0    ignored=0   
stapp02                    : ok=2    changed=1    unreachable=0    failed=0    skipped=2    rescued=0    ignored=0   
stapp03                    : ok=2    changed=1    unreachable=0    failed=0    skipped=2    rescued=0    ignored=0  
```
