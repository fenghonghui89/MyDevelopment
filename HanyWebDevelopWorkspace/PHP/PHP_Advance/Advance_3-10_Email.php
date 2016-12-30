

<!--3-10 email  3-11 安全email-->

<!DOCTYPE>
<html lang="en">

<header>
    <meta charset="UTF-8">
    <title>php - email</title>
</header>

<body>

<?php

/**

mail(to,subject,message,headers,parameters)
to 	必需。规定 email 接收者。
subject 	必需。规定 email 的主题。注释：该参数不能包含任何新行字符。
message 	必需。定义要发送的消息。应使用 LF (\n) 来分隔各行。
headers 	可选。规定附加的标题，比如 From、Cc 以及 Bcc。应当使用 CRLF (\r\n) 分隔附加的标题。
parameters 	可选。对邮件发送程序规定额外的参数。
PHP 需要一个已安装且正在运行的邮件系统，以便使邮件函数可用。所用的程序通过在 php.ini 文件中的配置设置进行定义。
*/


//判断是否有填写email 但无效?
if(isset($_REQUEST["mailto"])){

    //check if the email address is invalid
    $mailcheck = spamcheck($_REQUEST['mailto']);
    if ($mailcheck==FALSE)
    {
        echo "Invalid input";
    }
    else
    {//send email
        $mailTo = $_REQUEST["mailto"];
        $subject = $_REQUEST["subject"];
        $message = $_REQUEST["message"];
        $mailFrom = "hanyfeng89@163.com";
        mail($mailTo,$subject,$message,"From:$mailFrom");

        echo "$mailTo <br/>","$subject <br/>","$message <br/>","$mailFrom <br/>";
        echo "Thank you to using our email system.";
    }

}else{
    echo "no eamil!!!";
}

#用php过滤器对输入进行验证
function spamcheck($field)
{
    //filter_var() sanitizes the e-mail
    //address using FILTER_SANITIZE_EMAIL 从字符串中删除电子邮件的非法字符
    $field = filter_var($field, FILTER_SANITIZE_EMAIL);

    //filter_var() validates the e-mail
    //address using FILTER_VALIDATE_EMAIL 验证电子邮件地址
    if(filter_var($field, FILTER_VALIDATE_EMAIL))
    {
        return TRUE;
    }
    else
    {
        return FALSE;
    }
}

?>

<form method="post" action="<?php echo htmlspecialchars($_SERVER["PHP_SELF"]);?>">
    mail to:<input type="text" name="mailto">
    <br/>
    subject:<input type="text" name="subject">
    <br/>
    message:<textarea role="5" name="message" cols="40"></textarea>
    <br/>
    <input type="submit" name="submit" value="提交">
</form>

</body>
</html>