<?php
/**
 * Created by PhpStorm.
 * User: hanyfeng
 * Date: 16/7/28
 * Time: 16:44
 */
//常量

function root_Constant(){

    kl_setConstant();
}

//define() 设置 PHP 常量
function kl_setConstant(){

    /*
     *首个参数定义常量的名称
     *第二个参数定义常量的值
     *可选的第三个参数规定常量名是否对大小写敏感。默认是 false。
     */
    define("GREETING", "Welcome to W3School.com.cn!");
    echo GREETING;//Welcome to W3School.com.cn!
}

