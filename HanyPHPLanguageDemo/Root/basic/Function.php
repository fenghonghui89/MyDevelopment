<?php
/**
 * Created by PhpStorm.
 * User: hanyfeng
 * Date: 16/7/29
 * Time: 10:23
 */
//函数

function root_Function(){

//    familyName("Li","1975");
//    familyName("Hong","1978");
//    familyName("Tao","1983");

//    setHeight(350);
//    setHeight(); // 将使用默认值 50
//    setHeight(135);
//    setHeight(80);

    echo "5 + 10 = " . sum(5,10) . "<br>";
    echo "7 + 13 = " . sum(7,13) . "<br>";
    echo "2 + 4 = " . sum(2,4);
}

//函数参数
function familyName($fname,$year) {
    echo "$fname Zhang. Born in $year <br>";
}

//函数默认值
function setHeight($minheight=50) {
    echo "The height is : $minheight <br>";
}

//函数返回值
function sum($x,$y) {
    $z=$x+$y;
    return $z;
}