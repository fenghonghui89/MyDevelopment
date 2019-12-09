//
//  XTJBaseTypeDefine
//  XTJMall
//
//  Created by hanyfeng on 2017/8/1.
//  Copyright © 2017年 hanyfeng. All rights reserved.
//

#ifndef BJTypeDefine_h
#define BJTypeDefine_h


//客户端类型
typedef NS_ENUM(NSInteger,XTJClientType) {
    XTJClientTypeIOS,
    XTJClientTypeAndroid
};


////测试成功率类型
//typedef NS_ENUM(NSInteger,XTJTestType) {
//    XTJTestTypeAlwaysOK,
//    XTJTestTypeCanError
//};

//数据类型
typedef NS_ENUM(NSInteger,XTJDataType) {
    XTJDataTypeText,//文字
    XTJDataTypeImage,//图片
    XTJDataTypeMedia,//多媒体
    XTJDataTypeFile,//文件
    XTJDataTypeOther,//其他类型
};

//app更新状态
typedef NS_ENUM(NSInteger,XTJUpdateState) {
    XTJUpdateStateForce = 0,//强制
    XTJUpdateStateNotForce = 1,//非强制
    XTJUpdateStateNone = 2, //无更新
    XTJUpdateStateFaile = 3,//检测更新失败
};

//文件版本状态
typedef NS_ENUM(NSInteger,XTJFileVersionState) {
    XTJFileVersionStateHasNoFile,//未下载
    XTJFileVersionStateNewest,//已下载且是最新的
    XTJFileVersionStateNeedUpdate,//已下载需要更新
    XTJFileVersionStateHasNewestCache,//未下载完最新的
    XTJFileVersionStateHasOldCache//有旧缓存但需要重新下载
};


#endif /* BJTypeDefine_h */
