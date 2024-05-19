### Добавить Slave node SSH


### Подход

1. Смотрим [Dockerfile](../01-project/jenkins-slave/Dockerfile). В качестве основного образа выбран легковесный `testcontainers/sshd:1.2.0` с установленным демоном SSH.

2. Создаем образ, докачивается Java, создается пользователь jenkins.
`docker build --no-cache -t sshd:slave .`

3. Запускаем [docker-compose-v2](../01-project/docker-compose-v2.yml), в разделе слейва указываем вновь собранный образ с sshd и java 
`docker compose -f docker-compose-v2.yml up -d`

4. Подключать ноду будем по ssh, пока по связке логин/пароль. Пользователю jenkins надо задать пароль в контейнере sshd:slave.
`docker exec -it jenkins-slave sh`

5. Идем в UI Jenkins и подключаем плагин для управления нодами, добавляем способ подключения и наблюдаем. Тут тривиально.


Most of the time I add a jenkins user on the machine I want to use as a node, and then copy an SSH key so that I can easily connect to it through the controller later on.
I also create a link (bad, bad habit) from /home/jenkins to /var/lib/jenkins so /var/lib/jenkins/.ssh/known_hosts does exist. :thinking:
Your error makes me wonder if there’s a better (and official way) to configure a machine in order to make it a node.
Anyway… If you don’t want to change your process and use your existing folder, you could follow the steps below to create the know_hosts file:

- Log in to the remote node machine as a user who has sudo access.
- Create the directory /var/lib/jenkins/.ssh if it does not exist already: sudo mkdir -p /var/lib/jenkins/.ssh
- Set the correct permissions for the directory: sudo chown -R jenkins:jenkins /var/lib/jenkins/.ssh
- Create an empty known_hosts file: sudo touch /var/lib/jenkins/.ssh/known_hosts
- Set the correct permissions for the known_hosts file: sudo chmod 600 /var/lib/jenkins/.ssh/known_hosts
- Add the SSH host keys for your remote hosts to the known_hosts file. You can do this manually by using the ssh-keyscan command:

`ssh-keyscan your-remote-hostname >> /var/lib/jenkins/.ssh known_hosts`

Replace your-remote-hostname with the hostname or IP address of your remote host.

After these steps, you should be able to connect to your node through SSH without the “No Known Hosts file was found” error.
