//
//  XTJAppNetworkCodeDefine
//  XTJMall
//
//  Created by hanyfeng on 2017/8/1.
//  Copyright © 2017年 hanyfeng. All rights reserved.
//

#ifndef XTJAppNetworkCodeDefine_h
#define XTJAppNetworkCodeDefine_h

//网络请求回调错误编码
typedef NS_ENUM(NSInteger,XTJNetwrokResponseCode){
    
    XTJNetwrokResponseCodeSuccess = 200,//请求成功
    XTJNetwrokResponseCodeDefaultError = 6666,//自定义 统一业务错误
    
    XTJNetwrokResponseCodeNoData = 415,//自定义 无数据
    XTJNetwrokResponseCodeNotJson = 417,//自定义 数据不是json格式
    
    XTJNetwrokResponseCodeSIGN_PARAM_NULL = 2222,//签名参数为空，未登录
    XTJNetwrokResponseCodeSIGN_EXPIRE = 2223,//签名已过期，即token过期
    XTJNetwrokResponseCodeQR_CODE_EXPIRE = 2220,//二维码过期
    XTJNetwrokResponseCodeSIGN_ERROR = 2221,//签名错误，请重新登录
    
    XTJNetwrokResponseCodeCART_FAIL = 3001,//购物车不能为空
    XTJNetwrokResponseCodeCART_ITEM_NOT_EXIST = 3002,//购物车不存在该商品
};

#pragma mark - < URL >

//卫结服务器 192.168.1.108:10003
//测试服务器 192.168.1.96
//正式服务器 app.3hmlg.com
#define XTJBaseURL_Dev @"http://192.168.1.96/"
#define XTJBaseURL_English @"http://app.3hmlg.com/"
#define XTJBaseURL_ChineseSimple @"http://app.3hmlg.com/"
#define XTJBaseURL_ChineseTraditional @"http://app.3hmlg.com/"


#endif /* XTJAppNetworkCodeDefine_h */
