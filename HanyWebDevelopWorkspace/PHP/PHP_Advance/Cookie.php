
<!-- 3-8 cookie-->

<!--setcookie() 函数必须位于 <html> 标签之前。-->
<?php
setcookie("user", "HanyFeng", time()+3600);
?>

<!DOCTYPE html>
<html lang="en">
<header>
    <meta charset="UTF-8">
    <title>php - cookie</title>
</header>

<body>



<!--$_COOKIE 变量用于取回 cookie 的值-->
<?php
// Print a cookie
echo $_COOKIE["user"]."<br>";

// A way to view all cookies
print_r($_COOKIE);
?>




<br/>
<!--使用 isset() 函数来确认是否已设置了 cookie-->
<?php
if (isset($_COOKIE["user"]))
    echo "Welcome " . $_COOKIE["user"] . "!<br />";
else
    echo "Welcome guest!<br />";
?>



<br/>
<!--当删除 cookie 时，您应当使过期日期变更为过去的时间点。-->
<?php
//// set the expiration date to one hour ago
//setcookie("user", "", time()-3600);
//?>
</body>

</html>