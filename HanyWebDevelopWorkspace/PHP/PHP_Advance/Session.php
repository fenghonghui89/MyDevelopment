
<!-- 3-9 session -->

<!--

PHP Session 变量

当您运行一个应用程序时，您会打开它，做些更改，然后关闭它。这很像一次会话。
计算机清楚你是谁。它知道你何时启动应用程序，并在何时终止。
但是在因特网上，存在一个问题：服务器不知道你是谁以及你做什么，这是由于 HTTP 地址不能维持状态。

通过在服务器上存储用户信息以便随后使用，PHP session 解决了这个问题（比如用户名称、购买商品等）。
不过，会话信息是临时的，在用户离开网站后将被删除。如果您需要永久储存信息，可以把数据存储在数据库中。

Session 的工作机制是：为每个访问者创建一个唯一的 id (UID)，并基于这个 UID 来存储变量。UID 存储在 cookie 中，亦或通过 URL 进行传导。

-->




<?php
/*
 * 向服务器注册用户的会话，以便您可以开始保存用户信息，同时会为用户会话分配一个 UID
 * session_start() 函数必须位于 <html> 标签之前：
 * */
session_start();


/*
 * isset() 函数检测是否已设置 "views" 变量。
 * 如果已设置 "views" 变量，我们累加计数器。
 * 如果 "views" 不存在，则我们创建 "views" 变量，并把它设置为 1：
 * */
if(isset($_SESSION['views']))
    $_SESSION['views'] = $_SESSION['views']+1;
else
    $_SESSION['views'] = 1;

echo "Views=". $_SESSION['views'];

?>



<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>php - session</title>
</head>
<body>

<h1>php - session</h1>


<?php
//retrieve session data
echo "Pageviews=". $_SESSION['views'];
?>


<?php
//unset() 函数用于释放指定的 session 变量
unset($_SESSION['views']);

//session_destroy() 函数彻底终结 session 将重置 session，您将失去所有已存储的 session 数据
session_destroy();
?>
</body>
</html>