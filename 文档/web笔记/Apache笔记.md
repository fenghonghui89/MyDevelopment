
## 开启Apache

- 1.系统编好设置 - 共享 - 互联网共享 打开
- 2.找到Apache藏身之处
  - 命令行 open /etc 文件夹apache2就是Apache配置文件的存放目录
  - cd /etc/apache2
- 3.命令控制启动停止 sudo apachectl start/restart/stop
- 4.默认资源存放目录 /Library/WebServer/Documents/
- 5.浏览器可以输入localhost或者127.0.0.1:端口号访问

## 常用命令

- 检查配置是否正确 apachectl configtest
- 查看版本 httpd -v 或者 apachectl -v


## 常用配置文件说明

- httpd.conf
  - DocumentRoot 默认资源存放目录
  - Listen 默认端口

## 改变默认资源目录

- 1.打开httpd.conf 去掉以下注释

```
LoadModule authz_core_module libexec/apache2/mod_authz_core.so
LoadModule authz_host_module libexec/apache2/mod_authz_host.so
LoadModule userdir_module libexec/apache2/mod_userdir.so
LoadModule include_module libexec/apache2/mod_include.so
LoadModule rewrite_module libexec/apache2/mod_rewrite.so
LoadModule php5_module libexec/apache2/libphp5.so
```

- 2.找到以下

```
<Directory />
    AllowOverride none
    Require all denied
</Directory>
```
改为
```
<Directory />
    AllowOverride All
</Directory>
```

- 3.搜索DocumentRoot，修改为自定义路径，注意路径必须是/Users/{username}/xxx

```
DocumentRoot "/Users/hanyfeng/ApacheWebDoc"
<Directory "/Users/hanyfeng/ApacheWebDoc">
```
里面的AllowOverride None 改为AllowOverride All

- 4.在/etc/apache2/users新建文件username.conf(如果没有)，添加以下内容

```
<Directory "/Users/hanyfeng/ApacheWebDoc">
  AllowOverride All
  Options Indexes MultiViews FollowSymLinks
  Require all granted
</Directory>
```

- 5.保存以上修改，sudo apachectl restart






## 启动虚拟主机

- 1.打开/etc/apache2/httpd.conf 找到下面语句，解除注释

```
#LoadModule php5_module libexec/apache2/libphp5.so
#LoadModule userdir_module libexec/apache2/mod_userdir.so

#Include /private/etc/apache2/extra/httpd-vhosts.conf
#Include /private/etc/apache2/extra/httpd-userdir.conf
```

- 2.打开/etc/apache2/extra/httpd-userdir.conf，找到下面语句，解除注释

```
#Include /private/etc/apache2/users/*.conf
```

- 3.打开/etc/apache2/users/username.conf，添加如下配置（如果没有）

```
<Directory "/Users/hanyfeng/ApacheWebDoc">
  AllowOverride All
  Options Indexes MultiViews FollowSymLinks
  Require all granted
</Directory>
```

- 4.打开/etc/apache2/extra/httpd-vhosts.conf 里面的例子实际上是不存在的，注释掉，然后增加如下配置

```
<VirtualHost *:80>
    DocumentRoot "/Library/WebServer/Documents"
    ServerName localhost
    ErrorLog "/Users/hanyfeng/Desktop/ApacheErrorLog/localhost-error_log"
    CustomLog "/Users/hanyfeng/Desktop/ApacheCustomLog/localhost-access_log" common
</VirtualHost>

<VirtualHost *:80>
    DocumentRoot "/Users/hanyfeng/ApacheWebDoc"
    ServerName mysites
    ErrorLog "/Users/hanyfeng/Desktop/ApacheErrorLog/sites-error_log"
    CustomLog "/Users/hanyfeng/Desktop/ApacheCustomLog/sites-access_log" common
    <Directory />
        Options Indexes FollowSymLinks MultiViews
        AllowOverride None
        Order deny,allow
        Allow from all
    </Directory>
</VirtualHost>
```

- 5.打开/etc/hosts，添加如下语句

```
127.0.0.1 mysites
```

- 6.用apachectl configtest检查配置，ok就重启Apache，然后就可以在浏览器输入http://mysites访问
