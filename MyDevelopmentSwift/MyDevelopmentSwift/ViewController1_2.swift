//
//  ViewController.swift
//  MyDevelopmentSwift
//
//  Created by hanyfeng on 16/2/16.
//  Copyright © 2016年 MD. All rights reserved.
//


import UIKit

class ViewController1_2: UIViewController {
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.

    
    //TODO:--- 基本 ---
//    //TODO:常量及变量 定义 初始化 赋值 动态推导
////    var v;//不指定类型就要初始化，否则非法
//    var v:Int;//指定类型就可以不初始化
//    var v1 = 20; v1 = 30;
//    var v2:Int; v2 = 20;
//    var v3:Int = 20; v3 = 30;
//    
////    let l;//非法，同上
//    let l:Int;
//    let l1 = 20; //l1 = 20;//常量不能改变值
//    let l2:Int; l2 = 20;
//    let l3:Int = 20;//l3 = 30;//常量不能改变值
//
//
//    
//    //TODO:数值可读性 中文变量/常量名
//    let productid = 2_000_000;
//    let 你好 = "你们";
//    
//    print("ID:\(productid) \n Name:\(你好)");
//
//    
//    
//    
//
//    
//    
//
//    
//    //TODO:类型范围
//    let min = INT64_MAX;
//    let max = Int64.max
//    print("wo shi \(min) \n \(max)");
//
//    
//    
//    
//    
//    //TODO:类型转换
//    let dv2:Double = Double(123);
//    let ii = Int(12.3);
//    let i:float_t = 1;
//    print("\(dv2)  \(ii) \(i)");

    
    
//
//    
//    
//    
//    //TODO: --- string ---
//    //TODO:定义
//    var s = "avc";
//    var s1:String = "avc";
//    var s2:String = String("avc");
//    
//    //TODO:空字符串
//    var s3 = "";
//    var s4 = String();
//    
//    //TODO:打印输出
//    let t1:Int = 1;
//    let t2:Float = 1.1;
//    let t3:Character = "c";
//    let t4:Bool = true;
//    let t5:String = "abc"
//    let t6:String = "def"
//    print(String("\(t1)  \(t2) \(t3) \(t4) \(t5)"));
//    print("\(t1)  \(t2) \(t3) \(t4) \(t5)");
//    print(t1,t2,t3,t4,t5);
//    print(t5+" "+t6);
//
//    
//
//    
//    //TODO:枚举字符串中的所有字符 unicode
//    let sa1 = "xjx你是我的最爱";
//    for a in sa1.characters
//    {
//      print(a);
//    }
//
//    for b in sa1.unicodeScalars
//    {
//      print(b.value);
//    }
//
//    
//    
//
//    
//    
//    //TODO:字符串和字符的连接
//    let st1 = "abc";
//    let st2 = "def";
//    let c1:Character = "g";
//    let c2:Character = "h";
//    var st = st1+st2;
////    st = c1+c2;//字符不能和字符连接？
////    st = st1+c1;//字符串不能和字符连接？
//    st = "bbb";
//    st = String(st1+st2);
//
//
//    
//    
//
//    //TODO:字符串之间的比较
//    var str1 = "abcd";
//    var str2 = "abcd";
//    
//    if str1<=str2{
//      print("<=");
//    }
//    
//    
//    //TODO:字符串大小写转换
//    var str1:String = "abcd";
//    var str2:String = "ABCD";
//    
//    print(str1.uppercaseString);
//    print(str2.lowercaseString);
//    
//    
//    
//    
//    
//    
//    
//    //TODO:--- 元组类型 ---
//    
//    //TODO:通过下标取元组的元素值
//    let pp = (11,111,1111);
//    print(pp.2);
//    
//    //TODO:通过赋值给其他常量/变量取元组的元素值
//    let product1 = (20,"iphone5",5000);
//    let (id,name,price) = product1;
//    print("id:\(id)  name:\(name) price:\(price)");
//    
//    //TODO:不想取全部值则用下划线
//    let (_,name1,_) = product1;
//    print("name1:\(name1)");
//    
//    //TODO:为元组中的元素命名
//    let product2 = (30,name:"iphone8",price:5000);
//    print(product2.name+" "+"price:\(product2.price)");
//
//    let (x,y,z) = (1.1,"iphone",3);
//    print(x,y,z);
//
//
//    //TODO:--- 可选类型 ---
//    //TODO:作用：当值为nil不中断
//    let value:Int? = Int("123a");
//    if value == nil{
//      print("为nil");
//    }
//    
//    //TODO:加感叹号是为了值nil时抛出异常
//    let value1:Int? = Int("123a");
//    print(value1!);
//    
//    let value2:Int! = Int("123a");
//    print(value2);
//    
//    //TODO:如果用？定义常量/变量，和其他值通过操作符进行运算时，要加！，否则编译不通过
//    let value3:Int? = Int("123");
//    print(value3!+4);
    
    
    
    
  }
}

