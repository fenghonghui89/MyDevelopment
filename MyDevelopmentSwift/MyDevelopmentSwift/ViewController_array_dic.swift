//
//  ViewController4.swift
//  MyDevelopmentSwift
//
//  Created by hanyfeng on 16/2/18.
//  Copyright © 2016年 MD. All rights reserved.
//

import UIKit

class ViewController_array_dic: UIViewController {
  
  override func viewDidLoad() {
    super.viewDidLoad()
    



    func1_9();
    
    
    
    
  }
  
  
  //MARK: - <<< 数组 >>> -
  //MARK:创建 初始化 指定类型初始化
  func func1_1() {
    
    //创建和初始化
    let arr1 = ["a","2"];
    var arr2 = ["a","2"];
    //    arr1 = ["a","2"];//常量数组不能改变
    arr2 = ["b","2"];
    print(arr1,arr2);
    
    
    //指定数组类型初始化
    var arr31:Array<String> = ["1","2"];
    var arr3:[String] = ["1","2"];//简化
    var arr4 = [1,2];//会自动根据元素类型 判断数组类型
    
    var arr5:[Int];
    //    print(arr5);//未初始化数组不能被引用，过不了编译
    
  }
  
  //MARK:NSObject NSArray NSMutableArray类型数组
  func func1_2() {
    
    //元素类型为NSObject
    var arr5 = [1,2,"a"];
    arr5[0] = 3;
    print(arr5);
    
    //NSObjcet NSArray NSMutableArray类型数组
    var arr6:NSArray = ["1",2];
    //    arr6[1] = 3;//不可变
    print(arr6)
    
    var arr7:NSMutableArray = ["1",2];
    arr7[1] = "3";//可变
    print(arr7[0]);
    //    NSLog("arr %@",arr7[0]);

  }
  
  //MARK:空数组
  func func1_3() {
    var nullarr1:Array<Float> = [];
    var nullarr2 = [Int]();
    var nullarr3:[String] = [];
  }
  
  //MARK:固定长度数组及初始化
  func func1_4() {
    var fourInts = [Int](count: 4, repeatedValue: 1);
    var fourStrs = [String](count: 2, repeatedValue: "1");
    print(fourInts,fourStrs);
  }
  
  //MARK:数组相加 相当于前后连接 数组类型必须相同
  func func1_5() {
    var arrs1 = ["我",1];
    var arrs2 = ["你",2];
    print(arrs1+arrs2);
  }
  
  //MARK:数组区间赋值
  func func1_6() {
    var pros = [1,1,1];
    pros[0...2] = [2,2,2];//222
    pros[0...1] = [3,3,3];//3332 赋值元素个数超过指定区间 则在指定区间最后一个元素后追加多出来的赋值元素；指定区间之外的原始数据不会改变，会接在新数据之后
    pros[0..<4] = [4,4,4,4];//4444
    pros[1...3] = [5,5,5,5];//45555 赋值元素个数超过指定区间 则在指定区间最后一个元素后追加多出来的赋值元素；min不是从0开始的，索引小于min的将不变
    pros[1...4] = [6,6,6,6];//46666 min不是从0开始的，索引小于min的将不变
    pros[0...4] = [6,6,6];//666 赋值元素个数小于区间 则删除区间"内"的多余原始元素 区间外不变
    pros[0...1] = [7];//76 赋值元素个数小于区间 则删除区间"内"的多余原始元 区间外不变
    print(pros);

  }
  
  //MARK:添加删除数组
  func func1_7() {
    var citys = ["beijing","shanghai"];
    citys.append("guangzhou");
    citys.insert("hangzhou", atIndex: 2);
    citys.removeFirst();
    citys.removeLast();
    citys.removeAtIndex(1);
    citys.removeAll(keepCapacity: true);
    if citys.isEmpty{
      print("is Empty");
    }
    citys += ["shuzhou"];
    citys += ["xizang","qingdao"];
    print(citys);
  }
  
  //MARK:枚举数组中的元素
  func func1_8() {
    let provices = ["liaoning","guangdong","fujian"];
    for i in 0..<provices.count{
      print("\(i) : \(provices[i])");
    }
    
    for j in provices{
      print(j);
    }
    
    for (index,value) in EnumerateSequence(provices){
      print("\(index): \(value)")
    }
  }
  
  //MARK:swift的array是结构体形式实现的，是值类型
  func func1_9()  {
    
//    var arr = ["one","two","three"];
//    var arr1 = arr;
//    arr[0] = "1";
//    print(arr,arr1);
    
    var a = [1, 2, 3]
    var b = a
    var c = a
    
    a[0] = 42
    print(a[0])
    // 42
    print(b[0])
    // 42
    print(c[0])
    // 42
  }
  
  
  //MARK: - <<< 字典>>> -
  //MARK:创建字典 空字典 清空字典
  func func2_1() {
    
    //创建字典
    var dic1:Dictionary<String,String> = ["name":"Hany","city":"jiangmen"];
    var dic2:[Int:String] = [12:"Hany",13:"jiangmen"];
    var dic3 = ["name":"Hany","city":"jiangmen"];
    
    //清空字典（不能在初始化时使用[:]）
    dic3 = [:];
    print(dic2[12]);
    print(dic3);
    
    //NSObject NSDictionary NSmutableDictionary 字典
    var dic4 = ["name":"Hany","age":12];//[String:NSObject]类型
    var dic44 = [12:"Hany","age":12];//[NSObject:NSObject]类型
    var dic444:NSDictionary = dic4 as NSDictionary;//NSDictionary类型
    var dic4444:NSDictionary = ["name":"Hany","age":12];//NSDictionary类型
    var dic5:NSMutableDictionary = [12:"Hany","age":12];//NSMutableDictionary类型
    print(dic5);
    
    //空字典
    var dicNil1 = Dictionary<Int,String>();
    var dicNil2 = [Int:String]();
    
    var dicNil3 = Dictionary<Int,String>();
    dicNil3[10] = "iphone6";
    dicNil3 = [:];//再次清空字典
    print(dicNil3);
    
  }
  
  //MARK:增删改查字典中的数据
  func func2_2() {
    
    //增
    var product = ["name":"iphone","company":"apple"];
    var person = [Int:String]();
    product["time"] = "2014-1-1";
    person[10] = "Peter";
    person[20] = "Ann";
    
    //返回修改之前的值，并修改
    if let oldValue = person.updateValue("John", forKey: 10)
    {
      print("old value: \(oldValue)");
    }
    print(person);
    
    //删除
    person[20] = nil;
    print(person);
    
    //删除指定键值，并返回删除之前的值
    let oldValue = person.removeValueForKey(10);
    print(oldValue);
    print(person.count);
    
    
    //查
    var persons = [10:"Bill",20:"Mike"];
    print("\(persons[10])  \(persons[30])");
  }
  
  //MARK:将value转换为指定的类型值
  func func2_3() {
    
    var myDic1 = ["key1":"20","key2":"abc"];
    var value1:Int? = Int(myDic1["key1"]!);
    print(value1);
    
    var myDic2 = ["key1":"200","key2":30];
    var value2:String = String(myDic2["key2"]);
    print(value2);
    
    var myDic3 = ["key1":"200","key2":30];
    var value3:Int = myDic3["key1"] as! Int;
    print(value3);
  }
  
  //MARK:枚举字典中的key和value
  func func2_4() {
    //Dictionary类型字典
    var dic = [13:"冯鸿辉","age":12];
    for (key,value) in dic{
      print("\(key):\(value)");
    }
    
    for key in dic.keys{
      print(key);
    }
    
    for value in dic.values{
      print(value);
    }
    
    //NSDictionary类型字典
    var dic1:NSDictionary = NSDictionary(dictionary: dic);
    for key in (dic1 as Dictionary).keys{
      print(key);
    }

  }
  
  //MARK:将keys和values转换为数组
  func func2_5() {
    var dic = ["name":"Hany","age":12];
    var keys = Array(dic.keys);
    var values = Array(dic.values);
    print("\(keys) \n \(values)");
  }
  
  //MARK:swift的dictionary是结构体形式实现的，是值类型
  func func2_6() {
    
//    let dic = [1:"one",2:"two"];
//    var dic1 = dic;
//    dic1[1] = "11";
//    print(dic,dic1);
    
    let dic = ["1":"one","2":2];
    var dic1 = dic;
    dic1["1"] = "11";
    print(dic,dic1);
  }
}
