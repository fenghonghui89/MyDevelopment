//
//  Order.h
//  AlixPayDemo
//
//  Created by 方彬 on 11/2/13.
//
//

#import <Foundation/Foundation.h>

@interface Order : NSObject







//可选
@property(nonatomic, copy) NSString * it_b_pay;
@property(nonatomic, copy) NSString * rsaDate;
@property(nonatomic, copy) NSString * appID;
@property(nonatomic, readonly) NSMutableDictionary * extraParams;
@property(nonatomic, copy) NSString * showUrl;



@property(nonatomic, copy) NSString *_input_charset;
@property(nonatomic,copy)NSString *body;//商品详情
@property(nonatomic,copy)NSString *notify_url;
@property(nonatomic,copy)NSString *out_trade_no;
@property(nonatomic, copy) NSString * partner;
@property(nonatomic, copy) NSString * payment_type;
@property(nonatomic, copy) NSString * seller_id;
@property(nonatomic, copy) NSString * service;
@property(nonatomic,copy)NSString *subject;//商品名称
@property(nonatomic, copy) NSString * total_fee;
@property(nonatomic,copy)NSString *sign;
@property(nonatomic,copy)NSString *sign_type;
@property(nonatomic,copy)NSString *status;
@property(nonatomic,copy)NSString *msg;
@property(nonatomic,copy)NSString *type;
@property(nonatomic,copy)NSString *returnurl;

@end
