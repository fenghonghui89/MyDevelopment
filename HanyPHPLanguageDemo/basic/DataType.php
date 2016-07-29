<?php
/**
 * Created by PhpStorm.
 * User: hanyfeng
 * Date: 16/7/28
 * Time: 16:00
 */
//数据类型

function root_DataType(){

//    kl_string();
    kl_int();
//    kl_float();
//    kl_logic();
//    kl_array();
//    kl_object();
//    kl_null();
}



//字符串
function kl_string(){

    //单引号双引号都可以
    $x = "Hello world!";
    echo $x;
    echo "<br>";

    $x = 'Hello world!';
    echo $x;
}

//整数
function kl_int(){

    $x = 5985;
    var_dump($x);//int(5985)
    echo "<br>";

    $x = -345; // 负数
    var_dump($x);//int(-345)
    echo "<br>";

    $x = 0x8C; // 十六进制数
    var_dump($x);//int(140)
    echo "<br>";

    $x = 047; // 八进制数
    var_dump($x);//int(39)





}

//浮点数
function kl_float(){

    $x = 10.365;
    var_dump($x);//float(10.365)
    echo "<br>";

    $x = 2.4e3;
    var_dump($x);//float(2400)
    echo "<br>";

    $x = 8E-5;
    var_dump($x);//float(8.0E-5)
}

//逻辑
function kl_logic(){

    $x = true;
    $y = false;
    var_dump($x);//bool(true)
    var_dump($y);//bool(false)
}

//数组
function kl_array(){

    $cars = array("Volvo","BMW","SAAB");
    var_dump($cars);//array(3) { [0]=> string(5) "Volvo" [1]=> string(3) "BMW" [2]=> string(4) "SAAB" }
    echo "<br>";

    $arr1 = array(1,2,3);
    var_dump($arr1);//array(3) { [0]=> int(1) [1]=> int(2) [2]=> int(3) }
}

//对象
function kl_object(){

    $car = new Car("red");

    echo $car->what_color();//red
}

class Car{

    var $color;

    function Car($color = "green"){

        $this->color = $color;
    }

    function what_color(){

        return $this->color;
    }
}

//null值
function kl_null(){

    $x = "Hello world!";
    $x = null;
    var_dump($x);//null
}