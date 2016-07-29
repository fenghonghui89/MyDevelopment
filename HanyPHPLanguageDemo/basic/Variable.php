<?php
/**
 * Created by PhpStorm.
 * User: hanyfeng
 * Date: 16/7/28
 * Time: 12:53
 */
//变量


function root_Variable(){

//    kl_scope();

//    kl_global();

//    kl_globalIndex();

//    kl_static();
//    kl_static();
}

//作用域
$x = 10;
$y = 20;
function kl_scope(){

    $z = 30;
    echo "$z <br>";//30
    echo "$x";//报错

}

//global 关键词
function kl_global(){

    global $x,$y;
    $y = $x+$y;
    echo $y;
}

//$GLOBALS[index]
function kl_globalIndex(){

    $GLOBALS['y'] = $GLOBALS['x'] + $GLOBALS['y'];
    echo $GLOBALS['y'];
}

//static关键字
function kl_static(){

    static $s = 10;
    $s+=1;
    echo "$s <br>";
}