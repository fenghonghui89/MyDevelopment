<?php
/**
 * Created by PhpStorm.
 * User: hanyfeng
 * Date: 2016/9/27
 * Time: 14:59
 */

/*
 * 3-4 文件
 * 3-5 文件打开/读取
 * 3-6 文件创建/写入
 * */





/*

fopen() 用于创建文件或者打开文件
在 PHP 中，创建文件所用的函数与打开文件的相同
fopen() 的第一个参数包含被打开的文件名，第二个参数规定打开文件的模式

r 	打开文件为只读。文件指针在文件的开头开始。
w 	打开文件为只写。删除文件的内容或创建一个新的文件，如果它不存在。文件指针在文件的开头开始。
a 	打开文件为只写。文件中的现有数据会被保留。文件指针在文件结尾开始。创建新的文件，如果文件不存在。
x 	创建新文件为只写。返回 FALSE 和错误，如果文件已存在。
r+ 	打开文件为读/写、文件指针在文件开头开始。
w+ 	打开文件为读/写。删除文件内容或创建新文件，如果它不存在。文件指针在文件开头开始。
a+ 	打开文件为读/写。文件中已有的数据会被保留。文件指针在文件结尾开始。创建新文件，如果它不存在。
x+ 	创建新文件为读/写。返回 FALSE 和错误，如果文件已存在。


fread() 函数读取打开的文件。
fread() 的第一个参数包含待读取文件的文件名，第二个参数规定待读取的最大字节数。

fclose() 函数用于关闭打开的文件。
注释：用完文件后把它们全部关闭是一个良好的编程习惯。您并不想打开的文件占用您的服务器资源。
fclose() 需要待关闭文件的名称（或者存有文件名的变量）：


调用 fgets() 函数之后，文件指针会移动到下一行。


feof() 函数检查是否已到达 "end-of-file" (EOF)。
feof() 对于遍历未知长度的数据很有用。


fgetc() 函数用于从文件中读取单个字符。

fwrite() 函数用于写入文件。
fwrite() 的第一个参数包含要写入的文件的文件名，第二个参数是被写的字符串。
*/




//kl_readfile();//readfile() 函数读取文件，并把它写入输出缓冲

//kl_readAllFile();//fopen()打开文件 fread() 函数读取打开的文件
//kl_readOneLineFile();//fgets() 函数用于从文件读取单行
//kl_endOfFile();//feof() 函数检查是否已到达 "end-of-file" (EOF)
//kl_getc();//fgetc() 函数用于从文件中读取单个字符

//kl_createFile();//fopen()创建文件,此文件将被创建于 PHP 代码所在的相同目录中
//kl_writeToFile();//fwrite() 函数用于写入文件
kl_overWrite();//覆盖数据



/************************** method ***************************/

//readfile() 函数读取文件，并把它写入输出缓冲
function kl_readfile(){

    $count = readfile("webdictionary.txt");
    echo readfile("webdictionary.txt")."\n"." count:".$count;
}



//fread() 函数读取打开的文件
function kl_readAllFile(){
    $myfile = fopen("webdictionary.txt", "r") or die("Unable to open file!");
    echo fread($myfile,filesize("webdictionary.txt"));//读至结尾
    fclose($myfile);
}


//fgets() 函数用于从文件读取单行
function kl_readOneLineFile(){

    $myfile = fopen("webdictionary.txt", "r") or die("Unable to open file!");
    echo fgets($myfile);
    fclose($myfile);
}



//feof() 函数检查是否已到达 "end-of-file" (EOF)
function kl_endOfFile(){

    $myfile = fopen("webdictionary.txt", "r") or die("Unable to open file!");

    // 输出单行直到 end-of-file
    while(!feof($myfile)) {
        echo fgets($myfile) . "\n";
    }
    fclose($myfile);
}

//fgetc() 函数用于从文件中读取单个字符
function kl_getc(){

    $myfile = fopen("webdictionary.txt", "r") or die("Unable to open file!");

    // 输出单字符直到 end-of-file
    while(!feof($myfile)) {
        echo fgetc($myfile);
    }
    fclose($myfile);
}


//fopen()创建文件,此文件将被创建于 PHP 代码所在的相同目录中
function kl_createFile(){
    $myfile = fopen("testfile.txt", "w") or die("创建文件失败");
}

//fwrite() 函数用于写入文件
function kl_writeToFile(){

    $myfile = fopen("newfile.txt", "w") or die("Unable to open file!");
    $txt = "Bill Gates\n";
    fwrite($myfile, $txt);
    $txt = "Steve Jobs\n";
    fwrite($myfile, $txt);
    fclose($myfile);
}

//覆盖数据
function kl_overWrite(){

    $myfile = fopen("newfile.txt", "w") or die("Unable to open file!");
    $txt = "Mickey Mouse\n";
    fwrite($myfile, $txt);
    $txt = "Minnie Mouse\n";
    fwrite($myfile, $txt);
    fclose($myfile);
}