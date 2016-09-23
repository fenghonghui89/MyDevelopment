//
//  Base_Assertions.swift
//  HanySwiftLanguageDemo
//
//  Created by 冯鸿辉 on 16/7/4.
//  Copyright © 2016年 MD. All rights reserved.
//断言

import Foundation

func root_Base_Assertions() {
  kl_assert();
}

//MARK:断言
private func kl_assert(){
  
  let value = -3;
  assert(value >= 0)
  assert(value >= 0,"value要大于0");
}
