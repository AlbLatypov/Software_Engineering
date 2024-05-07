# Ansible Unarchive Module

One of the DevOps team members has created a zip archive on jump host in Stratos DC that needs to be extracted and copied over to all app servers in Stratos DC itself. Because this is a routine task, the Nautilus DevOps team has suggested automating it. We can use Ansible since we have been using it for other automation tasks. Below you can find more details about the task:

We have an inventory file under /home/thor/ansible directory on jump host, which should have all the app servers added already.

There is a zip archive /usr/src/dba/datacenter.zip on jump host.

Create a playbook.yml under /home/thor/ansible/ directory on jump host itself to perform the below given tasks.

    Unzip /usr/src/dba/datacenter.zip archive in /opt/dba/ location on all app servers.

    Make sure the extracted data must has the respective sudo user as their user and group owner, i.e tony for app server 1, steve for app server 2, banner for app server 3.

    The extracted data permissions must be 0744.

Note: Validation will try to run the playbook using command ansible-playbook -i inventory playbook.yml so please make sure playbook works this way, without passing any extra arguments.

#### Решение

Задача:
- распаковать архив на всех серверах stapp01,02,03
- овнеры и группу для каждого сервера свои.
- права 0744 (rwxr--r--)


Инвентори:
```bash
stapp01 ansible_host=172.16.238.10 ansible_ssh_pass=Ir0nM@n ansible_user=tony
stapp02 ansible_host=172.16.238.11 ansible_ssh_pass=Am3ric@ ansible_user=steve
stapp03 ansible_host=172.16.238.12 ansible_ssh_pass=BigGr33n ansible_user=banner
```
Готовим playbook.yml
```bash
---
- name: unzip archive
  become: true
  hosts: all
  gather_facts: true
  tasks:


  - name: unzip arhive stapp01 tony
    ansible.builtin.unarchive:
      src: /usr/src/dba/datacenter.zip
      dest: /opt/dba/
      owner: tony
      group: tony
      mode: 0744
    when: ansible_hostname == "stapp01"

  - name: unzip arhive stapp02 steve
    ansible.builtin.unarchive:
      src: /usr/src/dba/datacenter.zip
      dest: /opt/dba/
      owner: steve
      group: steve
      mode: 0744
    when: ansible_hostname == "stapp02"


  - name: unzip arhive stapp03 banner
    ansible.builtin.unarchive:
      src: /usr/src/dba/datacenter.zip
      dest: /opt/dba/
      owner: banner
      group: banner
      mode: 0744
    when: ansible_hostname == "stapp03"
```




Запускаем, проверяем:
```bash
thor@jump_host ~/ansible$ ansible-playbook -i inventory playbook.yml

PLAY [unzip archive] ***********************************************************************************************************

TASK [Gathering Facts] *********************************************************************************************************
ok: [stapp03]
ok: [stapp02]
ok: [stapp01]

TASK [unzip arhive stapp01 tony] ***********************************************************************************************
skipping: [stapp02]
skipping: [stapp03]
ok: [stapp01]

TASK [unzip arhive stapp02 steve] **********************************************************************************************
skipping: [stapp01]
skipping: [stapp03]
changed: [stapp02]

TASK [unzip arhive stapp03 banner] *********************************************************************************************
skipping: [stapp01]
skipping: [stapp02]
changed: [stapp03]

PLAY RECAP *********************************************************************************************************************
stapp01                    : ok=2    changed=0    unreachable=0    failed=0    skipped=2    rescued=0    ignored=0   
stapp02                    : ok=2    changed=1    unreachable=0    failed=0    skipped=2    rescued=0    ignored=0   
stapp03                    : ok=2    changed=1    unreachable=0    failed=0    skipped=2    rescued=0    ignored=0   

thor@jump_host ~/ansible$ ssh tony@stapp01
tony@stapp01's password: 
Last login: Tue May  7 20:36:31 2024 from 172.16.238.3
[tony@stapp01 ~]$ cd /opt/dba
[tony@stapp01 dba]$ ls -la
total 12
drwxr-xr-x 3 root root 4096 May  7 20:36 .
drwxr-xr-x 1 root root 4096 May  7 20:15 ..
drwxr--r-- 2 tony tony 4096 May  7 20:16 unarchive
```
