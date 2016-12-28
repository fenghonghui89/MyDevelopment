<!DOCTYPE html>
<html lang="en">
<header>
    <meta charset="UTF-8">
    <title>php - 表单</title>
    <link href="../../src/MainFiles/MainCSS.css" type="text/css" rel="stylesheet">
</header>


<body>

<!------------------------------------------------------------------目录------------------------------------------------------------------>
<h1 id="root_menu"><b>目录</b></h1>
<br />

<h2>php 表单</h2>
<a href="#php_formProcess">2-1 php 表单处理</a><br />
<a href="#php_formCheck">2-2~2-5 php 表单验证/必填/正则匹配/完成</a>


<!------------------------------------------------------------------2-1 php 表单处理------------------------------------------------------------------>
<h1 class="HeaderTitle" id="php_formProcess">php 表单处理</h1>
<a href="#root_menu">回到目录</a>
<hr />

<form method="post" action="PHP_FormProcess.php">
    your name:<input type="text" name="name" value="hany"/><br/>
    you email:<input type="text" name="email" value="112233@qq.com"/><br/>
    <input type="submit" value="submit"/>
</form>
<br/><br/><br/>


<!------------------------------------------------------------------2-2~2-5 php 表单验证/必填/正则匹配/完成------------------------------------------------------------------>
<h1 class="HeaderTitle" id="php_formCheck">2-2~2-5 php 表单验证/必填/正则匹配/完成</h1>
<a href="#root_menu">回到目录</a>
<hr />


<?php

// 定义变量并设置为空值
$nameErr = $emailErr = $genderErr = $websiteErr = "";
$name = $email = $gender = $comment = $website = "no data";

if ($_SERVER["REQUEST_METHOD"] == "POST") {
    if (empty($_POST["name"])) {
        $nameErr = "姓名是必填的";
    } else {
        $name = test_input($_POST["name"]);
        // 检查姓名是否包含字母和空白字符
        if (!preg_match("/^[a-zA-Z ]*$/",$name)) {
            $nameErr = "只允许字母和空格";
        }
    }

    if (empty($_POST["email"])) {
        $emailErr = "电邮是必填的";
    } else {
        $email = test_input($_POST["email"]);
        // 检查电子邮件地址语法是否有效
        if (!preg_match("/([\w\-]+\@[\w\-]+\.[\w\-]+)/",$email)) {
            $emailErr = "无效的 email 格式";
        }
    }

    if (empty($_POST["website"])) {
        $website = "";
    } else {
        $website = test_input($_POST["website"]);
        // 检查 URL 地址语法是否有效（正则表达式也允许 URL 中的斜杠）
        if (!preg_match("/\b(?:(?:https?|ftp):\/\/|www\.)[-a-z0-9+&@#\/%?=~_|!:,.;]*[-a-z0-9+&@#\/%=~_|]/i",$website)) {
            $websiteErr = "无效的 URL";
        }
    }

    if (empty($_POST["comment"])) {
        $comment = "";
    } else {
        $comment = test_input($_POST["comment"]);
    }

    if (empty($_POST["gender"])) {
        $genderErr = "性别是必选的";
    } else {
        $gender = test_input($_POST["gender"]);
    }

//    echo $name."<br/>".$email."<br/>".$website."<br/>".$comment."<br/>".$gender;
//    echo "<script>alert('退出成功!');location.href='".$_SERVER["HTTP_REFERER"]."';</script>";
}


function test_input($data) {

    //通过 PHP trim() 函数）去除用户输入数据中不必要的字符（多余的空格、制表符、换行）
    $data = trim($data);

    //通过 PHP stripslashes() 函数）删除用户输入数据中的反斜杠（\）
    $data = stripslashes($data);

    /*
     * htmlspecialchars() 函数把特殊字符转换为 HTML 实体。
     * 这意味着 < 和 > 之类的 HTML 字符会被替换为 &lt; 和 &gt; 。
     * 这样可防止攻击者通过在表单中注入 HTML 或 JavaScript 代码（跨站点脚本攻击）对代码进行利用。
     * */
    $data = htmlspecialchars($data);

    return $data;
}

?>

<!--
$_SERVER["PHP_SELF"] 是一种超全局变量，它返回当前执行脚本的文件名。
因此，$_SERVER["PHP_SELF"] 将表单数据发送到页面本身，而不是跳转到另一张页面。这样，用户就能够在表单页面获得错误提示信息。

htmlspecialchars() 函数把特殊字符转换为 HTML 实体。这意味着 < 和 > 之类的 HTML 字符会被替换为 &lt; 和 &gt; 。
这样可防止攻击者通过在表单中注入 HTML 或 JavaScript 代码（跨站点脚本攻击）对代码进行利用
-->
<p><span class="error">* 必需的字段</span></p>
<form method="post" action="<?php echo htmlspecialchars($_SERVER["PHP_SELF"]);?>">
    姓名：<input type="text" name="name" required="required" placeholder="please input name!">
    <span class="error">* <?php echo $nameErr;?></span>
    <br><br>
    电邮：<input type="text" name="email" required="required" placeholder="please input email!">
    <span class="error">* <?php echo $emailErr;?></span>
    <br><br>
    网址：<input type="text" name="website">
    <span class="error"><?php echo $websiteErr;?></span>
    <br><br>
    评论：<textarea name="comment" rows="5" cols="40"></textarea>
    <br><br>
    性别：<span class="error">* <?php echo $genderErr;?></span>
    <br/>
    <label for="id_php_form_female">女性</label>
    <input type="radio" name="gender" value="female" id="id_php_form_female">
    <br/>
    <label for="id_php_form_male">男性</label>
    <input type="radio" name="gender" value="male" id="id_php_form_male">
    <br><br>
    <input type="submit" name="submit" value="提交">
</form>

<?php
echo "<h2>您的输入：</h2>";
echo "name:".$name."<br>";
echo "email:".$email."<br>";
echo "website:".$website."<br>";
echo "comment:".$comment."<br>";
echo "gender:".$gender."<br>";
?>


</body>

</html>