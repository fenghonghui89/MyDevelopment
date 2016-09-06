/**
 * Created by hanyfeng on 16/9/5.
 */


/**************************************** js 变量 **************************************************/

//字符串
function var_string(){
    var carname1="Bill Gates";
    var carname2='Bill Gates';
    var answer1="Nice to meet you!";
    var answer2="He is called 'Bill'";
    var answer3='He is called "Bill"';
    alert(carname1+"\n"
        +carname2+"\n"
        +answer1+"\n"
        +answer2+"\n"
        +answer3+"\n");
}

//浮点数
function var_float(){
    var x1=36.00;
    var x2=36;
    var y=123e5;
    var z=123e-5;
    alert(x1+" "+x2+" "+y+" "+z);
}


//布尔值
function var_bool(){
    var x = true;
    var y = false;
    alert(x+" "+y+" ");
}


//数组
function var_array(){

    var cars = new Array();
    cars[0] = "Audi";
    cars[1] = "BMW";
    cars[2] = "Volvo";

    var i;
    var result = "";
    for (i=0;i<cars.length;i++)
    {
        result = result+cars[i]+" ";
    }
    alert(result);
}


//对象
function var_obj(){

    var person={
        firstname : "Bill",
        lastname  : "Gates",
        id        :  5566
    };

    alert(person.firstname+" "+person["lastname"]);
}


//Undefined 和 Null
function var_null(){

    var person1;
    var car="Volvo";
    alert(person1+" "+car+" ");

    var car=null
    alert(car);
}


//声明变量类型
/*
 JavaScript 变量均为对象。当您声明一个变量时，就创建了一个新的对象。
 */
function var_declare(){
    var carname=new String;
    var x=      new Number;
    var y=      new Boolean;
    var cars=   new Array;
    var person= new Object;
}


/*
 * 把值赋给未声明的变量,则该变量变成全局变量
 * */
function var_gloable(){
    abc = 'abc';
}



/**************************************** js 对象 **************************************************/
//js字符串对象
function obj_string(){
    var txt = "sample txt";
    txt.length = 5;
    txt.indexOf();
    txt.search();

    var txt1 = txt.toUpperCase();
    alert(txt1);
}

//创建js对象
function obj_newObj(){

    var person=new Object();
    person.firstname="Bill";
    person.lastname="Gates";
    person.age=56;
    person.eyecolor="blue";
    alert(person.firstname+" is "+person.age+" years old.")
}

//带参数函数
function obj_func(name,age){
    alert("param1:"+name+" "+"parame2:"+age);
}

//带返回值函数
function obj_return(){
    return 5;
}




/**************************************** js 运算符 **************************************************/
//比较运算符
/*
 * === 全等（值和类型）
 * */
function operator_compare(){
    var x = '5';
    if (x === 5){
        alert("yes, is 5");
    }else{
        alert("no, is '5'");
    }

}

//条件运算符
function operator_condition(){
    var x = 5;
    var result = x>=5?">=5":"<5";
    alert(result);
}


<!--JS 函数-->

    //标签 / for in 循环
    /*
     * 注意for in 循环写法
     * */
function func_label(){
    var cars = ['BYD','QQ',"BMW",'Jeep','Audio','现代','长安','路虎'];

    var result = "";
    list:{
        var x;
        for(x in cars){
            if (cars[x] == 'BMW') continue;
            if (cars[x] == '长安') break list;
            result = result+cars[x]+" ";
        }
    }

    alert(result);
}





/**************************************** js 异常捕获 **************************************************/

//try catch throw
function error_try(){
    try{
        var x = document.getElementById('error_try').value;
        if(x=="") throw "值为空"
        if(isNaN(x)) throw "值不是数字"
        if(x>5) throw "数值太大"
        if(x<5) throw "数值太小"
    }catch (err){
        alert("error happen...msg:"+err);
    }
}



/**************************************** js 表单验证 **************************************************/
function validate_require(field,alerttxt){
    with (field){

        //验证必填项目
        if (value==null||value=="") {alert(alerttxt);return false}


        /*
         * 输入的数据必须包含 @ 符号和点号(.)。同时，@ 不可以是邮件地址的首字符，并且 @ 之后需有至少一个点号
         * */
        apos=value.indexOf("@");
        dotpos=value.lastIndexOf(".");
        if (apos<1||dotpos-apos<2) {alert(alerttxt);return false}
        else {return true}

    }
}

function validate_form(thisform){
    with (thisform){
        if (validate_require(email,"Email不能为空!或者是无效的email") == false){
            email.focus();
            return false;
        }
    }
}


