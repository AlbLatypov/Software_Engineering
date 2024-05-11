# Создание собственного репозитория, пакеты уже размещены в каталоге

Certainly! Here are the steps to accomplish the tasks you've described:

a. Assuming the packages are already present at the location /packages/downloaded_rpms/ on the Nautilus Backup Server:

b. Create a yum repository named epel_local and configure it to use the package location /packages/downloaded_rpms/:

__Create the repository configuration file:__

`sudo vi /etc/yum.repos.d/epel_local.repo`

Add the following content to the file:

    [epel_local]
    name=EPEL Local Repository
    baseurl=file:///packages/downloaded_rpms/
    enabled=1
    gpgcheck=0
    repo_gpgcheck=0

- [epel_local]: This is the Repository ID, which is set to epel_local.
- name=EPEL Local Repository: This is the name of the repository.
- baseurl=file:///packages/downloaded_rpms/: This is the location of the packages.
- enabled=1: This enables the repository.
- gpgcheck=0: This disables the GPG key check.
- repo_gpgcheck=0: This disables the repository metadata GPG check.

c. Install the wget package from the newly created epel_local repository:

`sudo yum install -y --disablerepo=* --enablerepo=epel_local wget`

 - disablerepo=*: This disables all other repositories.
 - enablerepo=epel_local: This enables the epel_local repository.
 - wget: This is the package to be installed.
