

<!-- 2-2 php 表单验证-->
<?php

// define variables and set to empty values
$name = $email = $gender = $comment = $website = "";

if ($_SERVER["REQUEST_METHOD"] == "POST") {
    $name = test_input($_POST["name"]);
    $email = test_input($_POST["email"]);
    $website = test_input($_POST["website"]);
    $comment = test_input($_POST["comment"]);
    $gender = test_input($_POST["gender"]);

    echo $name."<br/>".$email."<br/>".$website."<br/>".$comment."<br/>".$gender;
    echo "<script>alert('退出成功!');location.href='".$_SERVER["HTTP_REFERER"]."';</script>";
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
