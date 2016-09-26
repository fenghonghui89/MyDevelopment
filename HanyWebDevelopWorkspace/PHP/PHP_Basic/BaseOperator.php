<?php
/**
 * Created by PhpStorm.
 * User: hanyfeng
 * Date: 16/7/28
 * Time: 16:52
 */
//1-6 运算符





function root_BaseOperator(){

//    kl_calculateOperator();//算术运算符 +-*/%
//    kl_assignmentOperator();//赋值运算符= += -= *= /= %=
//    kl_stringOperator();//字符串运算符 . .=
//    kl_increaseIncrease();//递增递减-- ++
//    kl_compareOperator();//比较运算符 == === != !== <> < >
//    kl_logicOperator();//逻辑运算符 and && or || xor !
    kl_arrayOperator();//数组运算符 == === != !== <> < >
}






//算术运算符
function kl_calculateOperator(){

    $x = 10;
    $y = 6;
    echo ($x + $y),"<br>"; // 输出 16
    echo ($x - $y),"<br>"; // 输出 4
    echo ($x * $y),"<br>"; // 输出 60
    echo ($x / $y),"<br>"; // 输出 1.6666666666667
    echo ($x % $y),"<br>"; // 输出 4
}

//赋值运算符
function kl_assignmentOperator(){

    $x=10;
    echo $x,"<br>"; // 输出 10

    $y=20;
    $y += 100;
    echo $y,"<br>"; // 输出 120

    $z=50;
    $z -= 25;
    echo $z,"<br>"; // 输出 25

    $i=5;
    $i *= 6;
    echo $i,"<br>"; // 输出 30

    $j=10;
    $j /= 5;
    echo $j,"<br>"; // 输出 2

    $k=15;
    $k %= 4;
    echo $k,"<br>"; // 输出 3
}

//字符串运算符 .与.=
function kl_stringOperator(){

    $a = "Hello";
    $b = $a." world!";
    echo $b,"<br>"; // 输出 Hello world!

    $x="Hello";
    $x .= " world!";
    echo $x,"<br>"; // 输出 Hello world!
}

//递增 递减
function kl_increaseIncrease(){

    $x=10;
    echo ++$x,"<br>"; // 输出 11

    $y=10;
    echo $y++,"<br>"; // 输出 10

    $z=5;
    echo --$z,"<br>"; // 输出 4

    $i=5;
    echo $i--,"<br>"; // 输出 5
}

//比较运算符
function kl_compareOperator(){

    $x=100;
    $y="100";
    echo var_dump($x == $y),"<br>";//t
    echo var_dump($x === $y),"<br>";//f 值相等且类型相同才返回true
    echo var_dump($x != $y),"<br>";//f 不等于
    echo var_dump($x !== $y),"<br>";//t 值不相等且类型不同才返回true
    echo var_dump($x <> $y),"<br>";//t 不等于

    $a=50;
    $b=90;
    echo var_dump($a > $b),"<br>";//f
    echo var_dump($a < $b),"<br>";//t
}

//逻辑运算符 and && or || xor !
function kl_logicOperator(){

    $x = true;
    $y = false;

    echo var_dump($x and $y),"<br>";//false
    echo var_dump($x && $y),"<br>";//false

    echo var_dump($x or $y),"<br>";//true
    echo var_dump($x || $y),"<br>";//true

    echo var_dump($x xor $y),"<br>";//true 异或 如果 $x 和 $y 有且仅有一个为 true，则返回 true。

    echo var_dump(!$y),"<br>";//true
}

//数组运算符
function kl_arrayOperator(){

    $x = array("a" => "red", "b" => "green");
    $y = array("c" => "blue", "d" => "yellow");
    $z = $x + $y; // $x 与 $y 的联合 不覆盖重复的键

    echo var_dump($z),"<br>";//array(4) { ["a"]=> string(3) "red" ["b"]=> string(5) "green" ["c"]=> string(4) "blue" ["d"]=> string(6) "yellow" }
    echo var_dump($x == $y),"<br>";//f  拥有相同的键/值对，则返回 true
    echo var_dump($x === $y),"<br>";//f  拥有相同的键/值对，且顺序相同类型相同，则返回 true
    echo var_dump($x != $y),"<br>";//t 不等于
    echo var_dump($x <> $y),"<br>";//t 不等于
    echo var_dump($x !== $y),"<br>";//t 完全不同则返回t
}