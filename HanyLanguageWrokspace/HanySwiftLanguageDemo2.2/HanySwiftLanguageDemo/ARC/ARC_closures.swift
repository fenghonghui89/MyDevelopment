//
//  ARC_closures.swift
//  HanySwiftLanguageDemo
//
//  Created by 冯鸿辉 on 16/7/5.
//  Copyright © 2016年 MD. All rights reserved.
//

import Foundation

func root_ARC_closures() {
  
}

//MARK:- 解决闭包产生的强引用环 weak unowned
/*
 当闭包和占有的实例总是互相引用时并且总是同时销毁时，将闭包内的占有定义为无主引用。
 相反的，当占有引用有时可能会是nil时，将闭包内的占有定义为弱引用。弱引用总是可选类型，并且当引用的实例被销毁后，弱引用的值会自动置为nil。利用这个特性，我们可以在闭包内检查他们是否存在。
 */
private class arc_block_result{
  
  init(){
    var html:HTMLElement? = HTMLElement(name: "p", text: "hello");
    print(html!.asHTML());
    print("~~~")
    html = nil;
    print("!!!!")
    
    
    var html1:HTMLElement1? = HTMLElement1(name: "p",text: "hello");
    print(html1!.asHTML());
    print("~~~")
    html1 = nil;
    print("!!!!")
  }
}

private class HTMLElement{
  
  let name:String
  let text:String?
  
  lazy var asHTML:()->String = {
    [unowned self] in //代表“用无主引用而不是强引用来占有self”
    if let text = self.text {
      return "<\(self.name)>\(text)</\(self.name)>"
    } else {
      return "<\(self.name)/>"
    }
  }
  
  init(name:String,text:String?){
    self.name = name;
    self.text = text;
    
  }
  
  deinit{
    print("HTMLElement deinit");
  }
  
}

private class HTMLElement1{
  
  let name:String
  let text:String?
  
  lazy var asHTML:()->String = {
    [weak self] in //用weak
    if let text = self?.text {
      return "<\(self?.name)>\(text)</\(self?.name)>"
    } else {
      return "<\(self?.name)/>"
    }
  }
  
  init(name:String,text:String?){
    self.name = name;
    self.text = text;
    
  }
  
  deinit{
    print("HTMLElement deinit");
  }
  
}
