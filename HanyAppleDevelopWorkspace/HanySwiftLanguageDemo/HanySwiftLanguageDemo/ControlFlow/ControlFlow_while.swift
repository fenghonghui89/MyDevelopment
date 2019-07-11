//
//  ControlFlow_while.swift
//  HanySwiftLanguageDemo
//
//  Created by 冯鸿辉 on 16/7/4.
//  Copyright © 2016年 MD. All rights reserved.
// while / repeat while

import Foundation

func root_ControlFlow_while() {
    
}

//MARK: - <<< while循环 >>>

private func func2_1() {
    
    var i = 0;
    while i<3  {
        print("\(i)");
        i += 1;
    }
    
}

//MARK: - <<< repeat while循环（即do while） >>>
private func func3_1() {
    
    var i = 0;
    
    repeat{
        print("\(i)");
        i += 1;
    }while i<3;
    
}
