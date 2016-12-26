<?php
/**
 * Created by PhpStorm.
 * User: hanyfeng
 * Date: 16/7/28
 * Time: 16:37
 */
//1-4字符串函数


//    kl_strlen();//返回字符串长度
    kl_strpos();//检索字符串内的字符或文本






//strlen() 函数返回字符串的长度，以字符计
function kl_strlen(){

    echo strlen("Hello world!");//12
}




//strpos() 函数用于检索字符串内指定的字符或文本 如果找到匹配，则会返回首个匹配的字符位置。如果未找到匹配，则将返回 FALSE
function kl_strpos(){

    echo strpos("Hello world!","world");//6 代表起始位置
}