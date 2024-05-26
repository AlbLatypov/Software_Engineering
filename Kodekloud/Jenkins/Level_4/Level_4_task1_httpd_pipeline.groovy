//Pipeline для установки httpd, настройка конфига и перезапуск сервис
def remote = [:]
remote.name = "stapp01"
remote.host = "172.16.238.10"
remote.allowAnyHosts = true
pipeline {
    agent any
    environment {
        TONY_CREDS = credentials('tony')
    }
    stages {
        stage('Install httpd') {
            steps {
                script{
                    remote.user = env.TONY_CREDS_USR
                    remote.password = env.TONY_CREDS_PSW
                }
                sshCommand (sudo:true, remote: remote, command: 'yum install httpd -y')
                sshCommand (sudo:true, remote: remote, command: 'sed -i "s/Listen 80/Listen 8080/g" /etc/httpd/conf/httpd.conf')
                sshCommand (sudo:true, remote: remote, command: 'systemctl start httpd')
                sshCommand (sudo:true, remote: remote, command: 'systemctl enable httpd')
            }
        }
    }
    // sleep - данные не возращаются, пока ssh канал не будет закрыт.
    post {
        always {
            sleep 5
        }
    }
}
