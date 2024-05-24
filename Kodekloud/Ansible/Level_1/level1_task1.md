# Troubleshoot and Create Ansible Playbook

An Ansible playbook needs completion on the jump host, where a team member left off. Below are the details:

The inventory file /home/thor/ansible/inventory requires adjustments. The playbook must run on App Server 1 in Stratos DC. Update the inventory accordingly.

Create a playbook /home/thor/ansible/playbook.yml. Include a task to create an empty file /tmp/file.txt on App Server 1.

Note: Validation will run the playbook using the command ansible-playbook -i inventory playbook.yml. Ensure the playbook works without any additional arguments.

### Решение

1. Смотрим предложенный инвентори. На сервере другой stapp01 другой администратор tony. Корректируем все недочеты:

```bash
stapp02 ansible_host=172.238.16.204 ansible_user=steve ansible_ssh_common_args='-o StrictHostKeyChecking=no'

```

Исправленный вариант
```bash
stapp01 ansible_host=172.16.238.10 ansible_user=tony ansible_password=Ir0nM@n ansible_ssh_common_args='-o StrictHostKeyChecking=no'
```

2. Проверяем:
```bash
thor@jump_host ~/ansible$ ansible all -i inventory -m ping
stapp01 | SUCCESS => {
    "ansible_facts": {
        "discovered_interpreter_python": "/usr/libexec/platform-python"
    },
    "changed": false,
    "ping": "pong"
}
```

3. Пишем плейбук:

```bash
---
- name: Create empty file
  hosts: all
  become: yes
  gather_facts: no
  tasks:

  - name: Do
    ansible.builtin.file:
      path: /tmp/file.txt
      state: touch

```

Выполняем:

```bash
thor@jump_host ~/ansible$ ansible-playbook -i inventory playbook.yml 

PLAY [Create empty file] *******************************************************************************************************

TASK [Do] **********************************************************************************************************************
changed: [stapp01]

PLAY RECAP *********************************************************************************************************************
stapp01                    : ok=1    changed=1    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0 

```
