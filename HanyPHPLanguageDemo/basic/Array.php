<?php
/**
 * Created by PhpStorm.
 * User: hanyfeng
 * Date: 16/7/29
 * Time: 11:12
 */
//数组

function root_Array(){

//    kl_indexArray();
//    kl_arrayCount();
//    kl_showArray();
//    kl_unionArray();
    kl_showUnionArray();
}

//索引数组
function kl_indexArray(){

    $cars=array("Volvo","BMW","SAAB");
    echo "I like " . $cars[0] . ", " . $cars[1] . " and " . $cars[2] . "."."<br>";

    $cars[0] = "aaaa";
    echo "I like " . $cars[0] . ", " . $cars[1] . " and " . $cars[2] . "."."<br>";
}

//获得数组长度
function kl_arrayCount(){

    $cars=array("Volvo","BMW","SAAB");
    echo count($cars);
}

//遍历索引数组 可以用for和foreach
function kl_showArray(){

    $cars=array("Volvo","BMW","SAAB");
    $arrlength=count($cars);

    for($x=0;$x<$arrlength;$x++) {
        echo $cars[$x],"<br>";
    }

    foreach ($cars as $car) {
        echo "name:".$car."<br>";
    }
}

//关联数组
function kl_unionArray(){

    $age=array("Bill"=>"35","Steve"=>"37","Peter"=>"43");
    echo "Peter is " . $age['Peter'] . " years old."."<br>";

    $age["Bill"] = "42";
    echo "Bill is ".$age["Bill"]." years old."."<br>";
}

//遍历关联数组 只能用foreach
function kl_showUnionArray(){

    $car = array("one"=>"BMW","two"=>"长安","three"=>"Audio");

    //会报错
    for($i = 0;$i<count($car);$i++){

        echo $car[$i],"<br>";
    }

    //可以
    foreach ($car as $item) {
        echo $item,"<br>";
    }
}