//
//  XTJAppNetworkErrorCode.m
//  BJ3DProject
//
//  Created by hanyfeng on 2018/5/16.
//  Copyright © 2018年 hanyfeng. All rights reserved.
//

#import "XTJAppNetworkErrorCode.h"

@implementation XTJAppNetworkErrorCode
+(XTJNetwrokResponseCode)changeErrorCode:(NSString *)errorCode{
    
    XTJNetwrokResponseCode code = 0;
    if ([errorCode isEqualToString:@"SIGN_PARAM_NULL"]) {//签名参数为空，未登录。扫码登录判断用
        code = XTJNetwrokResponseCodeSIGN_PARAM_NULL;
    }else if([errorCode isEqualToString:@"QR_CODE_EXPIRE"]){//二维码过期。未处理
        code = XTJNetwrokResponseCodeQR_CODE_EXPIRE;
    }else if([errorCode isEqualToString:@"SIGN_EXPIRE"]){//签名已过期，即token过期。初始化时检测用，清空用户数据，让用户重新登录
        code = XTJNetwrokResponseCodeSIGN_EXPIRE;
    }else if ([errorCode isEqualToString:@"SIGN_ERROR"]){//签名错误，请重新登录。未处理
        code = XTJNetwrokResponseCodeSIGN_ERROR;
    }else if ([errorCode isEqualToString:@"CART_FAIL"]){//购物车不能为空。重新请求购物车
        code = XTJNetwrokResponseCodeCART_FAIL;
    }else if ([errorCode isEqualToString:@"CART_ITEM_NOT_EXIST"]){//购物车不存在该商品。重新请求购物车
        code = XTJNetwrokResponseCodeCART_ITEM_NOT_EXIST;
    }else{
        code = XTJNetwrokResponseCodeDefaultError;
    }
    return code;
}
@end
