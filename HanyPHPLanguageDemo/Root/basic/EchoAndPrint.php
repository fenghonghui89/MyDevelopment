<?php
/**
 * Created by PhpStorm.
 * User: hanyfeng
 * Date: 16/7/28
 * Time: 15:32
 */
//1-2 echo与print

function root_EchoAndPrint(){

    kl_EchoAndPrint_echo_string();//echo显示字符串
//    kl_EchoAndPrint_echo_variable();//echo显示变量
//    kl_EchoAndPrint_print_string();//print显示字符串
//    kl_EchoAndPrint_print_variable();//print显示变量
}


//echo显示字符串
function kl_EchoAndPrint_echo_string(){

    echo "<h2>PHP is fun!</h2>";
    echo "Hello world!<br/>";
    echo "I'm about to learn PHP!<br/>";
    echo "This"," string"," was"," made"," with multiple parameters.";
}


//echo显示变量
function kl_EchoAndPrint_echo_variable(){

    $txt1 = "Learn PHP";
    $txt2 = "W3School.com.cn";
    $cars = array("Volvo","BMW","SAAB");

    echo $txt1;
    echo "<br/>";
    echo "Study PHP at $txt2<br/>";
    echo "My car is a $cars[0]";
}

//print显示字符串
function kl_EchoAndPrint_print_string(){

    print "<h2>PHP is fun!</h2>";
    print "Hello world!<br/>";
    print "I'm about to learn PHP!";
}

//print显示变量
function kl_EchoAndPrint_print_variable(){

    $txt1 = "Learn PHP";
    $txt2 = "W3School.com.cn";
    $cars = array("Volvo","BMW","SAAB");

    print $txt1;
    print "<br/>";
    print "Study PHP at $txt2<br/>";
    print "My car is a $cars[0]";
}