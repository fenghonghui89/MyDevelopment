/**
 * Created by hanyfeng on 2016/12/29.
 */



/**
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


/**
*
* 数组
* */
function ts_basicType_array() {
    //普通
    var list = [1, 2, 3];
    //数组泛型
    var list1 = [1, 2, 3];
}


/**
* 元组
* */
function ts_basicType_tuple() {
    var x;
    x = ['hello', 0];
    //x = [10,'hello']//error
    alert(x); //hello,0
    x[3] = 'world'; // OK, 字符串可以赋值给(string | number)类型
    alert(x); //hello,0,,world
    //x[6] = true; // Error, 布尔不是(string | number)类型
}


/**
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


/**
 *
 * any任意值
 * 类型检查器不会检查,直接通过编译阶段
 *
 * */
function ts_basicType_any() {
    var ns = 4;
    ns = 'hahaha';
    ns = false; // okay, definitely a boolean
    //调用方法 any与object的区别:object只能被赋值,不能调用方法
    var notSure = 4;
    notSure.ifItExists(); // okay, ifItExists might exist at runtime
    notSure.toFixed(); // okay, toFixed exists (but the compiler doesn't check)
    var prettySure = 4;
    //prettySure.toFixed(); // Error: Property 'toFixed' doesn't exist on type 'Object'.
    //当你只知道一部分数据的类型时，any类型也是有用的。 比如，你有一个数组，它包含了不同的类型的数据
    var list = [1, 'sss', true];
    list[1] = 100;
}


/**
 *
 * 空值
 * */
function warnUser() {
    //声明一个void类型的变量没有什么大用，因为你只能为它赋予undefined和null：
    var unusable = null;
}
/**
 *
 *null undefine
 *
 * */
function nullfun() {
    /**
     * 默认情况下null和undefined是所有类型的子类型。 就是说你可以把 null和undefined赋值给number类型的变量
     * 鼓励尽可能地使用--strictNullChecks
     * */
    // 不能分配值给以下类型变量
    var u = undefined;
    var n = null = null;
}
/**
 *
 * never类型
 *
 * never类型表示的是那些永不存在的值的类型。
 * 例如， never类型是那些总是会抛出异常或根本就不会有返回值的函数表达式或箭头函数表达式的返回值类型；
 * 变量也可能是 never类型，当它们被永不为真的类型保护所约束时。
 *
 * never类型是任何类型的子类型，也可以赋值给任何类型；
 * 然而，没有类型是never的子类型或可以赋值给never类型（除了never本身之外）。
 * 即使 any也不可以赋值给never。
 *
 * */
// 返回never的函数必须存在无法达到的终点
function error(message) {
    throw new Error(message);
}
// 推断的返回值类型为never
function fail() {
    return error("Something failed");
}
// 返回never的函数必须存在无法达到的终点
function infiniteLoop() {
    while (true) {
    }
}


/**
 *
 * 类型断言
 * */
function typeCheck() {
    // //<> 形式
    var someValue = "this is a string";
    var strLength = someValue.length;
    // //as 形式
    var someValue1 = "this is a string";
    var strLength1 = someValue.length;
}
//# sourceMappingURL=TS_1_BasicType.js.map