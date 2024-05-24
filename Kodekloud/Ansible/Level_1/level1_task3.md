# Configure Default SSH User for Ansible

The Nautilus DevOps team aims to manage all servers within the stack using Ansible, utilizing a common sudo user across all servers. They plan to use this user for various tasks on each server. While this isn't finalized, they're starting with testing. Ansible is already installed on the jump host via yum. Here's the requirement:


On the jump host, modify the default configuration of Ansible to enable the use of kirsty as the default SSH user for all hosts. Ensure to make changes within Ansible's default configuration without creating a new one.

### Решение

Дефолтные конфигурация и инвентори находятся `thor@jump_host ~$ cd /etc/ansible`

Для редактирования в /etc нужен рут, повышаем привелегии: `sudo -i`. Вносим изменения в ansible.cfg. Какие могут быть настройки у конфига [смотрим тут](https://github.com/ansible/ansible/blob/stable-2.9/examples/ansible.cfg)

```bash
root@jump_host /etc/ansible# grep remote ansible.cfg 
remote_user = kirsty
```

Много информации [https://github.com/ansible/ansible/blob/stable-2.9/README.rst](https://github.com/ansible/ansible/blob/stable-2.9/README.rst)


