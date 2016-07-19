//
//  DGCTpagesPageVC.swift
//  Tpages
//
//  Created by 冯鸿辉 on 16/7/8.
//  Copyright © 2016年 DGC. All rights reserved.
//

import Foundation

class DGCTpagesPageVC: DGCBaseViewController {
  
  //MARK:*********************** vc lifecycle ***********************
  override init(pageType: DGCPageType) {
    super.init(pageType: pageType)
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
  
  }
  
  //MARK:*********************** method ***********************
  
  override func checkUrlIsWhichPageType(request: NSURLRequest) -> DGCPageType {
    
    //log
    var requestStr:String?//http://dev.123go.net.cn/a/4003.html
    var host:String?//dev.123go.net.cn
    var relativePath:String?// /a/4003.html
    var query:String?
    var firstParam:String?
    var params:[String]?
    var scheme:String?//http
    
    if let url = request.URL {
      requestStr = url.absoluteString
      host = url.host
      relativePath = url.relativePath
      query = url.query
      scheme = url.scheme
      if query != nil {
        params = query?.componentsSeparatedByString("&")
        if params?.count>0{
          firstParam = params![0]
        }
      }
    }
    
    dlog("\n{\n" +
      "检测url：\n" +
      "requestStr:\(requestStr)\n" +
      "host:\(host)\n" +
      "relativePath:\(relativePath)\n" +
      "query:\(query)\n" +
      "firstParam:\(firstParam)\n" +
      "scheme:\(scheme)\n" +
      "}\n")
    
    //需要跳转到会员中心的链接
    if (
      query == "app=cart"//购物车
      || query  == "app=buyer_order&order_status=deal"//我的订单
      || query == "app=buyer_order&order_status=canceled"//取消订单
      || query == "mod=spacecp&ac=integral"//会员信息
      || query == "mod=space&do=favorite"//收藏
      || query == "mod=space&do=pm"//提醒
      || query == "mod=spacecp&ac=profile&op=password"//设置
      || relativePath == "/sign/up"//注册
      || query == "mod=logging&action=getpassword"//找回密码
      )
    {
      dlog("\(self.dynamicType)检查结果：url是会员中心的")
      return DGCPageType.DGCPageTypeUserCenter
    }
    
    //无需跳转 当前页显示的链接1
    if (
      requestStr == URL_TPAGES.stringByAppendingString("/plugin.php?id=portalogin:login")//点击登录按钮
      || relativePath == "/api/uc.php"//登录跳转
      || relativePath == "/api/uc"//登录跳转
      || relativePath == "/sign/out"//注销
      || firstParam  == "id=portalogin:login"//第三方登录请求
      )
    {
      dlog("\(self.dynamicType)检查结果：url是登录登出流程跳转")
      return DGCPageType.DGCPageTypeUnknow
    }
    
    //无需跳转 当前页显示的链接2
    if (
      query == "app=about"//关于我们
      || query == "mod=contact"//联系我们
      )
    {
      dlog("\(self.dynamicType)检查结果：url是未知的 或者是当前页的")
      return DGCPageType.DGCPageTypeUnknow
    }
    
    //跳转到tpages
    if host == HOST_TPAGES{
      dlog("\(self.dynamicType)检查结果：url是T视界的")
      return DGCPageType.DGCPageTypeTpages
    }
    
    //跳转到商城
    if host == HOST_MALL{
      dlog("\(self.dynamicType)检查结果：url是商城的")
      return DGCPageType.DGCPageTypeMall
    }
    
    //默认
    dlog("\(self.dynamicType)检查结果：url是未知的 或者是当前页的")
    return DGCPageType.DGCPageTypeUnknow
  }
  
  
  
  
}