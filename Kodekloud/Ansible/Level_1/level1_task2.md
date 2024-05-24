# Create Ansible Inventory for App Server Testing

The Nautilus DevOps team is testing Ansible playbooks on various servers within their stack. They've placed some playbooks under /home/thor/playbook/ directory on the jump host and now intend to test them on app server 1 in Stratos DC. However, an inventory file needs creation for Ansible to connect to the respective app. Here are the requirements:

a. Create an ini type Ansible inventory file /home/thor/playbook/inventory on jump host.

b. Include App Server 1 in this inventory along with necessary variables for proper functionality.

c. Ensure the inventory hostname corresponds to the server name as per the wiki, for example stapp01 for app server 1 in Stratos DC.

Note: Validation will execute the playbook using the command ansible-playbook -i inventory playbook.yml. Ensure the playbook functions properly without any extra arguments

### Решение

1. Необходимо создать инвентори ini type для работы с сервером App Server 1 (stapp01):

`stapp01 ansible_host=172.16.238.10 ansible_user=tony ansible_password=Ir0nM@n ansible_ssh_common_args='-o StrictHostKeyChecking=no'`

2. Проверяем:
```bash
thor@jump_host ~/playbook$ ansible all -i inventory -m ping
stapp01 | SUCCESS => {
    "ansible_facts": {
        "discovered_interpreter_python": "/usr/libexec/platform-python"
    },
    "changed": false,
    "ping": "pong"
}
```

3. Выполняем предложенный плейбук:
```bash
thor@jump_host ~/playbook$ ansible-playbook -i inventory playbook.yml

PLAY [all] *********************************************************************************************************************

TASK [Gathering Facts] *********************************************************************************************************
ok: [stapp01]

TASK [Install httpd package] ***************************************************************************************************
changed: [stapp01]

TASK [Start service httpd] *****************************************************************************************************
changed: [stapp01]

PLAY RECAP *********************************************************************************************************************
stapp01                    : ok=3    changed=2    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0  
```

4. Для информации. Содержимое плейбука. Сервис я бы перепустил через хэндлер, но что есть, то есть по условию не корректируем.
```bash
---
- hosts: all
  become: yes
  become_user: root
  tasks:
    - name: Install httpd package
      yum:
        name: httpd
        state: installed

    - name: Start service httpd
      service:
        name: httpd
        state: started
```
