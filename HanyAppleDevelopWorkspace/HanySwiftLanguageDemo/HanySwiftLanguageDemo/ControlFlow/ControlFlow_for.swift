//
//  ControlFlow_for.swift
//  HanySwiftLanguageDemo
//
//  Created by 冯鸿辉 on 16/7/4.
//  Copyright © 2016年 MD. All rights reserved.
// for
/*
 c风格的for在swift 3.0已经废弃
 */

import Foundation

func root_ControlFlow_for() {
    
}

//MARK: - <<< for循环 >>>
//MARK:对区间操作符进行循环
private func func1_1() {
    
    for index in 1...5
    {
        print("index:\(index)");
    }
    
    for index in 1..<10
    {
        print("index1:\(index)");
    }
    
    //如果不需要 index 可以用_忽略
    let base = 3;
    let power = 3;
    var answer = 1;
    for _ in 1...power
    {
        answer *= base;
    }
    print("\(answer)");
    
}

//MARK:枚举数组和字典中的元素
private func func1_2() {
    
    let arr = ["one","two",12] as [Any];
    for value in arr
    {
        print("\(value)");
    }
    
    
    let dic = ["k1":"v1",1:3] as [AnyHashable : Any];
    for (k,v) in dic
    {
        print("k:\(k),v:\(v)");
    }
    
}

//MARK:枚举字符串中的所有字符
private func func1_3() {
    
    for character in "Hello World"
    {
        print("<\(character)>");
    }
    
}

//MARK:forEach where
private func func1_4(){
    let array = [0, 1, 2, 3, 4, 5, 6];
    
    //使用switch遍历
    array.forEach {
        switch $0 {
        case let x where x > 3:   //where相当于判断条件
            print("后半段")
        default:
            print("默认值")
        }
    }

    
    for value in array where value > 2 {
        print(value)   //输出3 4 5 6
    }
    
    for (index, value) in array.enumerated() where index > 2 && value > 3 {
        print("下标:\(index), 值：\(value)")
    }
    
    
}
