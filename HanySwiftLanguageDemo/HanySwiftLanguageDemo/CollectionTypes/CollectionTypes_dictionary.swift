//
//  CollectionTypes_dictionary.swift
//  HanySwiftLanguageDemo
//
//  Created by 冯鸿辉 on 16/7/4.
//  Copyright © 2016年 MD. All rights reserved.
//字典

import Foundation

func root_CollectionTypes_dictionary() {
  
}

//MARK: - <<< 字典>>> -
//MARK:创建字典 空字典 清空字典
private func func2_1() {
  
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
private func func2_2() {
  
  //增
  var product = ["name":"iphone","company":"apple"];
  product["time"] = "2014-1-1";
  print(product)
  
  var person = [Int:String]();
  person[10] = "Peter";
  person[20] = "Ann";
  print(person)
  
  
  //返回修改之前的值，并修改
  if let oldValue = person.updateValue("Peter2", forKey: 10)
  {
    print("old value: \(oldValue)");
  }
  print(person);
  
  //根据key修改
  person[20] = "Ann2"
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
  print("count:\(persons.count)")
}

//MARK:将value转换为指定的类型值
private func func2_3() {
  
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
private func func2_4() {
  //Dictionary类型字典
  let dic = [13:"冯鸿辉","age":12];
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
  let dic1:NSDictionary = NSDictionary(dictionary: dic);
  for key in (dic1 as Dictionary).keys{
    print(key);
  }
  
  
  //输出keys or values 数组
  let dic2 = ["key1":"value1","key2":"value2"];
  let keys = [String](dic2.keys);
  let values = [String](dic2.values);
  print(keys,values);
  
}

//MARK:将keys和values转换为数组
private func func2_5() {
  var dic = ["name":"Hany","age":12];
  var keys = Array(dic.keys);
  var values = Array(dic.values);
  print("\(keys) \n \(values)");
}

//MARK:swift的dictionary是结构体形式实现的，是值类型
private func func2_6() {
  
  //    let dic = [1:"one",2:"two"];
  //    var dic1 = dic;
  //    dic1[1] = "11";
  //    print(dic,dic1);
  
  let dic = ["1":"one","2":2];
  var dic1 = dic;
  dic1["1"] = "11";
  print(dic,dic1);
}
