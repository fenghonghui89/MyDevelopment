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

    
    
//    //TODO:常量及变量 定义 初始化 赋值 动态推导
////    var v;//不指定类型就要初始化，否则非法
//    var v:Int;//指定类型就可以不初始化
//    var v1 = 20; v1 = 30;
//    var v2:Int; v2 = 20;
//    var v3:Int = 20; v3 = 30;
//    
////    let l;//非法，同上
//    let l1 = 20; //l1 = 20;//常量不能改变值
//    let l2:Int; l2 = 20;
//    let l3:Int = 20;//l3 = 30;//常量不能改变值
//
//
//    
//    //TODO:数值可读性
//    let productid = 2_000_000;
//    let productName:String = "imac";
//    let available:Bool = true;
//    var 你好 = "你们";
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
//    var min = INT64_MAX;
//    var max = Int64.max
//    print("wo shi \(min) \n \(max)");
//    
//    
//    
//    
//    
//    //TODO:类型转换
//    var dv2:Double = Double(123);
//    var ii = Int(12.3);
//    
//    
//    var i:float_t = 1;
//    print("i = \(i)");
//
//    
//    //char
//    var c:Character = "a";
//    let cc:Character = "b";
//
//    
//    
//    
//    
//    //TODO:string
//    //定义
//    var s = "avc";
//    var s1:String = "avc";
//    var s2:String = String("avc");
//    
//    //空字符串
//    var s3 = "";
//    var s4 = String();
//    
//    //输出
//    var t1:Int = 1;
//    var t2:Float = 1.1;
//    var t3:Character = "c";
//    var t4:Bool = true;
//    let t5:String = "avc"
//    print(String("\(t1)  \(t2) \(t3) \(t4) \(t5)"));
//    print(t1,t2,t3,t4,t5);
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
////    st = st1+st3;//字符串不能和字符连接？
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
//    //TODO:元组类型
//    let product1 = (20,"iphone5",5000);
//    var (id,name,price) = product1;//赋值给三个变量
//    print("id:\(id)  name:\(name) price:\(price)");
//    
//    var (_,name1,_) = product1;//不想取全部值则用下划线
//    print("name1:\(name1)");
//    
//    let product2 = (30,name:"iphone8",price:5000);//为元组中的元素命令
//    print(product2.name+" "+"price:\(product2.price)");
//
//    var(x,y,z) = (1.1,"iphone",3);
//    print(x,y,z);
//    
//
//    //TODO:可选类型
//    //1
//    let numStr:String = "123a";
//    var value:Int? = Int(numStr);
//    
//    if value != nil{
//      print(value);//为nil不中断
//    }
//    
//    value = Int("123a");
//    print(value!);//加感叹号是为了值nil时抛出异常
//    
//    //2
//    let numstr1:String = "123a";
//    var value1:Int! = Int(numstr1);
//    print(value1);//输出nil 正常
//    
//    //3
//    var numstr2:String = "123";
//    var value2:Int? = Int(numstr2);
//    print(value2!+4);//如果用？定义，和其他值通过操作符进行运算时，要加！
  }

  
}

