<?php
/**
 * Created by PhpStorm.
 * User: hanyfeng
 * Date: 16/7/29
 * Time: 10:23
 */
//1-8 函数



//函数参数
//    familyName("Li","1975");//Li Zhang Born in 1975
//    familyName("Hong","1978");//Hong Zhang Born in 1978
//    familyName("Tao","1983");//Tao Zhang Born in 1983

//函数默认值
    setHeight(350);//The height is : 350
    setHeight(); //The height is : 50 默认值
    setHeight(135);//The height is : 135
    setHeight(80);//The height is : 80

//函数返回值
//    echo "5 + 10 = ",sum(5,10),"<br/>";//5 + 10 = 15
//    echo "7 + 13 = " . sum(7,13) . "<br/>";//7 + 13 = 20
//    echo "2 + 4 = " . sum(2,4) . "<br/>";//2 + 4 = 6





//函数参数
function familyName($fname,$year) {
    echo "$fname Zhang Born in $year ","<br/>";
}

//函数默认值
function setHeight($minheight = 50) {
    echo "The height is : $minheight <br>";
}

//函数返回值
function sum($x,$y) {
    $z = $x + $y;
    return $z;
}