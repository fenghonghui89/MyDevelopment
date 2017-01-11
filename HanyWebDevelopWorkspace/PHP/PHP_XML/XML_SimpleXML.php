

<?php

/**
 *
 * SimpleXML 处理最普通的 XML 任务，其余的任务则交由其它扩展.
 * 详情看网络开发笔记 - 知识经验-网络通信
 *
*/

$xml = simplexml_load_file("../../src/DataSource/XML_test.xml");

echo $xml->getName() . "<br />";

foreach($xml->children() as $child)
{
    echo $child->getName() . ": " . $child . "<br />";
}
?>