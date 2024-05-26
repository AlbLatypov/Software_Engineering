# Create Files on App Servers using Ansible

The Nautilus DevOps team is testing various Ansible modules on servers in Stratos DC. They're currently focusing on file creation on remote hosts using Ansible. Here are the details:


a. Create an inventory file ~/playbook/inventory on jump host and include all app servers.


b. Create a playbook ~/playbook/playbook.yml to create a blank file /home/web.txt on all app servers.


c. Set the permissions of the /home/web.txt file to 0744.


d. Ensure the user/group owner of the /home/web.txt file is tony on app server 1, steve on app server 2 and banner on app server 3.


Note: Validation will execute the playbook using the command ansible-playbook -i inventory playbook.yml, so ensure the playbook functions correctly without any additional arguments.

### Решение

В прошлый раз делал inventory с отдельным пользователем ansible. В этот раз сделаю для всех админов серверов:

```bash
stapp01 ansible_host=172.16.238.10 ansible_user=tony ansible_password=Ir0nM@n ansible_ssh_common_args='-o StrictHostKeyChecking=no'
stapp02 ansible_host=172.16.238.11 ansible_user=steve ansible_password=Am3ric@ ansible_ssh_common_args='-o StrictHostKeyChecking=no'
stapp03 ansible_host=172.16.238.12 ansible_user=banner ansible_password=BigGr33 ansible_ssh_common_args='-o StrictHostKeyChecking=no'
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
плейбук:

```bash
      1 - name: Create empty file
      2   hosts: all
      3   become: yes
      4   gather_facts: yes
      5   tasks:
      6 
      7   - name: Do app1
      8     ansible.builtin.file:
      9       path: /home/web.txt
     10       state: touch
     11       owner: tony
     12       group: tony
     13       mode: "0744"
     14     when: ansible_hostname == "stapp01"
     15   
     16   - name: Do app2
     17     ansible.builtin.file: 
     18       path: /home/web.txt
     19       state: touch
     20       owner: steve
     21       group: steve
     22       mode: "0744"
     23     when: ansible_hostname == "stapp02"
     24   
     25   - name: Do app3
     26     ansible.builtin.file: 
     27       path: /home/web.txt
     28       state: touch 
     29       owner: banner
     30       group: banner    
     31       mode: "0744"
     32     when: ansible_hostname == "stapp03"
```
Выполнение

```bash
thor@jump_host ~/playbook$ ansible-playbook -i inventory playbook.yml

PLAY [Create empty file] *******************************************************************************************************

TASK [Gathering Facts] *********************************************************************************************************
ok: [stapp02]
ok: [stapp03]
ok: [stapp01]

TASK [Do app1] *****************************************************************************************************************
skipping: [stapp02]
skipping: [stapp03]
changed: [stapp01]

TASK [Do app2] *****************************************************************************************************************
skipping: [stapp01]
skipping: [stapp03]
changed: [stapp02]

TASK [Do app3] *****************************************************************************************************************
skipping: [stapp01]
skipping: [stapp02]
changed: [stapp03]

PLAY RECAP *********************************************************************************************************************
stapp01                    : ok=2    changed=1    unreachable=0    failed=0    skipped=2    rescued=0    ignored=0   
stapp02                    : ok=2    changed=1    unreachable=0    failed=0    skipped=2    rescued=0    ignored=0   
stapp03                    : ok=2    changed=1    unreachable=0    failed=0    skipped=2    rescued=0    ignored=0  
```
Проверка:

```bash
thor@jump_host ~/playbook$ ansible all -i inventory -a "ls -laF /home/web.txt"
stapp03 | CHANGED | rc=0 >>
-rwxr--r-- 1 banner banner 0 May 25 20:03 /home/web.txt*
stapp02 | CHANGED | rc=0 >>
-rwxr--r-- 1 steve steve 0 May 25 20:03 /home/web.txt*
stapp01 | CHANGED | rc=0 >>
-rwxr--r-- 1 tony tony 0 May 25 20:03 /home/web.txt*
```
