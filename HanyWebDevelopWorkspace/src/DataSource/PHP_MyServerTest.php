<?php
/**
 * Created by PhpStorm.
 * User: hanyfeng
 * Date: 2017/1/16
 * Time: 12:45
 */

if ($_GET['fname'])
{
    $a = $_GET['fname'];
}
elseif ($_POST['fname'])
{
    $a = $_POST['fname'];
}
else
{
    $a = '';
}

if ($_GET['email'])
{
    $b = $_GET['email'];
}
elseif ($_POST['email'])
{
    $b = $_POST['email'];
}
else
{
    $b = '';
}

echo $a.$b;