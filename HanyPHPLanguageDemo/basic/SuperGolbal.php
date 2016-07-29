<?php
/**
 * Created by PhpStorm.
 * User: hanyfeng
 * Date: 16/7/29
 * Time: 14:38
 */
//超全局变量

function root_SuperGolbal(){

//    kl_superGlobals_globals_result();
    kl_superGlobals_server();
}

//$GLOBALS — 引用全局作用域中可用的全部变量
$x = 75;
$y = 25;
function kl_superGlobals_globals(){

    $GLOBALS['z'] = $GLOBALS['x'] + $GLOBALS['y'];

}

function kl_superGlobals_globals_result(){

    kl_superGlobals_globals();
    echo $GLOBALS['z'];//100
}

//$_SERVER 保存关于报头、路径和脚本位置的信息
function kl_superGlobals_server(){

    echo $_SERVER['PHP_SELF'],"<br>";//返回当前执行脚本的文件名
    echo $_SERVER['SERVER_NAME'],"<br>";//返回当前运行脚本所在的服务器的主机名（比如 www.w3school.com.cn）
    echo $_SERVER['HTTP_HOST'],"<br>";//返回来自当前请求的 Host 头
    echo $_SERVER['HTTP_REFERER'],"<br>";//返回当前页面的完整 URL（不可靠，因为不是所有用户代理都支持）
    echo $_SERVER['HTTP_USER_AGENT'],"<br>";//userAgent
    echo $_SERVER['SCRIPT_NAME'],"<br>";//返回当前脚本的路径
}