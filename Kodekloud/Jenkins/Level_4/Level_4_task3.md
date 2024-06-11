# Jenkins MR Jobs

Click on the Jenkins button on the top bar to access the Jenkins UI. Login using username admin and password Adm!n321.

Similarly, click on the Gitea button on the top bar to access the Gitea UI. Login using username sarah and password Sarah_pass123.

There is a repository named sarah/mr_job in Gitea, which is cloned on the Storage server under /home/natasha/mr_job directory.

Update the index.html file under dev branch, and change its content from Welcome to Nautilus Group! to Welcome to xFusionCorp Industries!. Remember to push your changes to the origin repository.

After pushing the required changes, login to the Gitea server and you will find a pull request with title My First PR under mr_job repository. Merge this pull request.

Create/configure a Jenkins pipeline job named nginx-container, configure a pipeline as per details given below and run the pipeline on server App Server 3.

- The pipeline must have two stages Build and Deploy (names are case sensitive).

- In the Build stage, first clone the sarah/mr_job repository, then build an image named stregi01.stratos.xfusioncorp.com:5000/nginx:latest using the Dockerfile present under the root of the repository. stregi01.stratos.xfusioncorp.com:5000 is the image registry server. After building the image push the same to the image registry server.

- In the Deploy stage, create a container named nginx-app using the image you built in the Build stage. Make sure to map container port to the host port 8080 and run the container in detached mode.

- Make sure to build a successful job at least once so that you have at least one successful build # in the job history. Further, you can test the app using command curl http://stapp03:8080 from the jump host.


### Решение

1. Сервер, где будет выполняться pipeline должен быть нодой. Подключаемся, необходимо установить:
`java-11-openjdk-devel.x86_64`

При попытке сделать update ловим ошибки. Исправляем:
```bash
Error: Failed to download metadata for repo 'appstream': Cannot prepare internal mirrorlist: No URLs in mirrorlist

sed -i 's/mirrorlist/#mirrorlist/g' /etc/yum.repos.d/CentOS-*
sed -i 's|#baseurl=http://mirror.centos.org|baseurl=http://vault.centos.org|g' /etc/yum.repos.d/CentOS-*
```

Проверяем, может ли админ выполнять команды Docker.
```bash
[banner@stapp03 ~]$ whoami
banner
[banner@stapp03 ~]$ groups
banner wheel docker
```

2. Jenkins, ставим плагины. Настраиваем ноду на сервер stapp03. Нода в работе. Готовим пайплайн, пока не запускаем.

```groovy
pipeline {
    agent { label 'stapp03'}

    stages {
        stage('Build') {
            steps {
                git branch: "master",
                    url: "http://git.stratos.xfusioncorp.com/sarah/mr_job.git"
                sh "docker build -t stregi01.stratos.xfusioncorp.com:5000/nginx:latest ."
                sh "docker push stregi01.stratos.xfusioncorp.com:5000/nginx:latest"
            }
        }
        stage('Deploy') {
            steps {
                sh "docker run --name nginx-app -p 8080:80 -d stregi01.stratos.xfusioncorp.com:5000/nginx:latest"
            }
        }
    }
}
```
Итоговый

```groovy
pipeline {
    agent { label 'stapp02'}

    stages {
        stage('Build') {
            steps {
                sh """
                rm -rf /home/steve/workspace/nginx-container/mr_job
                git clone http://git.stratos.xfusioncorp.com/sarah/mr_job.git
                cd /home/steve/workspace/nginx-container/mr_job
                docker build -t stregi01.stratos.xfusioncorp.com:5000/nginx:latest .
                docker push stregi01.stratos.xfusioncorp.com:5000/nginx:latest
                """
            }
        }
        stage('Deploy') {
            steps {
                sh """
                docker ps -a --format '{{.Names}}' | grep -q ^nginx-app\$ && docker stop nginx-app && docker rm nginx-app
                docker run --name nginx-app -p 8080:80 -d stregi01.stratos.xfusioncorp.com:5000/nginx:latest
                """
            }
        }
    }
}
```
Проверяем.
```bash
thor@jump_host ~$ curl http://stapp03:8080
Welcome to xFusionCorp Industries!
```

Шаг 3 должен быть выполнен параллельно или ранее шага 2.


3. Переходим на сервер, где у нас склонирован репозиторий, для внесения изменений:
`thor@jump_host ~$ ssh natasha@ststor01`

```bash
[natasha@ststor01 mr_job]$ vi index.html 
[natasha@ststor01 mr_job]$ git status
On branch dev
Changes not staged for commit:
  (use "git add <file>..." to update what will be committed)
  (use "git restore <file>..." to discard changes in working directory)
        modified:   index.html

no changes added to commit (use "git add" and/or "git commit -a")
[natasha@ststor01 mr_job]$ git add .
[natasha@ststor01 mr_job]$ git commit -m "upd:index.html"
[dev 53135f5] upd:index.html
 1 file changed, 1 insertion(+), 1 deletion(-)
[natasha@ststor01 mr_job]$ git push origin dev
```

Выполняем пул реквест на мердж с веткой мастер. На этом тут все.

