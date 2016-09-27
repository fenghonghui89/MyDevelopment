<?php
/**
 * Created by PhpStorm.
 * User: hanyfeng
 * Date: 2016/9/27
 * Time: 12:39
 */
//3-2 日期

/*

date(format,timestamp)
format 	必需。规定时间戳的格式。
timestamp 	可选。规定时间戳。默认是当前时间和日期。
注释：时间戳是一种字符序列，它表示具体事件发生的日期和事件。


下面列出了一些常用于日期的字符：

    d - 表示月里的某天（01-31）
    m - 表示月（01-12）
    Y - 表示年（四位数）
    1 - 表示周里的某天


下面是常用于时间的字符：

    h - 带有首位零的 12 小时小时格式
    i - 带有首位零的分钟
    s - 带有首位零的秒（00 -59）
    a - 小写的午前和午后（am 或 pm）


 */


//    kl_simpleDate();//获得简单的日期
//    kl_copyYear();//自动版权年份
//    kl_timeByZone();//获得某时区当前时间
//    kl_mktime();//mktime() 函数返回日期的 Unix 时间戳
    kl_strtotime();//strtotime() 函数用于把人类可读的字符串转换为 Unix 时间。



//获得简单的日期
function kl_simpleDate(){

    echo "今天是 " . date("Y/m/d") . "<br>";//今天是 2016/09/27
    echo "今天是 " . date("Y.m.d") . "<br>";//今天是 2016.09.27
    echo "今天是 " . date("Y-m-d") . "<br>";//今天是 2016-09-27
    echo "今天是 " . date("l");//今天是 Tuesday
}


//自动版权年份
function kl_copyYear(){

    echo "版权所有:2008-".date("Y");//版权所有:2008-2016
}



//获得某时区当前时间
function kl_timeByZone(){

    date_default_timezone_set("Asia/Shanghai");
    echo "当前时间是 " . date("h:i:sa");//当前时间是 02:43:06pm
}


//mktime() 函数返回日期的 Unix 时间戳
function kl_mktime(){

    /*
     * mktime(hour,minute,second,month,day,year)
     * mktime() 函数返回日期的 Unix 时间戳。Unix 时间戳包含 Unix 纪元（1970 年 1 月 1 日 00:00:00 GMT）与指定时间之间的秒数
     * */
    $d = mktime(9, 12, 31, 6, 10, 2015);
    echo "创建日期是 " . date("Y-m-d h:i:sa", $d);//创建日期是 2015-06-10 09:12:31am
}

//strtotime() 函数用于把人类可读的字符串转换为 Unix 时间。
function kl_strtotime(){

    $d = strtotime("10:38pm April 15 2015");
    echo date("Y-m-d h:i:sa", $d). "<br>";//2015-04-15 10:38:00pm

    $d = strtotime("tomorrow");
    echo date("Y-m-d h:i:sa", $d) . "<br>";//2016-09-28 12:00:00am

    $d = strtotime("next Saturday");
    echo date("Y-m-d h:i:sa", $d) . "<br>";//2016-10-01 12:00:00am

    $d = strtotime("+3 Months");
    echo date("Y-m-d h:i:sa", $d) . "<br>";//2016-12-27 08:43:41am

    //输出下周六的日期
    $startdate = strtotime("Saturday");
    $enddate = strtotime("+6 weeks",$startdate);
    while ($startdate < $enddate) {
        echo date("M d", $startdate),"<br>";
        $startdate = strtotime("+1 week", $startdate);
    }//Oct 01   Oct 08   Oct 15  Oct 22  Oct 22  Nov 05


    //输出年底之前的天数
    $d1 = strtotime("December 31");
    $d2 = ceil(($d1-time())/60/60/24);
    echo "距离十二月三十一日还有：" . $d2 ." 天。";//距离十二月三十一日还有：95 天。
}