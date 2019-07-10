//
//  ViewController_Swift.swift
//  MyDevelopmentSwift
//
//  Created by 冯鸿辉 on 16/6/15.
//  Copyright © 2016年 MD. All rights reserved.
//

import UIKit

class ViewController_Swift: UIViewController,UIScrollViewDelegate,UIWebViewDelegate{

  //MARK:- ********** parama *************
  var name:String = ""
  fileprivate var age:String = ""
  
  //MARK:- ********** override *************
  //MARK:- < lifecycle >
  //MARK:init
  convenience init(){
    self.init(name:"Peter",flag: true)!
  }
  
  init?(name:String,flag:Bool){
    if name.isEmpty{
      return nil;
    }
    self.name = name;
    super.init(nibName: nil, bundle: nil)
  }
  
  required init?(coder aDecoder: NSCoder) {
    self.name = "";
    super.init(coder: aDecoder);
  }
  
  //MARK:lifecycle
  override func viewDidLoad() {
    
    self.func_private()
  }
  
  override func viewDidAppear(_ animated: Bool) {
    
    super.viewDidAppear(animated)
  }
  
  override func viewDidDisappear(_ animated: Bool) {
    
    super.viewDidDisappear(animated)
  }
  
  //MARK:- ********** method *************
  func sayHello() {
    print("swift \(name) say hello")
  }
  
  open func func_public(){
    print("func_public");
  }
  
  internal func func_internal(){
    print("func_internal");
  }
  
  fileprivate func func_private(){
    print("func_private");
  }
  
  //MARK:- ********** callback *************
  //MARK:- < UIScrollViewDelegate >
  func scrollViewDidZoom(_ scrollView: UIScrollView) {
    
  }
  
  func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
    
  }
  //MARK:- < UIWebViewDelegate >
  func webViewDidStartLoad(_ webView: UIWebView) {
    
  }
  
    func webView(_ webView: UIWebView, shouldStartLoadWith request: URLRequest, navigationType: UIWebView.NavigationType) -> Bool {
    return true
  }
  
  func webViewDidFinishLoad(_ webView: UIWebView) {
    
  }
  
  func webView(_ webView: UIWebView, didFailLoadWithError error: Error) {
    
  }
  
}
