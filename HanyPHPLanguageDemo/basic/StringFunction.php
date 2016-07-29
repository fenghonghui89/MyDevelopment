<?php
/**
 * Created by PhpStorm.
 * User: hanyfeng
 * Date: 16/7/28
 * Time: 16:37
 */
//字符串函数

function root_StringFunction(){

//    kl_strlen();
    kl_strpos();
}


//strlen() 函数返回字符串的长度，以字符计
function kl_strlen(){

    echo strlen("Hello world!");//12
}

//strpos() 函数用于检索字符串内指定的字符或文本
function kl_strpos(){

    echo strpos("Hello world!","world");//6 代表起始位置
}