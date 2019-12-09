//
//  BJKeyDefine
//  BJ3DProject
//
//  Created by hanyfeng on 2018/5/16.
//  Copyright © 2018年 hanyfeng. All rights reserved.
//

#ifndef BJKeyDefine_h
#define BJKeyDefine_h

//userdefault
#pragma mark - < userdefault key >
#define XTJ_KEY_IsOpenNotification @"XTJ_KEY_IsOpenNotification" //是否打开推送开关
#define XTJ_KEY_HasFirstLaunch @"XTJ_KEY_HasFirstLaunch" //已经完成第一次运行
#define XTJ_KEY_Count @"XTJ_KEY_Count" //次数
#define XTJ_KEY_Longitude @"XTJ_KEY_Longitude" //经度
#define XTJ_KEY_Latitude @"XTJ_KEY_Latitude" //纬度
#define XTJ_KEY_Locality @"XTJ_KEY_Locality" //城市
#define XTJ_KEY_DeviceToken @"XTJ_KEY_DeviceToken" //推送deviceToken
#define XTJ_KEY_IsLogined @"XTJ_KEY_IsLogined" //是否已经登录
#define XTJ_KEY_KeywordHistory @"XTJ_KeywordHistory" //关键字搜索历史

//推送
#pragma mark - < 推送key >
#define XTJ_Push_launchPushInfo @"XTJ_Push_launchPushInfo" //接收到的推送消息dic

//通知
#pragma mark - < 通知key >
#define XTJ_KEY_NOTI_UserLoginStateChange @"XTJ_KEY_NOTI_UserLoginStateChange"//用户登录状态发生改变
#define XTJ_KEY_NOTI_NetworkStatusChange @"XTJ_KEY_NOTI_NetworkStatusChange"//网络状态发生改变


//自定义额外数据
#pragma mark - < 自定义额外数据key >
#define XTJ_EXTEND_INFO_KEY @"EXTEND_INFO_KEY"
#define XTJ_NETWORK_ERROR_CODE_KEY @"XTJ_NETWORK_ERROR_CODE_KEY"
#define XTJ_TimeOutInterval_Key @"XTJ_TimeOutInterval_Key"//超时时间
#define XTJ_NoNeedCancleSameRequest_key @"XTJ_NoNeedCancleSameRequest_key"//无需cancle相同的请求


#endif /* BJKeyDefine_h */
