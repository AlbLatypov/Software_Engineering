### Save, Load and Transfer Docker Image

One of the DevOps team members was working on to create a new custom docker image on App Server 1 in Stratos DC. He is done with his changes and image is saved on same server with name media:nautilus. Recently a requirement has been raised by a team to use that image for testing, but the team wants to test the same on App Server 3. So we need to provide them that image on App Server 3 in Stratos DC.

a. On App Server 1 save the image media:nautilus in an archive.

b. Transfer the image archive to App Server 3.

c. Load that image archive on App Server 3 with same name and tag which was used on App Server 1.

Note: Docker is already installed on both servers; however, if its service is down please make sure to start it.

[Документация по задаче. Docker Save](../Docs/docker%20save.md)
[Документация по задаче. Docker Load](../Docs/docker%20load.md)

#### Решение

```bash
[tony@stapp01 transfer]$ docker images
REPOSITORY          TAG                 IMAGE ID            CREATED             SIZE
media               nautilus            1806405f3deb        7 minutes ago       76.2MB
ubuntu              latest              bf3dc08bfed0        9 days ago          76.2MB
[tony@stapp01 transfer]$ 

[tony@stapp01 transfer]$ docker save --output media.nautilus.tar 1806405f3deb

[tony@stapp01 transfer]$ ls
media.nautilus.tar

[tony@stapp01 transfer]$ scp media.nautilus.tar banner@stapp03:/tmp
banner@stapp03's password: 
media.nautilus.tar 

[tony@stapp01 transfer]$ ssh banner@stapp03
banner@stapp03's password: 
Permission denied, please try again.
banner@stapp03's password: 
Permission denied, please try again.
banner@stapp03's password: 

[banner@stapp03 ~]$ cd /tmp

[banner@stapp03 tmp]$ ls -la
-rw------- 1 banner banner 78756864 May  9 11:38 media.nautilus.tar

[banner@stapp03 tmp]$ docker image load --input media.nautilus.tar 

80098e3d304c: Loading layer [==================================================>]  78.74MB/78.74MB
7436ae575a7f: Loading layer [==================================================>]  6.656kB/6.656kB
Loaded image ID: sha256:1806405f3deb99ddf2dd504590161f3937b8d635695ea9620dacaeaf07d27555

[banner@stapp03 tmp]$ docker images
REPOSITORY          TAG                 IMAGE ID            CREATED             SIZE
<none>              <none>              1806405f3deb        14 minutes ago      76.2MB

[banner@stapp03 tmp]$ docker tag 1806405f3deb media:nautilus

[banner@stapp03 tmp]$ docker images
REPOSITORY          TAG                 IMAGE ID            CREATED             SIZE
media               nautilus            1806405f3deb        15 minutes ago      76.2MB
```
