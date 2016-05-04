//
//  ViewController.swift
//  MyDevelopmentSwift
//
//  Created by hanyfeng on 16/2/16.
//  Copyright © 2016年 MD. All rights reserved.
//


import UIKit

class ViewController_basic: UIViewController {
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    func4_3();
  }

  //MARK: - <<< 基础 >>> -
  //MARK:常量及变量 定义 初始化 赋值 动态推导
  func func1_1(){
    
    //    var v;//不指定类型就要初始化，否则非法
    var v:Int;//指定类型就可以不初始化
    var v1 = 20; v1 = 30;
    var v2:Int; v2 = 20;
    var v3:Int = 20; v3 = 30;
    
    //    let l;//非法，同上
    let l:Int;
    let l1 = 20; //l1 = 20;//常量不能改变值
    let l2:Int; l2 = 20;
    let l3:Int = 20;//l3 = 30;//常量不能改变值
  }
  
  //MARK:数值可读性 中文变量/常量名
  func func1_2() {
    
    let productid = 1_000_000.000_000_1;
    let 你好 = "你们";
    print("ID:\(productid) \n Name:\(你好)");
    
    let e1 = 1.21875e2
    let e2 = 1.21875e-2
    print(e1,e2)
  }
  
  //MARK:类型范围
  func func1_3(){
    let min = INT64_MAX;
    let max = Int64.max
    print("wo shi \(min) \n \(max)");
  }
  
  //MARK:类型转换
  func func1_4() {
    let dv2:Double = Double(123);
    let ii = Int(12.3);
    let i:float_t = 1;
    print("\(dv2)  \(ii) \(i)");
  }
  
  //MARK:断言
  func func1_5(){
    let value = -3;
    assert(value >= 0)
    assert(value >= 0,"value要大于0");
  }
  

  
  //MARK: - <<< string >>> -
  //MARK:定义 空字符串 打印输出
  func func2_1() {
    //T定义
    var s = "avc";
    var s1:String = "avc";
    var s2:String = String("avc");
    
    //空字符串
    var s3 = "";
    var s4 = String();
    
    //打印输出
    let t1:Int = 1;
    let t2:Float = 1.1;
    let t3:Character = "c";
    let t4:Bool = true;
    let t5:String = "abc"
    let t6:String = "def"
    print(String("\(t1)  \(t2) \(t3) \(t4) \(t5)"));
    print("\(t1)  \(t2) \(t3) \(t4) \(t5)");
    print(t1,t2,t3,t4,t5);
    print(t5+" "+t6);

  }
  
  //MARK:枚举字符串中的所有字符 unicode
  func func2_2() {
    
    let sa1 = "xjx你是我的最爱";
    for a in sa1.characters
    {
      print(a);
    }
    
    for b in sa1.unicodeScalars
    {
      print(b.value);
    }

  }
  
  //MARK:字符串和字符的连接
  func func2_3() {
    let st1 = "abc";
    let st2 = "def";
    let c1:Character = "g";
    let c2:Character = "h";
    var st = st1+st2;
    //    st = c1+c2;//字符不能和字符连接？
    //    st = st1+c1;//字符串不能和字符连接？
    st = "bbb";
    st = String(st1+st2);
  }
  
  //MARK:字符串之间的比较
  func func2_4() {
    var str1 = "abcd";
    var str2 = "abcd";
    
    if str1<=str2{
      print("<=");
    }

  }
  
  //MARK:字符串大小写转换
  func func2_5() {
    var str1:String = "abcd";
    var str2:String = "ABCD";
    
    print(str1.uppercaseString);
    print(str2.lowercaseString);
  }
  
  //MARK: - <<< 元组 >>> -
  //MARK:通过下标取元组的元素值
  func func3_1() {
    
    let pp = (11,111,1111);
    print(pp.2);
    
  }
  
  //MARK:通过赋值给其他常变量取元组的元素值/不想取全部值则用下划线
  func func3_2() {
    
    //通过赋值给其他常变量取元组的元素值
    let product1 = (20,"iphone5",5000);
    let (id,name,price) = product1;
    print("id:\(id)  name:\(name) price:\(price)");
    
    //不想取全部值则用下划线
    let (_,name1,_) = product1;
    print("name1:\(name1)");
  }
  
  
  
  //MARK:为元组中的元素命名
  func func3_3() {
    
    let product2 = (30,name:"iphone8",price:5000);
    print(product2.name+" "+"price:\(product2.price)");
    
    let (x,y,z) = (1.1,"iphone",3);
    print(x,y,z);
  }
  
  
  //MARK: - <<< 可选类型 >>> -
  //MARK:作用：处理值可能缺失的情况 当值为nil不中断
  /*
   C 和 OC 中并没有可选这个概念。最接近的是 Objective-C 中的一个特性，一个方法要不返回一个对象要不返回nil，nil表示“缺少一个合法的对象”。
   然而，这只对对象起作用——对于结构体，基本的 C 类型或者枚举类型不起作用。对于这些类型，OC 方法一般会返回一个特殊值（比如NSNotFound）来暗示值缺失。这种方法假设方法的调用者知道并记得对特殊值进行判断。
   然而，Swift 的可选可以让你暗示任意类型的值缺失，并不需要一个特殊值。
   */
  func func4_1() {
    
    let value:Int? = Int("123a");//Int()返回的是可选类型
    if value == nil{
      print("为nil");
    }

  }
  
  //MARK:可选值的强制解析
  /*
   当确定可选类型含有值时可用，表示"我知道这个可选有值，请使用它"
   如果确定有值但最终没有值则崩溃
   */
  func func4_2() {
    
    let value1:Int? = Int("123a");
    print(value1!);
    
    let value2:Int! = Int("123a");
    print(value2);
    
  }
  
  //MARK:可选绑定
  /*
   表示：如果返回的可选包含一个值，创建一个新常量并将可选包含的值赋给它。
   */
  func func4_3() {
    
    if let value = Int("123") {
      print("有值 \(value)");
    }else{
      print("无值 nil");
    }
  }
  
  //MARK:如果用？定义常量/变量，和其他值通过操作符进行运算时，要加！，否则编译不通过
  func func4_4() {
    let value3:Int? = Int("123");
    print(value3!+4);
  }
  
  
  //MARK:隐式解析可选
  /*
   表示：第一次被赋值之后，可以确定一个可选总会有值
   如果一个变量之后可能变成nil的话请不要使用隐式解析可选。
   如果你需要在变量的生命周期中判断是否是nil的话，请使用普通可选类型。
   注：隐式可选也是可选类型
   */
  func func4_5(){
    
    let possibleString: String? = "An optional string."
    print(possibleString!) // 需要惊叹号来获取值

    let assumedString: String! = "An implicitly unwrapped optional string."
    print(assumedString) // 不需要感叹号

  }
}

