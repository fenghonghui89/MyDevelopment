<?php
/**
 * Created by PhpStorm.
 * User: hanyfeng
 * Date: 16/7/28
 * Time: 12:53
 */
# 1-1 变量

/*

函数之外声明的变量拥有 Global 作用域，只能在函数以外进行访问。
函数内部声明的变量拥有 LOCAL 作用域，只能在函数内部进行访问。

 * */

function root_Basic_Variable(){



//    kl_basic_scope();//作用域
//    kl_basic_global();//global关键字
    kl_basic_globalIndex();//$GLOBALS[index]


    //static关键字
//    kl_basic_static();//11
//    kl_basic_static();//12
}



//作用域
$x = 30;
$y = 20;
function kl_basic_scope(){

    $z = 30;
    echo "$z <br/>";
//    echo $x;//报错
}



//global关键词用于访问函数内的全局变量
function kl_basic_global(){

    global $x,$y;
    $y = $x+$y;
    echo "$y <br/>";//50
}



//$GLOBALS[index]
/*
PHP 同时在名为 $GLOBALS[index] 的数组中存储了所有的全局变量。下标存有变量名。这个数组在函数内也可以访问，并能够用于直接更新全局变量。
*/
function kl_basic_globalIndex(){

    $GLOBALS['y'] = $GLOBALS['x'] + $GLOBALS['y'];
    echo $GLOBALS['y'];//50
}




//static关键字 保持变量的值
function kl_basic_static(){

    static $s = 10;
    $s+=1;
    echo "$s <br/>";
}