<?php
/**
 * Created by PhpStorm.
 * User: hanyfeng
 * Date: 16/7/29
 * Time: 11:12
 */
//1-9 数组




function root_Array(){

//    kl_indexArray();//索引数组
//    kl_arrayCount();//获得数组长度
//    kl_showArray();//遍历索引数组 可以用for和foreach
//    kl_unionArray();//关联数组
    kl_showUnionArray();//遍历关联数组 只能用foreach
}





//索引数组
function kl_indexArray(){

    $cars = array("Volvo","BMW","SAAB");
    echo "I like " . $cars[0] . ", " . $cars[1] . " and " . $cars[2] . "."."<br>";//I like Volvo, BMW and SAAB.

    $cars[0] = "aaaa";
    echo "I like " . $cars[0] . ", " . $cars[1] . " and " . $cars[2] . "."."<br>";//I like aaaa, BMW and SAAB.
}




//获得数组长度
function kl_arrayCount(){

    $cars = array("Volvo","BMW","SAAB");
    echo count($cars);//3
}




//遍历索引数组 可以用for和foreach
function kl_showArray(){

    $cars = array("Volvo","BMW","SAAB");
    $arrlength = count($cars);

    for($x = 0;$x < $arrlength;$x++) {
        echo $cars[$x],"<br/>";
    }//Volvo BMW SAAB

    foreach ($cars as $car) {
        echo "name:".$car."<br/>";
    }//name:Volvo name:BMW name:SAAB
}




//关联数组 类似字典
function kl_unionArray(){

    $age = array("Bill"=>"35","Steve"=>"37","Peter"=>"43");
    echo "Peter is " . $age['Peter'] . " years old."."<br>";//Peter is 43 years old.

    $age["Bill"] = "42";
    echo "Bill is ".$age["Bill"]." years old."."<br>";//Bill is 42 years old.
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
    }//BMW 长安 Audio
}