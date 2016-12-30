<?php
/**
 * Created by PhpStorm.
 * User: hanyfeng
 * Date: 16/7/28
 * Time: 15:32
 */
//1-2 echo与print


/**
 * echo 和 print 之间的差异：
 * echo - 能够输出一个以上的字符串
 * print - 只能输出一个字符串，并始终返回 1
 *
*/

//    kl_EchoAndPrint_echo_string();//echo显示字符串
//    kl_EchoAndPrint_echo_variable();//echo显示变量
//    kl_EchoAndPrint_print_string();//print显示字符串
    kl_EchoAndPrint_print_variable();//print显示变量









//echo显示字符串
function kl_EchoAndPrint_echo_string(){

    echo "<h2>PHP is fun!</h2>";//PHP is fun!
    echo "Hello world!","<br/>";//Hello world!
    echo "I'm about to learn PHP!","<br/>";//I'm about to learn PHP!
    echo "This"," string"," was"," made"," with multiple parameters.";//This string was made with multiple parameters.
}


//echo显示变量
function kl_EchoAndPrint_echo_variable(){

    $txt1 = "Learn PHP";
    $txt2 = "W3School.com.cn";
    $cars = array("Volvo","BMW","SAAB");

    echo $txt1,"<br/>";//Learn PHP
    echo "Study PHP at $txt2","<br/>";//Study PHP at W3School.com.cn
    echo "My car is a $cars[0]";//My car is a Volvo
}

//print显示字符串
function kl_EchoAndPrint_print_string(){

    print "<h2>PHP is fun!</h2>";//PHP is fun!
    print "Hello world!<br/>";//Hello world!
    print "I'm about to learn PHP!<br/>";//Hello world!

    $ii = print "xxxxx<br/>";//xxxxx
    echo $ii;//1
}

//print显示变量
function kl_EchoAndPrint_print_variable(){

    $txt1 = "Learn PHP";
    $txt2 = "W3School.com.cn";
    $cars = array("Volvo","BMW","SAAB");

    print $txt1;//Learn PHP
    print "<br/>";
    print "Study PHP at $txt2<br/>";//Study PHP at W3School.com.cn
    print "My car is a $cars[0]";//My car is a Volvo
}