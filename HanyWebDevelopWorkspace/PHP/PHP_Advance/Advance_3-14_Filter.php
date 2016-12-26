
<!-- 3-14 filter -->

<?php


/*

 * 选项和标志
 * 选项和标志用于向指定的过滤器添加额外的过滤选项
 * 不同的过滤器有不同的选项和标志

有两种过滤器：
Validating 过滤器：

    用于验证用户输入
    严格的格式规则（比如 URL 或 E-Mail 验证）
    如果成功则返回预期的类型，如果失败则返回 FALSE

Sanitizing 过滤器：

    用于允许或禁止字符串中指定的字符
    无数据格式规则
    始终返回字符串

filter_input_array() 函数的第二个参数可以是数组或单一过滤器的 ID。
如果该参数是单一过滤器的 ID，那么这个指定的过滤器会过滤输入数组中所有的值。
如果该参数是一个数组，那么此数组必须遵循下面的规则：

    必须是一个关联数组，其中包含的输入变量是数组的键（比如 "age" 输入变量）
    此数组的值必须是过滤器的 ID ，或者是规定了过滤器、标志以及选项的数组


*/






//kl_filterVar();//filter_var 过滤变量
//kl_filterVarWithOptions();//filter_var 选项与标志
//kl_filter_input_validate();//filter_input filter_has_var 验证输入
//kl_filter_input_sanitize();//filter_input filter_has_var净化输入
//kl_filter_input_array();//filter_input_array 过滤多个输入
kl_filter_callback();//FILTER_CALLBACK 自定义过滤器


//验证是否是一个合法的整数
function kl_filterVar(){
    $int = 123;

    if(!filter_var($int, FILTER_VALIDATE_INT))
    {
        echo("Integer is not valid \n");
    }
    else
    {
        echo("Integer is valid \n");
    }
}


//用选项或标志 验证是否在范围内
function kl_filterVarWithOptions(){
    $var=300;

    $int_options = array(
        "options"=>array
        (
            "min_range"=>0,
            "max_range"=>256
        )
    );

    if(!filter_var($var, FILTER_VALIDATE_INT, $int_options))
    {
        echo("Integer is not valid \n");
    }
    else
    {
        echo("Integer is valid \n");
    }
}


//输入验证
function kl_filter_input_validate(){

    //检测是否存在 "GET" 类型的 "email" 输入变量
    if(!filter_has_var(INPUT_GET, "email"))
    {
        echo("Input type does not exist");
    }
    else
    {
        //如果存在输入变量，检测它是否是有效的邮件地址
        if (!filter_input(INPUT_GET, "email", FILTER_VALIDATE_EMAIL))
        {
            echo "E-Mail is not valid";
        }
        else
        {
            echo "E-Mail is valid";
        }
    }
}


//净化输入
function kl_filter_input_sanitize(){

    //检测是否存在 "POST" 类型的 "url" 输入变量
    if(!filter_has_var(INPUT_POST, "url"))
    {
        echo("Input type does not exist");
    }
    else
    {

        /*
         * 如果存在此输入变量，对其进行净化（删除非法字符），并将其存储在 $url 变量中
         * 假如输入变量类似这样："http://www.W3非o法ol.com.c字符n/"，则净化后的 $url 变量应该是这样的：
         * http://www.W3School.com.cn/
         * */
        $url = filter_input(INPUT_POST, "url", FILTER_SANITIZE_URL);
        echo $url;
    }
}


//filter_input_array 过滤多个输入
function kl_filter_input_array(){

    //设置一个数组，其中包含了输入变量的名称，以及用于指定的输入变量的过滤器
    $filters = array
    (
        "name" => array
        (
            "filter"=>FILTER_SANITIZE_STRING
        ),
        "age" => array
        (
            "filter"=>FILTER_VALIDATE_INT,
            "options"=>array
            (
                "min_range"=>1,
                "max_range"=>120
            )
        ),
        "email"=> FILTER_VALIDATE_EMAIL,
    );

    //调用 filter_input_array 函数，参数包括 GET 输入变量及刚才设置的数组
    $result = filter_input_array(INPUT_GET, $filters);

    //检测 $result 变量中的 "age" 和 "email" 变量是否有非法的输入
    if (!$result["age"])
    {
        echo("Age must be a number between 1 and 120.<br />");
    }
    elseif(!$result["email"])
    {
        echo("E-Mail is not valid.<br />");
    }
    else
    {
        echo("User input is valid");
    }
}


//FILTER_CALLBACK 自定义过滤器
function kl_filter_callback(){

    //创建一个把 "_" 替换为空格的函数
    function convertSpace($string)
    {
        return str_replace("_", " ", $string);
    }

    $string = "Peter_is_a_great_guy!";

    //调用 filter_var() 函数，它的参数是 FILTER_CALLBACK 过滤器以及包含我们的函数的数组
    echo filter_var($string, FILTER_CALLBACK, array("options"=>"convertSpace"));
}