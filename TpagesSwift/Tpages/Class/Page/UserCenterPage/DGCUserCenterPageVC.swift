//
//  DGCUserCenterPageVC.swift
//  Tpages
//
//  Created by 冯鸿辉 on 16/7/8.
//  Copyright © 2016年 DGC. All rights reserved.
//

import Foundation

class DGCUserCenterPageVC: DGCBaseViewController {
  
  //MARK:*********************** vc lifecycle ***********************
  override init(pageType: DGCPageType) {
    super.init(pageType: pageType)
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    self.view.backgroundColor = UIColor.yellowColor()
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
    var fragment:String?// http://dev.123go.net.cn/portal.php#destinationmo destinationmo
    
    if let url = request.URL {
      requestStr = url.absoluteString
      host = url.host
      relativePath = url.relativePath
      query = url.query
      scheme = url.scheme
      fragment = url.fragment
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
    
    
    //无需跳转 当前页显示的链接
    if (
      query == "app=about"//关于我们
        || query == "mod=contact"//联系我们
      )
    {
      dlog("\(self.dynamicType)检查结果：url是未知的 或者是当前页的")
      return DGCPageType.DGCPageTypeUnknow
    }
    
    //跳转到tpages
    if query == "action=hot"//t视界
      || query == "mod=news&c=2"//旅游专题
      || query == "mod=news&c=1"//新闻速递
      || fragment == "destinationmo"//推荐目的地
      || query == "mod=news&c=7"//达人游记
      || query == "mod=news&c=4"//文化游
    {
      dlog("\(self.dynamicType)检查结果：url是T视界的")
      return DGCPageType.DGCPageTypeTpages
    }
    
    //跳转到商城
    if (host == HOST_MALL && relativePath == "/")//商城
      || (host == HOST_MALL && firstParam == "app=store")//商品推荐 品牌旗舰
      || (host == HOST_MALL && firstParam == "app=search")//租借服务 新品热销 推广优惠{
    {
      dlog("\(self.dynamicType)检查结果：url是商城的")
      return DGCPageType.DGCPageTypeMall
    }
  
  
    //默认
    dlog("\(self.dynamicType)检查结果：url是未知的 或者是当前页的")
    return DGCPageType.DGCPageTypeUnknow
  }

}