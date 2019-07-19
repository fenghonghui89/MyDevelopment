//
//  BaseOperator_base.swift
//  HanySwiftLanguageDemo
//
//  Created by 冯鸿辉 on 16/7/4.
//  Copyright © 2016年 MD. All rights reserved.
//运算符
//恒等运算符：=== !== 见class

import Foundation

func root_BaseOperator_base() {
    
}

//MARK:数值运算
private func kl_baseOperator() {

    1 + 2       // equals 3
    5 - 3       // equals 2
    2 * 3       // equals 6
    10.0 / 2.5  // equals 4.0
    -9 % 4   // equals -1
    8.truncatingRemainder(dividingBy: 2.5)   //equals 0.5 截断除法 x == y * q + r 
    
    let three = 3
    let minusThree = -three       // minusThree equals -3
    let plusThree = -minusThree   // plusThree equals 3, or "minus minus three"
    
    let minusSix = -6
    let alsoMinusSix = +minusSix  // alsoMinusSix equals -6
    
    var i:float_t = 1.1;
    i += 1;
    print("i = \(i)");
}

//MARK:??运算符
private func kl_interrogation(){
    
    let dic = ["1":"v1","2":"v2","3":"v3","4":"v4"];
    
    let key = String(arc4random()%10);
    
    let value = dic[key] ?? "no value" //如果dic[key]有值则取dic[key]，否则取??后面的值
    
    print(value)
    
}

//MARK:元组间比较 三目运算符
private func kl_compareOperator(){
    
    //元组间比较 从左往右逐一比较 最多比较6个 6个以上的比较要自己实现
    (1, "zebra") < (2, "apple")   // true because 1 is less than 2
    (3, "apple") < (3, "bird")    // true because 3 is equal to 3, and "apple" is less than "bird"
    (4, "dog") == (4, "dog")      // true because 4 is equal to 4, and "dog" is equal to "dog"
    
    
    //三目运算符
    let contentHeight = 40
    let hasHeader = true
    let rowHeight = contentHeight + (hasHeader ? 50 : 20)// rowHeight is equal to 90
    
    
    let defaultColorName = "red"
    var userDefinedColorName: String? // defaults to nil
    var colorNameToUse = userDefinedColorName ?? defaultColorName //red
    userDefinedColorName = "green"
    colorNameToUse = userDefinedColorName ?? defaultColorName // green
    
}

//MARK:区间操作符 - 半开半闭
private func kl_RangeOperators() {
    let names = ["a","b","c","d"];
    for i in 0..<names.count{//包含0123 不包含4
        print("第\(i+1)个字母：\(names[i])");
    }
}

//MARK:区间操作符 - 全闭合
private func kl_HalfOpenRangeOperator() {
    for i in 1...5{
        print(i);
    }
}
