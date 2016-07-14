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
  private var age:String = ""
  
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
  
  override func viewDidAppear(animated: Bool) {
    
    super.viewDidAppear(animated)
  }
  
  override func viewDidDisappear(animated: Bool) {
    
    super.viewDidDisappear(animated)
  }
  
  //MARK:- ********** method *************
  func sayHello() {
    print("swift \(name) say hello")
  }
  
  public func func_public(){
    print("func_public");
  }
  
  internal func func_internal(){
    print("func_internal");
  }
  
  private func func_private(){
    print("func_private");
  }
  
  //MARK:- ********** callback *************
  //MARK:- < UIScrollViewDelegate >
  func scrollViewDidZoom(scrollView: UIScrollView) {
    
  }
  
  func scrollViewWillBeginDragging(scrollView: UIScrollView) {
    
  }
  //MARK:- < UIWebViewDelegate >
  func webViewDidStartLoad(webView: UIWebView) {
    
  }
  
  func webView(webView: UIWebView, shouldStartLoadWithRequest request: NSURLRequest, navigationType: UIWebViewNavigationType) -> Bool {
    return true
  }
  
  func webViewDidFinishLoad(webView: UIWebView) {
    
  }
  
  func webView(webView: UIWebView, didFailLoadWithError error: NSError?) {
    
  }
  
}
