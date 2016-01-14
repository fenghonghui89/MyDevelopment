//
//  PPGameVersion.h
//  SDKDemoForFramework
//
//  Created by Seven on 13-12-5.
//  Copyright (c) 2013年 Server. All rights reserved.
//

#import <Foundation/Foundation.h>
//#import "PPGameUpdateManager.h"


//消息类型
typedef NS_ENUM(NSInteger, UpdateStatus){
    
    IH_E_UPDATE             =	0, //有新版本
    IH_E_NOT_UPDATE			=	1, //无新版本
    IH_E_INVALID_BUID 		= 	2, //bundleid不正确
    IH_E_APP_NOT_FOUND 		= 	3, //更新库不存在
    IH_E_APP_NOT_EXIST 		= 	4, //正版库不存在
    IH_E_INVALID_DATA		=	5  //无效的数据

};
@interface PPGameVersion : NSObject


@property (nonatomic, assign) UpdateStatus status; //消息类型
@property (nonatomic, assign) BOOL isUpdateForce; //是否强制更新
@property (nonatomic, assign) int appId;//Appid
@property (nonatomic, retain) NSString *version;//版本
@property (nonatomic, retain) NSString *downloadUrl;//更新版本下载地址
@property (nonatomic, retain) NSString *artWorkUrl;//图片地址
@property (nonatomic, retain) NSString *artWorkUrl108;//108图片 下载地址
@property (nonatomic ,retain) NSArray *historyVersionArray;//历史版本信息
@property (nonatomic ,retain) NSString *newestIpaDescription;//新版本的概述


@end
