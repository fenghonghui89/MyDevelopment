//
//  Order.m
//  AlixPayDemo
//
//  Created by 方彬 on 11/2/13.
//
//

#import "Order.h"

@implementation Order

- (NSString *)description
{
  NSMutableString * discription = [NSMutableString string];
  if (self.partner) {
    [discription appendFormat:@"partner=\"%@\"", self.partner];
  }
  if (self.seller_id) {
    [discription appendFormat:@"&seller_id=\"%@\"", self.seller_id];
  }
  if (self.out_trade_no) {
    [discription appendFormat:@"&out_trade_no=\"%@\"",self.out_trade_no];
  }
  if (self.subject) {
    [discription appendFormat:@"&subject=\"%@\"",self.subject];
  }
  if (self.body) {
    [discription appendFormat:@"&body=\"%@\"",self.body];
  }
  if (self.total_fee) {
    [discription appendFormat:@"&total_fee=\"%@\"", self.total_fee];
  }
  if (self.notify_url) {
    [discription appendFormat:@"&notify_url=\"%@\"",self.notify_url];
  }
  if (self.service) {
    [discription appendFormat:@"&service=\"%@\"",self.service];
  }
  if (self.payment_type) {
    [discription appendFormat:@"&payment_type=\"%@\"",self.payment_type];
  }
  if (self._input_charset) {
    [discription appendFormat:@"&_input_charset=\"%@\"",self._input_charset];
  }
  if (self.it_b_pay) {
    [discription appendFormat:@"&it_b_pay=\"%@\"",self.it_b_pay];//30m
  }
  if (self.showUrl) {
    [discription appendFormat:@"&show_url=\"%@\"",self.showUrl];//m.alipay.com
  }
  if (self.sign) {
    [discription appendFormat:@"&sign=\"%@\"",self.sign];
  }
  if (self.sign_type) {
    [discription appendFormat:@"&sign_type=\"%@\"",self.sign_type];
  }
  
  
  
  
  
  
  
  
  
  
  
  if (self.status) {
    [discription appendFormat:@"&status=\"%@\"",self.status];
  }
  if (self.msg) {
    [discription appendFormat:@"&msg=\"%@\"",self.msg];
  }
  if (self.type) {
    [discription appendFormat:@"&type=\"%@\"",self.type];
  }
  if (self.returnurl) {
    [discription appendFormat:@"&returnurl=\"%@\"",self.returnurl];
  }
  
  
  
  
  
  
  if (self.rsaDate) {
    [discription appendFormat:@"&sign_date=\"%@\"",self.rsaDate];
  }
  if (self.appID) {
    [discription appendFormat:@"&app_id=\"%@\"",self.appID];
  }
  for (NSString * key in [self.extraParams allKeys]) {
    [discription appendFormat:@"&%@=\"%@\"", key, [self.extraParams objectForKey:key]];
  }
  return discription;
}


@end
