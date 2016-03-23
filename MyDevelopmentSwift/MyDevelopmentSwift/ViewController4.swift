//
//  ViewController4.swift
//  MyDevelopmentSwift
//
//  Created by hanyfeng on 16/2/18.
//  Copyright © 2016年 MD. All rights reserved.
//

import UIKit

class ViewController4: UIViewController {
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
//    //TODO:--- 数组 ---
//    //TODO:创建 初始化 指定类型初始化
//    //创建和初始化
//    let arr1 = ["a","2"];
//    var arr2 = ["a","2"];
////    arr1 = ["a","2"];//常量数组不能改变
//    arr2 = ["b","2"];
//    print(arr1,arr2);
//
//    
//    //指定数组类型
////    var arr3:[String] = [1,2];//会自动根据元素类型 判断数组类型
//    var arr31:Array<String> = ["1","2"];
//    var arr3:[String] = ["1","2"];//简化
//    
//    var arr4:[Int];
////    print(arr4);//未初始化数组不能被引用，过不了编译
//    
//    
//    
//    //TODO:NSArray NSMutableArray类型数组
//    //元素类型为NSObject
//    var arr5 = [1,2,"a"];
//    arr5[0] = 3;
//    print(arr5);
//
//    
//    //NSObjcet NSArray NSMutableArray类型数组
//    var arr6:NSArray = ["1",2];
////    arr6[1] = 3;//不可变
//    print(arr6)
//    
//    var arr7:NSMutableArray = ["1",2];
//    arr7[1] = "3";//可变
//    print(arr7[0]);
////    NSLog("arr %@",arr7[0]);
//
//    
//    //TODO:空数组
//    var nullarr1 = [Int]();
//    var nullarr2:[String] = [];
//    var nullarr3:Array<Float> = [];
//    
//    
//    //TODO:固定长度数组
//    var fourInts = [Int](count: 4, repeatedValue: 1);
//    var fourStrs = [String](count: 2, repeatedValue: "1");
//    print(fourInts,fourStrs);
//    
//    
//    //TODO:数组相加 相当于前后连接 数组类型必须相同
//    var arrs1 = ["我",1];
//    var arrs2 = ["你",2];
//    print(arrs1+arrs2);
//    
//    
//    //TODO:数组区间赋值
//    var pros = [1,1,1];
//    pros[0...2] = [2,2,2];//222
//    pros[0...1] = [3,3,3];//3332 赋值元素个数超过区间 则在区间最后一个元素后追加多出来的赋值元素
//    pros[0..<4] = [4,4,4,4];//4444
//    pros[1...3] = [5,5,5,5];//45555 赋值元素个数超过区间 则在区间最后一个元素后追加多出来的赋值元素；min不是从0开始的，索引小于min的将不变
//    pros[1...4] = [6,6,6,6];//46666 min不是从0开始的，索引小于min的将不变
//    pros[0...4] = [6,6,6];//666 赋值元素个数小于区间 则删除区间"内"的多余原始元素 区间外不变
//    pros[0...1] = [7];//76 赋值元素个数小于区间 则删除区间"内"的多余原始元 区间外不变
//    print(pros);
//    
//    
//    //TODO:添加删除数组
//    var citys = ["beijing","shanghai"];
//    citys.append("guangzhou");
//    citys.insert("hangzhou", atIndex: 2);
//    citys.removeFirst();
//    citys.removeLast();
//    citys.removeAtIndex(1);
//    citys.removeAll(keepCapacity: true);
//    if citys.isEmpty{
//      print("is Empty");
//    }
//    citys += ["shuzhou"];
//    citys += ["xizang","qingdao"];
//    print(citys);
//    
//    
//    //TODO:枚举数组中的元素
//    let provices = ["liaoning","guangdong","fujian"];
//    for i in 0..<provices.count{
//      print("\(i) : \(provices[i])");
//    }
//    
//    for j in provices{
//      print(j);
//    }
//    
//    for (index,value) in EnumerateSequence(provices){
//    print("\(index): \(value)")
//    }
//    
//    //TODO:--- 字典 ---
//    //TODO:创建字典 空字典 清空字典（不能在初始化时使用[:]）
//    var dic1:Dictionary<String,String> = ["name":"Hany","city":"jiangmen"];
//    var dic2:[Int:String] = [12:"Hany",13:"jiangmen"];
//    var dic3 = ["name":"Hany","city":"jiangmen"];
//    dic3 = [:];//清空字典
//    print(dic2[12]);
//    print(dic3);
//    
//    //NSObject NSDictionary NSmutableDictionary 字典
//    var dic4 = ["name":"Hany","age":12];//[String:NSObject]类型
//    var dic44 = [12:"Hany","age":12];//[NSObject:NSObject]类型
//    var dic444:NSDictionary = dic4 as NSDictionary;//NSDictionary类型
//    var dic4444:NSDictionary = ["name":"Hany","age":12];//NSDictionary类型
//    var dic5:NSMutableDictionary = [12:"Hany","age":12];//NSMutableDictionary类型
//    print(dic5);
//
//    //空字典
//    var dicNil1 = Dictionary<Int,String>();
//    var dicNil2 = [Int:String]();
//    
//    var dicNil3 = Dictionary<Int,String>();
//    dicNil3[10] = "iphone6";
//    dicNil3 = [:];//再次清空字典
//    print(dicNil3);
//    
//    //TODO:增删改查字典中的数据
//    //增
//    var product = ["name":"iphone","company":"apple"];
//    var person = [Int:String]();
//    product["time"] = "2014-1-1";
//    person[10] = "Peter";
//    person[20] = "Ann";
//    
//    //返回修改之前的值，并修改
//    if let oldValue = person.updateValue("John", forKey: 10)
//    {
//      print("old value: \(oldValue)");
//    }
//    print(person);
//    
//    //删除
//    person[20] = nil;
//    print(person);
//    
//    //删除指定键值，并返回删除之前的值
//    let oldValue = person.removeValueForKey(10);
//    print(oldValue);
//    print(person.count);
//    
//    
//    //查
//    var persons = [10:"Bill",20:"Mike"];
//    print("\(persons[10])  \(persons[30])");
//    
//    
//    //TODO:将value转换为指定的类型值
//    var myDic1 = ["key1":"20","key2":"abc"];
//    var value1:Int? = Int(myDic1["key1"]!);
//    print(value1);
//    
//    var myDic2 = ["key1":"200","key2":30];
//    var value2:String = String(myDic2["key2"]);
//    print(value2);
//    
//    var myDic3 = ["key1":"200","key2":30];
//    var value3:Int = myDic3["key1"] as! Int;
//    print(value3);
//    
//    //TODO:枚举字典中的key和value
//    //Dictionary类型字典
//    var dic = [13:"冯鸿辉","age":12];
//    for (key,value) in dic{
//      print("\(key):\(value)");
//    }
//    
//    for key in dic.keys{
//      print(key);
//    }
//    
//    for value in dic.values{
//      print(value);
//    }
//    
//    //NSDictionary类型字典
//    var dic1:NSDictionary = NSDictionary(dictionary: dic);
//    for key in (dic1 as Dictionary).keys{
//      print(key);
//    }
    
    
    //TODO:将keys和values转换为数组
    var dic = ["name":"Hany","age":12];
    var keys = Array(dic.keys);
    var values = Array(dic.values);
    print("\(keys) \n \(values)");
    
    
    
  }
}
