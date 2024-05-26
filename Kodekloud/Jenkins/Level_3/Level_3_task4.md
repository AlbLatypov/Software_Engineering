# Kodekloud. Jenkins Deploy Pipeline

The development team of xFusionCorp Industries is working on to develop a new static website and they are planning to deploy the same on Nautilus App Servers using Jenkins pipeline. They have shared their requirements with the DevOps team and accordingly we need to create a Jenkins pipeline job. Please find below more details about the task:


Click on the Jenkins button on the top bar to access the Jenkins UI. Login using username admin and password Adm!n321.

Similarly, click on the Gitea button on the top bar to access the Gitea UI. Login using username sarah and password Sarah_pass123. There under user sarah you will find a repository named web_app that is already cloned on Storage server under /var/www/html. sarah is a developer who is working on this repository.

* Add a slave node named Storage Server. It should be labeled as ststor01 and its remote root directory should be /var/www/html.

* We have already cloned repository on Storage Server under /var/www/html.

* Apache is already installed on all app Servers its running on port 8080.

* Create a Jenkins pipeline job named nautilus-webapp-job (it must not be a Multibranch pipeline) and configure it to:

* Deploy the code from web_app repository under /var/www/html on Storage Server, as this location is already mounted to the document root /var/www/html of app servers. The pipeline should have a single stage named Deploy ( which is case sensitive ) to accomplish the deployment.

LB server is already configured. You should be able to see the latest changes you made by clicking on the App button. Please make sure the required content is loading on the main URL https://<LBR-URL> i.e there should not be a sub-directory like https://<LBR-URL>/web_app etc.


### Решение

1. Подключаемся к Jenkins. Ставим плагины:
 - Git
 - Pipeline и дополнительные
 - SSH, Credentials, SSH Agent, SSH Build Agents

2. Создаем ноду в jenkins для Ststor01, согласно условиям, правильно указываем метку и корневую директорию. Дополнительно:
 - установить `[root@ststor01 html]# yum install java-11-openjdk-devel.x86_64` на сервере ststor01
 - создать авториз. данные для natasha

3. Нода не запускается, не хватает прав на каталог. Пользователь sarah, по SSH стучимся natasha, у нее нет прав на запись.

```bash
drwxr-xr-x 3 sarah sarah 4096 May 23 20:56 html
[natasha@ststor01 www]$ sudo chmod 777 html
```
агент успешно подключился и онлайн.

4. Создаем pipiline, не забывая аппрувнуть.
```groovy
pipeline {
    agent {
        node {
            label 'ststor01'
        }
    }

    stages {
        stage('Build') {
            steps {
                git branch: "master",
                    url: "http://git.stratos.xfusioncorp.com/sarah/web_app.git"
                sh -f 'cp /var/www/html/workspace/nautilus-webapp-job/index.html /var/www/html/index.html'
            }
        }
    }
}
```
Успешно!
