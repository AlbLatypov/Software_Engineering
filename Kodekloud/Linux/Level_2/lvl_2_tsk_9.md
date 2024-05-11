# Configure Local Yum repos

The Nautilus production support team and security team had a meeting last month in which they decided to use local yum repositories for maintaing packages needed for their servers. For now they have decided to configure a local yum repo on Nautilus Backup Server. This is one of the pending items from last month, so please configure a local yum repository on Nautilus Backup Server as per details given below.


a. We have some packages already present at location /packages/downloaded_rpms/ on Nautilus Backup Server.

b. Create a yum repo named epel_local and make sure to set Repository ID to epel_local. Configure it to use package's location /packages/downloaded_rpms/.

c. Install package wget from this newly created repo.



### Решение

Не выполнял ранее таких задач. Общаемся с чат GPT. [Ссылка на решение](../docs/repo.epel_local.md). Разобрал.

```bash
[clint@stbkp01 downloaded_rpms]$ sudo vi /etc/yum.repos.d/epel_local.repo

[epel_local]
name=EPEL Local Repository
baseurl=file:///packages/downloaded_rpms/
enabled=1
gpgcheck=0
repo_gpgcheck=0


clint@stbkp01 downloaded_rpms]$ sudo yum repolist

[sudo] password for clint: 
Updating Subscription Management repositories.
Unable to read consumer identity

This system is not registered with an entitlement server. You can use subscription-manager to register.

repo id                                                    repo name
epel_local                                                 EPEL Local Repository

[clint@stbkp01 downloaded_rpms]$ sudo yum update

Updating Subscription Management repositories.
Unable to read consumer identity

This system is not registered with an entitlement server. You can use subscription-manager to register.

EPEL Local Repository                                                                           7.5 MB/s |  59 kB     00:00    
Dependencies resolved.
Nothing to do.
Complete!

[clint@stbkp01 downloaded_rpms]$ sudo yum install wget

```



