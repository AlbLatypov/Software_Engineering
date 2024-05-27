# Tomcat about

Apache Tomcat сервер есть реализация веб-контейнера сервера приложений Java, которая используется для развертывания и выполнения веб-приложений Java. Он был разработан Apache Software Foundation и основан на Java Servlet и JavaServer Pages (JSP) технологиях.

Tomcat сервер предназначен для выполнения следующих задач:

- Развертывание веб-приложений Java: Tomcat сервер позволяет разработчикам размещать и запускать веб-приложения Java на веб-сервере.
- Поддержка Java Servlet и JavaServer Pages (JSP): Tomcat сервер поддерживает Java Servlet и JSP технологии, которые позволяют разработчикам создавать динамические веб-страницы и приложения на Java.
- Обеспечение безопасности: Tomcat сервер включает механизмы безопасности, такие как аутентификация и авторизация пользователей, которые помогают защитить приложения Java от несанкционированного доступа.
- Распределенная обработка: Tomcat сервер может быть использован в распределенной среде для обработки запросов к приложениям Java на нескольких серверах.
- Поддержка нескольких приложений: Tomcat сервер позволяет запускать несколько приложений Java одновременно, что делает его идеальным решением для размещения нескольких приложений на одном сервере.
- Поддержка нескольких версий Java: Tomcat сервер поддерживает несколько версий языка программирования Java, что позволяет разработчикам использовать ту версию Java, которая наилучшим образом соответствует их приложению.
- Управление ресурсами: Tomcat сервер включает механизмы управления ресурсами, такие как управление памятью и потоками, которые помогают оптимизировать производительность сервера.

Все эти задачи делают Tomcat сервер одним из самых популярных решений для развертывания и выполнения приложений Java. Он широко используется в различных отраслях, таких как финансы, здравоохранение, розничная торговля и других.


### Установка и настройка. Порт, приложение

1. Configure Tomcat Port:

1. Edit server.xml:
    - Open the Tomcat configuration file, typically located at /usr/share/tomcat/conf/server.xml (or a similar path depending on your installation).
    - Find the <Connector> element responsible for HTTP connections. It usually looks like this:
```bash
<Connector port="8080" protocol="HTTP/1.1"
           connectionTimeout="20000"
           redirectPort="8443" />
```
Change the port attribute to "5000":
```bash
<Connector port="5000" protocol="HTTP/1.1"
           connectionTimeout="20000"
           redirectPort="8443" />
```
    
2. Restart Tomcat:
    Use the appropriate command for your system (e.g., sudo systemctl restart tomcat or sudo service tomcat restart).

3. Transfer and Deploy the WAR File:

    Transfer ROOT.war:
    - From your jump host, use scp (secure copy) to transfer the file:

    - scp /tmp/ROOT.war <tomcat_user>@stapp01:/path/to/tomcat/webapps/ 

        Replace <tomcat_user> with the appropriate Tomcat user (e.g., tomcat) and /path/to/tomcat/webapps/ with the actual path to your Tomcat's webapps directory.

    Deploy (Optional):
    - Tomcat should automatically deploy the ROOT.war file when it detects it in the webapps directory. You may need to restart Tomcat if it doesn't deploy automatically.
    - If you need more control over deployment, you can use the Tomcat Manager web application.

3. Test the Webpage:

    - On the Tomcat server (stapp01), run:

    - curl http://localhost:5000/

    If successful, you should see the content of your webpage.

Important Notes:

- Firewall: Ensure that port 5000 is open on your server's firewall to allow incoming traffic.
- SELinux: If you're using SELinux, you may need to adjust the context of the /path/to/tomcat/webapps directory to allow Tomcat to read and write files there.

Troubleshooting:

- Deployment Errors: Check the Tomcat logs (usually in the logs directory under your Tomcat installation) for any error messages during deployment.
- Port Conflicts: Make sure no other service is using port 5000 on your server.
- Webpage Errors: If you see errors in your web page, check the Tomcat logs and your application's logs for clues.

