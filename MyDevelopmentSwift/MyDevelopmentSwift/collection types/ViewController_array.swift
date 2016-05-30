//
//  ViewController4.swift
//  MyDevelopmentSwift
//
//  Created by hanyfeng on 16/2/18.
//  Copyright © 2016年 MD. All rights reserved.
//已看


import UIKit

class ViewController_array: UIViewController {
  
  override func viewDidLoad() {
    super.viewDidLoad()
    



    func1_7_2();
    
    
    
    
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
    let arr6:NSArray = ["1",2];
    //    arr6[1] = 3;//不可变
    print(arr6)
    
    let arr7:NSMutableArray = ["1",2];
    arr7[1] = "3";//可变
    print(arr7[0]);
    //    NSLog("arr %@",arr7[0]);

  }
  
  //MARK:空数组 判断空数组
  func func1_3() {
    
    let nullarr1:Array<Float> = [];
    var nullarr2 = [Int]();
    var nullarr3:[String] = [];
    
    if nullarr1.isEmpty{
      print("is Empty");
    }
  }
  
  //MARK:固定长度数组及初始化
  func func1_4() {
    var fourInts = [Int](count: 4, repeatedValue: 1);
    var fourStrs = [String](count: 2, repeatedValue: "1");
    print(fourInts,fourStrs);
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
  
  //MARK:添加 插入 删除 同类型数组相加(相当于前后连接 数组类型必须相同)
  func func1_7() {
    
    var citys = ["北京","上海","杭州","深圳"];
    
    citys.append("广州");
    
    citys.insert("西安", atIndex: 2);
    
    citys.removeFirst();
    citys.removeLast();
    citys.removeAtIndex(1);
    citys.removeAll(keepCapacity: true);
    
    citys += ["西藏"];
    citys += ["黑龙江","青岛"];
    
    print(citys);
  }
  
  func func1_7_2() {
    var citys = ["北京","上海","杭州","深圳"];
    citys += ["西藏"];
    print(citys);

  }
  
  //MARK:枚举数组中的元素
  func func1_8() {
    let provices = ["辽宁","广州","福建"];
    for i in 0..<provices.count{
      print("\(i) : \(provices[i])");
    }
    
    for j in provices{
      print(j);
    }
    
    for (index,value) in provices.enumerate(){
      print("\(index): \(value)")
    }
  }
  
  //MARK:swift的array是结构体形式实现的，是值类型
  func func1_9()  {
    
    var a = [1, 2, 3];
    var b = a;
    var c = a;
    
    a.append(4);
    a[0] = 777;
    
    print(a[0]);
    print(b[0]);
    print(c[0]);

  }
  
  //MARK:比较数组内的元素是否相同 按区间比较
  func func1_10(){
    
    var a = [1,2,3];
    var b = [1,2,3,4];
    
    if a == b {
      print("same elemetns");
    }else{
      print("not same elements");
    }
    
    if a[0...1] == b[0...1] {
      print("0...1 same elemetns");
    }else{
      print("0...1 not same elements");
    }
    
  }
  
}
