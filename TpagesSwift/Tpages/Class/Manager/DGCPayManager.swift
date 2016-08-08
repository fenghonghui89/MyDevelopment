//
//  DGCPayManager.swift
//  Tpages
//
//  Created by 冯鸿辉 on 16/7/11.
//  Copyright © 2016年 DGC. All rights reserved.
//

import Foundation



protocol DGCPayManagerDelegate {
  func payManagerResult(url:NSURL)
}

class DGCPayManager: NSObject,WXApiDelegate {
  
  var dic:NSDictionary?
  var delegate:DGCPayManagerDelegate?
  
  static let sharedInstance:DGCPayManager = {
  
    let instance = DGCPayManager()
    return instance
  }()
  
  
  /**
   判断是否有安装微信客户端
   
   - returns: 判断是否有安装微信客户端
   */
  func isWXAppInstalled() -> Bool {
    
    if WXApi.isWXAppInstalled() {
      dlog("有安装微信")
    }else{
      dlog("没有安装微信")
    }
    
    return WXApi.isWXAppInstalled()
  }
  
  /**
   开启
   */
  func start() {
    
    WXApi.registerApp(UMENG_WECHAT_APPID)
    
    dlog("\n{\n" +
      "支付宝sdk当前版本号:\(AlipaySDK.defaultService().currentVersion())\n" +
    "微信sdk当前版本号:\(WXApi.getApiVersion())\n" +
    "}")
  }
  
  /**
   微信支付
   
   - parameter dic: 订单消息
   */
  func WXSendPay(dic:NSDictionary){
    
    self.dic = dic
    let req = PayReq()
    req.partnerId = dic.objectForKey("partnerid") as! String
    req.prepayId = dic.objectForKey("prepayid") as! String
    req.nonceStr = dic.objectForKey("noncestr") as! String
    let timeStamp:NSNumber = dic.objectForKey("timestamp") as! NSNumber
    req.timeStamp = timeStamp.unsignedIntValue
    req.package = "Sign=WXPay"
    req.sign = dic.objectForKey("sign") as! String
    WXApi.sendReq(req)
  }
  
  /**
   支付宝支付
   
   - parameter dic: 订单信息
   */
  func Alipay(dic:NSDictionary){
    
    self.dic = dic
    let order = Order()
    order.partner = dic.objectForKey("partner") as! String
    order.seller_id = dic.objectForKey("seller_id") as! String
    order.out_trade_no = dic.objectForKey("out_trade_no") as! String
    order.subject = dic.objectForKey("subject") as! String
    order.body = dic.objectForKey("body") as! String
    order.total_fee = dic.objectForKey("total_fee") as! String
    order.notify_url = dic.objectForKey("notify_url") as! String
    order.service = dic.objectForKey("service") as! String
    order.payment_type = dic.objectForKey("payment_type") as! String
    order._input_charset = dic.objectForKey("_input_charset") as! String
    order.sign = dic.objectForKey("sign") as! String
    order.sign_type = dic.objectForKey("sign_type") as! String
    
    //将商品信息拼接成字符串
    let orderSpec = order.description
    dlog("商品信息字符串：\(orderSpec)")
    
    AlipaySDK.defaultService().payOrder(orderSpec, fromScheme: ALIPAY_URL_SCHEME) {
      (resultDic:[NSObject:AnyObject]!) in
      dlog("支付宝result = \(resultDic)")
      let urlStr = self.dic?.objectForKey("returnurl") as! String
      let url = NSURL(string: urlStr)
      self.delegate?.payManagerResult(url!)
    }
  }
  
  

  
  //MARK:- callback
  func onResp(resp: BaseResp!) {
    
    if resp.isKindOfClass(PayResp) {
      switch resp.errCode {
      case WXSuccess.rawValue:
        dlog("微信支付成功 retcode:\(resp.errCode)")
        let urlStr = self.dic?.objectForKey("returnurl") as! String
        let url = NSURL(string: urlStr)
        self.delegate?.payManagerResult(url!)
      case WXErrCodeCommon.rawValue,
           WXErrCodeUserCancel.rawValue,
           WXErrCodeSentFail.rawValue,
           WXErrCodeAuthDeny.rawValue,
           WXErrCodeUnsupport.rawValue:
        dlog("微信支付错误 retcode:\(resp.errCode),retstr:\(resp.errStr)")
        let urlStr = self.dic?.objectForKey("returnurl") as! String
        let url = NSURL(string: urlStr)
        self.delegate?.payManagerResult(url!)
      default:
        dlog("微信支付错误 retcode:\(resp.errCode),retstr:\(resp.errStr)")
        let urlStr = self.dic?.objectForKey("returnurl") as! String
        let url = NSURL(string: urlStr)
        self.delegate?.payManagerResult(url!)
      }
    }
  }
  
  
  
  
  
  
  
  
  
}