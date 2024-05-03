# Решение задач по Ansible 


### Level 1. [Certificate](https://engineer.kodekloud.com/certificate-verification/54d4e635-92c5-4900-be5e-f42114b2b1b1)

![Level 1 results](../Ansible/Level_1/level1_results.png)

### Level 1 exam - тест после курса первого уровня (100 минут)

#### Task1
_The Nautilus DevOps team is executing Ansible using a sudo user on the jump host. They aim to automate certain Ansible playbook runs and ensure that Ansible does not prompt for a sudo password during playbook execution. As a result, they have outlined the following requirements to resolve this matter._

Ensure the necessary adjustments are made within the Ansible configuration located at /home/thor/ansible-t5q4/ansible-t5q4.cfg. Please refrain from creating a new configuration file.


__Решение__: достаточно объемный конфигурационный файл, расскомментил пару строк связанных с привилегиями. Видимо не то. Ошибка. Комментарий:

`appropriate changes are not changed to 'True' in config file '/home/thor/ansible-t5q4/ansible-t5q4.cfg' on Jump Server`

#### Taks2.

The Nautilus DevOps team will be managing multiple hosts using Ansible. Each host possesses unique properties such as hostnames, login credentials, etc. Therefore, a custom inventory file is necessary to manage these hosts efficiently. The team has delineated the following requirements to address this situation.

Ensure that the default inventory path is appropriately modified to point to /home/thor/ansible-t5q6/inventory-t5q6 in the Ansible configuration file located at /home/thor/ansible-t5q6/ansible-t5q6.cfg. Please refrain from creating a new configuration file.

__Решение__:

Нужно проверить конфигурационный и проверить правильность указания инвентори. 
```bash
[defaults]
# some basic default values...
inventory      = /home/thor/ansible-t5q6/inventory-t5q6
remote_tmp     = $HOME/.ansible/tmp
forks          = 150
sudo_user      = root
transport      = smart
```
Выполнено. Верно.

#### Task3

There is data on jump host that needs to be copied on all application servers in Stratos DC. Nautilus DevOps team want to perform this task using Ansible. Perform the task as per details mentioned below:

 - a. On jump host we already have inventory file /home/thor/ansible/inventory-t2q1.
 - b. On jump host __create a playbook__ /home/thor/ansible/playbook-t2q1.yml to copy /usr/src/itadmin-t2q1/index-t2q1.html file to all application servers at location /opt/itadmin-t2q1.

Note: Validation will try to run the playbook using command ansible-playbook -i inventory-t2q1 playbook-t2q1.yml so please make sure the playbook works this way without passing any extra arguments.

__Решение__: создание ПБ для копирования файла. Создано. Верно.
```bash
---
- hosts: all
  gather_facts: true
  become: true
  tasks:

  - name: copy file
    ansible.builtin.copy:
      src: /usr/src/itadmin-t2q1/index-t2q1.html
      dest: /opt/itadmin-t2q1
```

#### Task 4.

a. On jump host create a playbook /home/thor/ansible/playbook-t2q5.yml to copy /usr/src/itadmin-t2q5/story-t2q5.txt file __from App Server 2__ at location /opt/itadmin-t2q5 __on App Server 2__.
b. An inventory is already placed under /home/thor/ansible/inventory-t2q5.
Note: Validation will try to run the playbook using command ansible-playbook -i inventory-t2q5 playbook-t2q5.yml so please make sure the playbook works this way without passing any extra arguments.

__Решение__: создать ПБ для копирования файла внутри удаленного хоста. Создано. Верно. Не скопировал плейбук, ключевое remote_rc

```bash
- name: Copy file within the server
  hosts: all
  tasks:
    - name: Copy file
      ansible.builtin.copy:
        src: /path/to/source/file/usr/src/itadmin-t2q5/story-t2q5.txt
        dest: /path/to/destination/file/opt/itadmin-t2q5
        remote_src: yes
```

#### Task 5

The Nautilus DevOps team is working to create some data on different app servers in using Ansible. They want to create some files/directories and have some specific requirements related to this task. Find below more details about the same:

a. Utilise the inventory file /home/thor/playbook/inventory-t4q3, present on the jump host.
b. Create a playbook named /home/thor/playbook/playbook-t4q3.yml to create a directory named /opt/backup-t4q3 on all App Servers.
Note: Validation will attempt to execute the playbook using the command ansible-playbook -i inventory-t4q3 playbook-t4q3.yml. Please ensure the playbook functions correctly with this command alone, without requiring any additional arguments.

__Решение__: на этой таске я подумал, что тип наутилусов черезчур активная. Плейбук нужен для создания директории. Верно.

```bash
Inventory /home/thor/playbook/inventory-t4q3

stapp01 ansible_host=172.16.238.10 ansible_ssh_pass=Ir0nM@n ansible_user=tony
stapp02 ansible_host=172.16.238.11 ansible_ssh_pass=Am3ric@ ansible_user=steve
stapp03 ansible_host=172.16.238.12 ansible_ssh_pass=BigGr33n ansible_user=banner


playbook /home/thor/playbook/playbook-t4q3.yml
---
- name: Create directory
  hosts: all
  become: yes

  tasks:
  - name: Create directory
    ansible.builtin.file:
      path: /opt/backup-t4q3
      state: directory
```

#### Task 6

The Nautilus DevOps team is working to create some data on different app servers in using Ansible. They want to create some files/directories and have some specific requirements related to this task. Find below more details about the same:

Create a playbook called playbook-t4q6.yml under /home/thor/playbook/ directory and configure it to create a file called /opt/file-t4q6.txt on all App Servers. __The contents of the file must be This file is created by Ansible!__. Inventory is already placed under /home/thor/playbook/inventory-t4q6.
Note: Validation will try to run the playbook using command ansible-playbook -i inventory-t4q6 playbook-t4q6.yml, so please make sure the playbook works this way without passing any extra arguments.

__Решение__: создать файл с содержимым. Верно.

```bash
- hosts: all
  gather_facts: true
  become: true
  tasks:
    - name: Create a file with content
      copy:
        dest: /opt/file-t4q6.txt
        content: "This file is created by Ansible!"
```
Запускаем, проверяем:
`ansible-playbook -i inventory-t4q6 playbook-t4q6.yml`

#### Task 7

As per the details given in the table below, you can see that, the web servers are linux based hosts and the db server is a Windows machine. Update the inventory /home/thor/playbooks/inventory-t3q6 to add a similar entry for server4.company.com host. 

Find the required details from the table below.
```bash
|  Alias |        HOST         | Connection | User          | Password     | 
---------------------------------------------------------------------------
|  web1  | server1.company.com |    ssh     | root          | Password123! |
---------------------------------------------------------------------------
|  web2  | server2.company.com |    ssh     | root          | Password123! |
---------------------------------------------------------------------------
|  web3  | server3.company.com |    ssh     | root          | Password123! |
---------------------------------------------------------------------------
|  db1   | server4.company.com |    winrm   | administrator | Dbp@ss123!   |
---------------------------------------------------------------------------
```
Note: For Linux based hosts, use ansible_ssh_pass parameter and for Windows based hosts, use ansible_password parameter.

__Решение__: Обновить инвентори с условимем задачи. Верно.

```bash
# Sample Inventory File

# Web Servers
web1 ansible_host=server1.company.com ansible_connection=ssh ansible_user=root ansible_ssh_pass=Password123!
web2 ansible_host=server2.company.com ansible_connection=ssh ansible_user=root ansible_ssh_pass=Password123!
web3 ansible_host=server3.company.com ansible_connection=ssh ansible_user=root ansible_ssh_pass=Password123!
db1 ansible_host=server4.company.com ansible_connection=winrm ansible_user=administrator ansible_password=Dbp@ss123!
```

#### Task 8

The Nautilus Application development team wanted to test some applications on app servers in Stratos Datacenter. They shared some pre-requisites with the DevOps team, and packages need to be installed on app servers. Since they already created some playbooks, now they wanted to make some changes in inventories.

There is an inventory file /home/thor/playbooks/inventory-t3q3 on jump host. It has some aliases named web1, web2 and web3 for three hosts respectively. Update this inventory file to add an alias called db1 for server4.company.com host.

__Решение__: добавить в инвентори информацию по серверу из условия. Верно!

```bash
# Sample Inventory File

web1 ansible_host=server1.company.com
web2 ansible_host=server2.company.com
web3 ansible_host=server3.company.com
db1 ansible_host=server4.company.com
```

#### Task 9

A playbook on the jump host previously functioned correctly. However, a team member recently made modifications that resulted in misconfiguration. Subsequently, when we attempted to execute it, an error occurred. We require someone to review the playbook, identify the issue, and rectify it.

The playbook name is /home/thor/ansible/playbook-t1q6.yml, make sure it executes without any error.

__Решение__: поправить плейбук. Верно.

Тот который надо поправить:
```bash
---
- hosts: localhost
  connection: local
    tasks:
    -name: Read file
     shell: cat /etc/hosts
```

Исправленный:
```bash
---
- hosts: localhost
  connection: local
  tasks:
    - name: Read file
      shell: cat /etc/hosts
```

#### task 10

We plan to utilize various Ansible modules moving forward. To enhance our familiarity, the team intends to practice commonly used modules by creating playbooks for specific tasks.

Create a playbook named /home/thor/ansible/playbook-t1q4.yml on the jump host. Configure the playbook to generate a file named /tmp/file.txt on the jump host itself. Utilize the copy module and ensure the file contains the content: Welcome to the KKE Tests!

__Решение__: верно

```bash
---
- hosts: localhost
  become: false
  gather_facts: false
  connection: local
  tasks:
    - name: Generate file
      ansible.builtin.copy:
        dest: /tmp/file.txt
        content: "Welcome to the KKE Tests!"
```

Получаем сертификат:

![cert](../Ansible/Level_1/cerificate_level_1.png)




