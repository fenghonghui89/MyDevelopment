<?php

/**
 *
 * JS - Root_XMLAndAJAX.html - 例子4:输出cd信息
 *
 */

/*
当请求从 JavaScript 发送到 PHP 页面时，发生：
PHP 创建 "cd_catalog.xml" 文件的 XML DOM 对象
循环所有 "artist" 元素 (nodetypes = 1)，查找与 JavaScript 所传数据向匹配的名字
找到 CD 包含的正确 artist
输出 album 的信息，并发送到 "txtHint" 占位符
*/

$q = $_GET["q"];

$xmlDoc = new DOMDocument();
$xmlDoc->load("XML_cdCatalog.xml");

$x = $xmlDoc->getElementsByTagName('ARTIST');

for ($i=0; $i<=$x->length-1; $i++)
{
    //Process only element nodes
    if ($x->item($i)->nodeType==1)
    {
        if ($x->item($i)->childNodes->item(0)->nodeValue == $q)
        {
            $y=($x->item($i)->parentNode);
        }
    }
}

$cd = ($y->childNodes);

for ($i=0;$i<$cd->length;$i++)
{
    //Process only element nodes
    if ($cd->item($i)->nodeType==1)
    {
        echo($cd->item($i)->nodeName);
        echo(": ");
        echo($cd->item($i)->childNodes->item(0)->nodeValue);
        echo("<br />");
    }
}