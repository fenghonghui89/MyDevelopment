<?php
/**
 * Created by PhpStorm.
 * User: hanyfeng
 * Date: 16/7/28
 * Time: 18:07
 */
//1-7 if else / switch / while do while for




function root_ControlFlow(){

    kl_foreach();//foreach
}




//foreach
function kl_foreach(){

    /*
     * foreach 循环只适用于数组，并用于遍历数组中的每个键/值对。
     * 每进行一次循环迭代，当前数组元素的值就会被赋值给 $value 变量，并且数组指针会逐一地移动，直到到达最后一个数组元素。
     * */
    $colors = array("red","green","blue","yellow");

    foreach ($colors as $value) {
        echo "$value","<br/>";//red green blue yellow
    }

}