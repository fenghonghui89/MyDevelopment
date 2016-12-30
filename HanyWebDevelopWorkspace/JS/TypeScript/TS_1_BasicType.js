/**
 * Created by hanyfeng on 2016/12/29.
 */
/*
*
* 基本类型
* */
function ts_basicType() {
    //bool
    var isDone = true;
    //所有数字都是浮点数 支持十进制 十六进制 二进制 八进制
    var decLiteral = 6;
    var hexLiteral = 0xf00d;
    var binaryLiteral = 10;
    var octalLiteral = 484;
    //字符串
    //let name: string = "bob";
    //name = "smith";
    //字符串模板 要用``包含
    var name = "Gene";
    var age = 37;
    var sentence = "Hello, my name is " + name + ".I'll be " + (age + 1) + " years old next month.";
    sentence = "Hello, my name is " + name + ".\n\n" + "I'll be " + (age + 1) + " years old next month !";
    alert(sentence);
}
/*
*
* 数组
* */
function ts_basicType_array() {
    //普通
    var list = [1, 2, 3];
    //数组泛型
    var list1 = [1, 2, 3];
}
/*
* 元组
* */
function ts_basicType_tuple() {
    var x;
    x = ['hello', 0];
    //x = [10,'hello']//error
    //alert(x);//hello,0
    x[3] = 'world'; // OK, 字符串可以赋值给(string | number)类型
    alert(x); //hello,0,,world
    //x[6] = true; // Error, 布尔不是(string | number)类型
}
/*
* 枚举
* */
function ts_basicType_enum() {
    var Color;
    (function (Color) {
        Color[Color["Red"] = 1] = "Red";
        Color[Color["Green"] = 2] = "Green";
        Color[Color["Blue"] = 3] = "Blue";
    })(Color || (Color = {}));
    var c = Color.Blue;
    var name = Color[2];
    alert(name); //Green
}
/*
* any任意值
* 类型检查器不会检查,直接通过编译阶段
* */
function ts_basicType_any() {
    var ns = 4;
    ns = 'hahaha';
    ns = false; // okay, definitely a boolean
    //调用方法 any与object的区别
    var notSure = 4;
    notSure.ifItExists(); // okay, ifItExists might exist at runtime
    notSure.toFixed(); // okay, toFixed exists (but the compiler doesn't check)
    var prettySure = 4;
    prettySure.toFixed(); // Error: Property 'toFixed' doesn't exist on type 'Object'.
    var list = [1, 'sss', true];
    list[1] = 100;
}
//# sourceMappingURL=TS_1_BasicType.js.map