
## 开启Apache

- 1.系统编好设置 - 共享 - 互联网共享 打开
- 2.找到Apache藏身之处
  - 命令行 open /etc 文件夹apache2就是Apache配置文件的存放目录
  - cd /etc/apache2
- 3.命令控制启动停止 sudo apachectl start/restart
- 4.默认资源存放目录 /Library/WebServer/Documents/
- 5.浏览器可以输入localhost或者127.0.0.1:端口号访问

## 常用命令

- apachectl configtest
- 查看版本 httpd -v

## 常用配置文件说明

- httpd.conf
  - DocumentRoot 默认资源存放目录
  - Listen 默认端口

## 启动虚拟主机

- 1.在终端运行“sudo vi /etc/apache2/httpd.conf”，打开Apche的配置文件
- 2.在httpd.conf中找到“#Include /private/etc/apache2/extra/httpd-vhosts.conf”，去掉前面的“＃”，保存并退出。
- 3.运行“sudo apachectl restart”，重启Apache后就开启了虚拟主机配置功能。
- 4.运行“sudo vi /etc/apache2/extra/httpd-vhosts.conf”，就打开了配置虚拟主机文件httpd-vhost.conf，配置虚拟主机了。需要注意的是该文件默认开启了两个作为例子的虚拟主机，而实际上，这两个虚拟主机是不存在的，在没有配置任何其他虚拟主机时，可能会导致访问localhost时出现如下提示

```
Forbidden
You don't have permission to access /index.php on this server
```
最简单的办法就是在它们每行前面加上#，注释掉就好了，这样既能参考又不导致其他问题

- 5.增加如下配置

```
<VirtualHost *:80>
    DocumentRoot "/Library/WebServer/Documents"
    ServerName localhost
    ErrorLog "/private/var/log/apache2/localhost-error_log"
    CustomLog "/private/var/log/apache2/localhost-access_log" common
</VirtualHost>

<VirtualHost *:80>
    DocumentRoot "/Users/snandy/work"
    ServerName mysites
    ErrorLog "/private/var/log/apache2/sites-error_log"
    CustomLog "/private/var/log/apache2/sites-access_log" common
    <Directory />
                Options Indexes FollowSymLinks MultiViews
                AllowOverride None
                Order deny,allow
                Allow from all
      </Directory>
</VirtualHost>
```

- 6.运行“sudo vi /etc/hosts”，打开hosts配置文件，加入"127.0.0.1 mysites"，这样就可以配置完成sites虚拟主机了，可以访问“http://mysites”了
