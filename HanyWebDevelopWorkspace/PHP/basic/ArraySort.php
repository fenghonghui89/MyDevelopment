<?php
/**
 * Created by PhpStorm.
 * User: hanyfeng
 * Date: 16/7/29
 * Time: 12:22
 */
//1-10 数组排序

function root_ArraySort(){

//    kl_sort();//升序
//    kl_rsort();//降序

//    kl_asort();//根据值对数组进行升序排序
//    kl_ksort();//根据键对数组进行升序排序

//    kl_arsort();//根据值对数组进行降序排序
    kl_krsort();//根据键对数组进行降序排序
}




//升序 - sort()
function kl_sort(){

    $cars=array("Volvo","BMW","SAAB");
    sort($cars);
    foreach ($cars as $car) {
        echo $car,"<br>";
    }
    //BMW SAAB Volvo


    $numbers=array(3,5,1,22,11);
    sort($numbers);
    foreach ($numbers as $number) {
        echo $number,"<br>";
    }
    //1 3 5 7 11 22
}




//降序 - rsort()
function kl_rsort(){

    $cars=array("Volvo","BMW","SAAB");
    rsort($cars);
    foreach ($cars as $car) {
        echo $car,"<br>";
    }
    //Volvo SAAB BMW


    $numbers=array(3,5,1,22,11);
    rsort($numbers);
    foreach ($numbers as $number) {
        echo $number,"<br>";
    }
    //22 11 7 5 3 1
}




//根据值对数组进行升序排序 - asort()
function kl_asort(){

    $numbers=array(3,5,1,22,11);
    asort($numbers);
    foreach ($numbers as $number) {
        echo "v:",$number,"<br>";
    }
    //1 3 5 7 11 22

    $age=array("Steve"=>"37","Bill"=>"35","Peter"=>"43");
    asort($age);
    foreach($age as $x=>$x_value) {
        echo "Key=" . $x . ", Value=" . $x_value."<br>";
    }
    //Key=Bill, Value=35
    //Key=Steve, Value=37
    //Key=Peter, Value=43

}



//根据键对数组进行升序排序 - ksort()
function kl_ksort(){

    $age=array("Bill"=>"35","Steve"=>"37","Peter"=>"43");
    ksort($age);
    foreach($age as $x=>$x_value) {
        echo "Key=" . $x . ", Value=" . $x_value."<br>";
    }
    //Key=Bill, Value=35
    //Key=Peter, Value=43
    //Key=Steve, Value=37
}



//根据值对数组进行降序排序 - arsort()
function kl_arsort(){

    $age=array("Bill"=>"35","Steve"=>"37","Peter"=>"43");
    arsort($age);
    foreach($age as $x=>$x_value) {
        echo "Key=" . $x . ", Value=" . $x_value."<br>";
    }
    //Key=Peter, Value=43
    //Key=Steve, Value=37
    //Key=Bill, Value=35
}


//根据键对数组进行降序排序 - krsort()
function kl_krsort(){

    $age=array("Bill"=>"35","Steve"=>"37","Peter"=>"43");
    krsort($age);
    foreach($age as $x=>$x_value) {
        echo "Key=" . $x . ", Value=" . $x_value."<br>";
    }
    //Key=Steve, Value=37
    //Key=Peter, Value=43
    //Key=Bill, Value=35
}