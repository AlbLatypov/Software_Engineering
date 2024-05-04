# Cron schedule deny to users

To stick with the security compliances, the Nautilus project team has decided to apply some restrictions on crontab access so that only allowed users can create/update the cron jobs. Limit crontab access to below specified users on App Server 2.


Allow crontab access to __kareem__ user and deny the same to __garrett__ user.


#### Решение:

- Создаем ключ, копируем, подключаемся
```bash
ssh-keygen -q
ssh-copy-id steve@stapp02
ssh steve@stapp02
```

- смотрим наличие файлов, если не создаем (cat, vi, touch):
  - /etc/cron.allow 
  - /etc/cron.deny

- распихиваем пользователей по файлам согласно условию
- `sudo systemctl restart crond`


#### Дополнительная информация:

__Приоритет__: cron.allow имеет приоритет над cron.deny. Если пользователь есть в cron.allow, ему будет разрешен доступ, даже если он также указан в cron.deny. 
