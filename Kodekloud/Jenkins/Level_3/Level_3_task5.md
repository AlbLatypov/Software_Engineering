# Kodekloud. Jenkins Conditional Pipeline


The development team of xFusionCorp Industries is working on to develop a new static website and they are planning to deploy the same on Nautilus App Servers using Jenkins pipeline. They have shared their requirements with the DevOps team and accordingly we need to create a Jenkins pipeline job. Please find below more details about the task:


Click on the Jenkins button on the top bar to access the Jenkins UI. Login using username admin and password Adm!n321.

Similarly, click on the Gitea button on the top bar to access the Gitea UI. Login using username sarah and password Sarah_pass123. There under user sarah you will find a repository named web_app that is already cloned on Storage server under /var/www/html. sarah is a developer who is working on this repository.

- Add a slave node named Storage Server. It should be labeled as ststor01 and its remote root directory should be /var/www/html.

- We have already cloned repository on Storage Server under /var/www/html.

- Apache is already installed on all app Servers its running on port 8080.

- Create a Jenkins pipeline job named xfusion-webapp-job (it must not be a Multibranch pipeline) and configure it to:

   - Add a string parameter named BRANCH.

   - It should conditionally deploy the code from web_app repository under /var/www/html on Storage Server, as this location is already mounted to the document root /var/www/html of app servers. The pipeline should have a single stage named Deploy ( which is case sensitive ) to accomplish the deployment.

    - The pipeline should be conditional, if the value master is passed to the BRANCH parameter then it must deploy the master branch, on the other hand if the value feature is passed to the BRANCH parameter then it must deploy the feature branch.

LB server is already configured. You should be able to see the latest changes you made by clicking on the App button. Please make sure the required content is loading on the main URL https://<LBR-URL> i.e there should not be a sub-directory like https://<LBR-URL>/web_app etc.


### Решение

1. Подключаемся к jenkins. Ставим plugins:
 - Credentials
 - SSH Credentials
 - SSH
 - SSH Build Agents
 - Pipeline
 - Pipeline: Build Step
 - GIT

2. Подключаемя к getea, смотрим репо. Не приватный. 2 ветки: master, feature

3. Нужно добавить слейв нода, предварительно прописав кредентиалс, и локально на сервере установить java:

`[root@ststor01 ~]# yum install java-11-openjdk-devel.x86_64`

Добавил ноду, по всем условиям. Возможно далее надо будет проверить права на корневой каталог...

ДА, java не может установиться.

`java.io.IOException: Could not copy remoting.jar into '/var/www/html' on agent`

Чиним права:

```bash
[root@ststor01 html]# chmod 777 -R /var/www/html
[root@ststor01 html]# ls -laF
total 20
drwxrwxrwx 3 sarah sarah 4096 May 24 21:47 ./
drwxr-xr-x 3 sarah sarah 4096 May 24 21:45 ../
drwxrwxrwx 8 sarah sarah 4096 May 24 21:47 .git/
-rwxrwxrwx 1 sarah sarah   18 May 24 21:47 feature.html*
-rwxrwxrwx 1 sarah sarah    8 May 24 21:47 index.html*
```
Установился...

`Agent successfully connected and online`

4. Создаем pipeline.

```groovy
pipeline {
    agent { label 'ststor01' }
    
    parameters {
        string(name: 'BRANCH', defaultValue: 'master', description: 'Enter the branch to deploy')
    }
    stages {
        stage('Build') {
            steps {
                script {
                    if (params.BRANCH == 'master') {
                      git branch: "master",
                          url: "http://git.stratos.xfusioncorp.com/sarah/web_app.git"
                } else {
                      git branch: "feature",
                          url: "http://git.stratos.xfusioncorp.com/sarah/web_app.git"      
                }
                sh 'cp /var/www/html/workspace/nautilus-webapp-job/*.html /var/www/html'
                       }
            }
        }
    }
}


```
