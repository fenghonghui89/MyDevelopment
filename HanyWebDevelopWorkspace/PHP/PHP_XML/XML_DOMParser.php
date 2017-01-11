

<?php

/**
 *
 * XML DOM 解析器
 * 详情看网络开发笔记 - 知识经验-网络通信
 *
*/

//加载和输出 XML
$xmlDoc = new DOMDocument();
$xmlDoc->load('../../src/DataSource/XML_test.xml');

print $xmlDoc->saveXML();
print "<br/><br/>";


//循环 XML
$x = $xmlDoc->documentElement;
foreach ($x->childNodes AS $item)
{
    print $item->nodeName . " = " . $item->nodeValue . "<br />";
}

?>