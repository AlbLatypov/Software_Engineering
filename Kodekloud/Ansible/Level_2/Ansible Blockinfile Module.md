# Ansible Blockinfile Module

The Nautilus DevOps team wants to install and set up a simple httpd web server on all app servers in Stratos DC. Additionally, they want to deploy a sample web page for now using Ansible only. Therefore, write the required playbook to complete this task. Find more details about the task below.


We already have an inventory file under /home/thor/ansible directory on jump host. Create a playbook.yml under /home/thor/ansible directory on jump host itself.

- Using the playbook, install httpd web server on all app servers. Additionally, make sure its service should up and running.

- Using blockinfile Ansible module add some content in /var/www/html/index.html file. Below is the content:
```bash
Welcome to XfusionCorp!
This is  Nautilus sample file, created using Ansible!
Please do not modify this file manually!
```
- The /var/www/html/index.html file's user and group owner should be apache on all app servers.

- The /var/www/html/index.html file's permissions should be 0777 on all app servers.

Note:

i. Validation will try to run the playbook using command ansible-playbook -i inventory playbook.yml so please make sure the playbook works this way without passing any extra arguments.

ii. Do not use any custom or empty marker for blockinfile module.


### Решение
- установить httpd, запустить 
- проверить существует ли файл
- добавить содержимое, строго из условия
- накинуть прав 

Инвентори:
```bash
stapp01 ansible_host=172.16.238.10 ansible_ssh_pass=Ir0nM@n ansible_user=tony
stapp02 ansible_host=172.16.238.11 ansible_ssh_pass=Am3ric@ ansible_user=steve
stapp03 ansible_host=172.16.238.12 ansible_ssh_pass=BigGr33n ansible_user=banner


Файл существует? Пока видимо нет, так мне создавать новый или добавлять к будущему?

thor@jump_host ~/ansible$ ansible all -a 'ls -la /var/www/html/' -i inventory
stapp01 | FAILED | rc=2 >>
ls: cannot access '/var/www/html/': No such file or directorynon-zero return code
stapp02 | FAILED | rc=2 >>
ls: cannot access '/var/www/html/': No such file or directorynon-zero return code
stapp03 | FAILED | rc=2 >>
ls: cannot access '/var/www/html/': No such file or directorynon-zero return code
```

Создан playbook.yml
```bash
---

- name: install httpd
  hosts: all
  become: true
  gather_facts: true
  tasks:

  - name: install httpd
    ansible.builtin.package:
      name: httpd
      state: present
    notify: start httpd

  - name: bl_in_file
    ansible.builtin.blockinfile:
      path: /var/www/html/index.html
      create: yes
      block: |
        Welcome to XfusionCorp!

        This is  Nautilus sample file, created using Ansible!

        Please do not modify this file manually!
      owner: apache
      group: apache
      mode: 0777


  handlers:
    - name: start httpd
      ansible.builtin.service:
        name: httpd
        state: started
```
Проверяем содержимое. Не знаю, с пустыми строками делать или нет. Скопировал строго из условия. Проверям:

```bash
thor@jump_host ~/ansible$ ansible all -a 'cat /var/www/html/index.html' -i inventory
stapp02 | CHANGED | rc=0 >>
# BEGIN ANSIBLE MANAGED BLOCK
Welcome to XfusionCorp!

This is  Nautilus sample file, created using Ansible!

Please do not modify this file manually!
# END ANSIBLE MANAGED BLOCK
stapp01 | CHANGED | rc=0 >>
# BEGIN ANSIBLE MANAGED BLOCK
Welcome to XfusionCorp!

This is  Nautilus sample file, created using Ansible!

Please do not modify this file manually!
# END ANSIBLE MANAGED BLOCK
stapp03 | CHANGED | rc=0 >>
# BEGIN ANSIBLE MANAGED BLOCK
Welcome to XfusionCorp!

This is  Nautilus sample file, created using Ansible!

Please do not modify this file manually!
# END ANSIBLE MANAGED BLOCK

```

Права и группу:
``` bash
thor@jump_host ~/ansible$ ansible all -a 'ls -la /var/www/html/index.html' -i inventory
stapp01 | CHANGED | rc=0 >>
-rwxrwxrwx 1 apache apache 179 May  7 21:33 /var/www/html/index.html
stapp03 | CHANGED | rc=0 >>
-rwxrwxrwx 1 apache apache 179 May  7 21:33 /var/www/html/index.html
stapp02 | CHANGED | rc=0 >>
-rwxrwxrwx 1 apache apache 179 May  7 21:33 /var/www/html/index.html
```

ВЕРНО!
