/**
 * Created by hanyfeng on 2016/12/29.
 */

/*
*
* 基本类型
* */
function ts_basicType(){

    //bool
    let isDone:boolean = true;

    //所有数字都是浮点数 支持十进制 十六进制 二进制 八进制
    let decLiteral: number = 6;
    let hexLiteral: number = 0xf00d;
    let binaryLiteral: number = 0b1010;
    let octalLiteral: number = 0o744;

    //字符串
    //let name: string = "bob";
    //name = "smith";

    //字符串模板 要用``包含
    let name: string = `Gene`;
    let age: number = 37;
    var sentence: string = `Hello, my name is ${ name }.I'll be ${ age + 1 } years old next month.`;
     sentence = "Hello, my name is " + name + ".\n\n" +"I'll be " + (age + 1) + " years old next month !";
    alert(sentence);
}

/*
*
* 数组
* */
function ts_basicType_array(){

    //普通
    let list: number[] = [1, 2, 3];

    //数组泛型
    let list1: Array<number> = [1, 2, 3];
}


/*
* 元组
* */
function ts_basicType_tuple(){

    let x:[string,number];

    x = ['hello',0]
    //x = [10,'hello']//error
    //alert(x);//hello,0

    x[3] = 'world'// OK, 字符串可以赋值给(string | number)类型
    alert(x);//hello,0,,world

    //x[6] = true; // Error, 布尔不是(string | number)类型
}


/*
* 枚举
* */
function ts_basicType_enum(){
    enum Color {
        Red=1,Green=2,Blue=3
    }

    let c:Color = Color.Blue;
    let name = Color[2];
    alert(name);//Green
}

/*
* any任意值
* 类型检查器不会检查,直接通过编译阶段
* */
function ts_basicType_any(){

    var ns:any = 4;
    ns = 'hahaha'
    ns = false;// okay, definitely a boolean


    //调用方法 any与object的区别
    let notSure: any = 4;
    notSure.ifItExists(); // okay, ifItExists might exist at runtime
    notSure.toFixed(); // okay, toFixed exists (but the compiler doesn't check)

    let prettySure: Object = 4;
    prettySure.toFixed(); // Error: Property 'toFixed' doesn't exist on type 'Object'.

    let list:any[]=[1,'sss',true];
    list[1] = 100;
}