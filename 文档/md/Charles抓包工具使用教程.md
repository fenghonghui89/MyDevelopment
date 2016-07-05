
## 基本用法

1. 安装Charles
2. 用数据线连接手机和mac
3. 手机wifi设置如下
![](http://o9ivu69va.bkt.clouddn.com/charles_1.3.png)
4. 打开Charles，即可进行抓包分析，如下图
![](http://o9ivu69va.bkt.clouddn.com/charle_1.4.png)

&ensp;
&ensp;
&ensp;
&ensp;
&ensp;

## 分析https请求
如果请求是https请求，抓包会是乱码，需要进行额外配置才能查看具体数据

1. 手机配置好http代理后，用手机浏览器打开http://charlesproxy.com/getssl，安装证书
2. 打开Charles – proxy – SSL Proxy Settings – 添加需要解析的https地址和端口号（https一般是443），如下图
![](http://o9ivu69va.bkt.clouddn.com/charles_2.2.png)
3. 设置好后https请求的相关数据将得到解密，不会再是乱码，如下图
![](http://o9ivu69va.bkt.clouddn.com/charle_1.4.png)
