# Jenkins Installation

The DevOps team of xFusionCorp Industries is planning to setup some CI/CD pipelines. After several meetings they have decided to use Jenkins server. So, we need to setup a Jenkins Server as soon as possible. Please complete the task as per requirements mentioned below:


1. Install jenkins on jenkins server using yum utility only, and start its service. You might face timeout issue while starting the Jenkins service, please refer[this link for help](https://www.jenkins.io/doc/book/system-administration/systemd-services/#starting-services).

2. Jenkin's admin user name should be theadmin, password should be Adm!n321, full name should be Ammar and email should be ammar@jenkins.stratos.xfusioncorp.com.

Note:


1. For this task, ssh into the jenkins server using user root and password S3curePass from jump host.

2. After installing the Jenkins server, please click on the Jenkins button on the top bar to access Jenkins UI and follow the on-screen instructions to create an admin user.

### Решение

Подключаемся, устанавливаем jenkins, используя официальный скрипт для centos

```bash

sudo wget -O /etc/yum.repos.d/jenkins.repo \
    https://pkg.jenkins.io/redhat-stable/jenkins.repo
sudo rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io-2023.key
sudo yum upgrade
# Add required dependencies for the jenkins package
sudo yum install fontconfig java-17-openjdk
sudo yum install jenkins
sudo systemctl daemon-reload

Стартуем сервис:
[root@jenkins ~]# systemctl start jenkins
[root@jenkins ~]# systemctl status jenkins
● jenkins.service - Jenkins Continuous Integration Server
   Loaded: loaded (/usr/lib/systemd/system/jenkins.service; disabled; vendor preset: disabled)
   Active: active (running) since Wed 2024-05-15 20:11:09 UTC; 15s ago
 Main PID: 5004 (java)
    Tasks: 88 (limit: 1340692)
   Memory: 876.7M
   CGroup: /docker/c16f2af0f0ce5fe87ef6f8823939c5e077167758291fff810c5d2d18f69ab7bf/system.slice/jenkins.service
           └─5004 /usr/bin/java -Djava.awt.headless=true -jar /usr/share/java/jenkins.war --webroot=/var/cache/jenkins/war --httpPort=8080

May 15 20:10:54 jenkins.stratos.xfusioncorp.com jenkins[5004]: Jenkins initial setup is required. An admin user has been created and a password generated.
May 15 20:10:54 jenkins.stratos.xfusioncorp.com jenkins[5004]: Please use the following password to proceed to installation:
May 15 20:10:54 jenkins.stratos.xfusioncorp.com jenkins[5004]: 1ac2b22b6cca40c8b77bdffd3959895d
May 15 20:10:54 jenkins.stratos.xfusioncorp.com jenkins[5004]: This may also be found at: /var/lib/jenkins/secrets/initialAdminPassword
May 15 20:10:54 jenkins.stratos.xfusioncorp.com jenkins[5004]: *************************************************************
May 15 20:11:09 jenkins.stratos.xfusioncorp.com jenkins[5004]: 2024-05-15 20:11:09.551+0000 [id=132]        INFO        jenkins.InitReactorRunner$1#onAttained: Completed initialization
May 15 20:11:09 jenkins.stratos.xfusioncorp.com jenkins[5004]: 2024-05-15 20:11:09.739+0000 [id=37]        INFO        hudson.lifecycle.Lifecycle#onReady: Jenkins is fully up and running
May 15 20:11:09 jenkins.stratos.xfusioncorp.com systemd[1]: Started Jenkins Continuous Integration Server.
May 15 20:11:10 jenkins.stratos.xfusioncorp.com jenkins[5004]: 2024-05-15 20:11:10.039+0000 [id=138]        INFO        h.m.DownloadService$Downloadable#load: Obtained the updated data file for hudson.tasks.Maven.MavenInstaller
May 15 20:11:10 jenkins.stratos.xfusioncorp.com jenkins[5004]: 2024-05-15 20:11:10.039+0000 [id=138]        INFO        hudson.util.Retrier#start: Performed the action check updates server successfully at the attempt #1
```

Вижу пароль рута, в менюшке есть кнопочка для перехода в ui jenkins. Никаких плагинов не устанавливаю, перехожу в меню создания пользователя и создаю согласно условию.
