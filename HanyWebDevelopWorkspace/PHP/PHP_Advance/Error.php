

<!-- 3-12 error -->




<?php




#简单的die语句
if(!file_exists("welcome.txt"))
{
    die("File not found");//输出并终止脚本
}
else
{
    $file = fopen("welcome.txt","r");
}




#创建自定义错误处理器
/*
该函数必须有能力处理至少两个参数 (error level 和 error message)，但是可以接受最多五个参数
error_function(error_level,error_message,error_file,error_line,error_context)

error_level必需。为用户定义的错误规定错误报告级别。必须是一个值数。参见下面的表格：错误报告级别。
error_message 	必需。为用户定义的错误规定错误消息。
error_file 	可选。规定错误在其中发生的文件名。
error_line 	可选。规定错误发生的行号。
error_context 	可选。规定一个数组，包含了当错误发生时在用的每个变量以及它们的值。

默认地，根据在 php.ini 中的 error_log 配置，PHP 向服务器的错误记录系统或文件发送错误记录。
通过使用 error_log() 函数，您可以向指定的文件或远程目的地发送错误记录。
这个方法不适合所有的错误。常规错误应当通过使用默认的 PHP 记录系统在服务器上进行记录。
*/

//error handler function 实现了两个必选参数
function customError($errno, $errstr)
{
    echo "<b>Error:</b> [$errno] $errstr<br />";
    echo "Webmaster has been notified";
    error_log("ErrorMessage: [$errno] $errstr",1,"someone@example.com","From: webmaster@example.com");
}

//set error handler 该函数仅需要一个参数，可以添加第二个参数来规定错误级别
set_error_handler("customError",E_USER_WARNING);

//trigger error
$test=2;
if ($test>1)
{
    //触发错误 通过添加的第二个参数，您能够规定所触发的错误级别
    trigger_error("Value must be 1 or below",E_USER_WARNING);
}

