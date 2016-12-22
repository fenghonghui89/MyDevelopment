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




/*
* var声明会提升至他所有作用域的最顶处
* */
var aa = "you";

function testtt(){
    console.log(aa);//undefined
    var aa = "fuck";
    console.log(aa);//fuck
}

//相当于下面
var aa = "you";

function testtt(){
    var aa;
    console.log(aa);
    aa = "fuck";
    console.log(aa);
}

