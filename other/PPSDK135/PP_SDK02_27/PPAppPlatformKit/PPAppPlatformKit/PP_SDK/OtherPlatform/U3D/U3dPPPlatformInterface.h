//
//  U3dPPPlatformInterface.h
//  PPAppPlatformKit
//
//  Created by Server on 13-4-12.
//  Copyright (c) 2013年 张熙文. All rights reserved.
//


#ifndef _U3D_NDCOMPLATFORM_INTERFACE_H_
#define _U3D_NDCOMPLATFORM_INTERFACE_H_

/*****************************************************************************************
 本接口是PP充值平台SDK,针对Unity3D接入相关API，进行的封装。具体API的参数，用法等请参照
 SDK中的相关文档描述。Unity3D平台的API，去除U3d前缀后，同API命名一致。
 开发者需要按照这种格式
 进行解析。详见【sendU3dMessage】等相关消息事件源码
 
 *****************************************************************************************/

#if defined(__cplusplus)
extern "C" {
#endif
    
#pragma mark interface
    
    /**
     *必须写在程序window初始化之后。详情请commad + 鼠标左键 点击查看接口注释
     *初始化应用的AppId和AppKey。从开发者中心游戏列表获取（https://pay.25pp.com）
     *设置是否打印日志在控制台,[发布时请务必改为NO]
     *设置充值页面初始化金额,[必须为大于等于1的整数类型]
     *设置游戏客户端与游戏服务端链接方式是否为长连接【如果游戏服务端能主动与游戏客户端交互。例如发放道具则为长连接。此处设置影响充值并兑换的方式】
     *用户注销后是否自动push出登陆界面
     *是否开放充值页面【操作在按钮被弹窗】
     *若关闭充值响应的提示语
     *初始化SDK界面代码
     */
    void U3D_initSDK(int paramAppId,const char *paramAppKey,BOOL paramIsNSlogData,int paramRechargeAmount,
                     BOOL paramIsLongComet,BOOL paramIsLogOutPushLoginView,BOOL paramIsOpenRecharge,
                     const char *paramCloseRechargeAlertMessage,
                     BOOL paramIsDeviceOrientationLandscapeLeft,BOOL paramIsDeviceOrientationLandscapeRight,
                     BOOL paramIsDeviceOrientationPortrait,BOOL paramIsDeviceOrientationPortraitUpsideDown,
                     const char *paramSendMsgNotiClass);
    
    
    /**
     *展示登录界面
     */
    extern void U3D_showLoginView();
    
    /**
     * PP中心界面
     */
    extern void U3D_showCenterView();
    
    

    /**
     * 获取当前用户id
     */
    uint64_t U3D_currentUserId();

    /**
     * 添加回调
     */
    void U3D_addObserver;
    
    /**
     *兑换道具
     */
    void U3D_exchangeGoods(double paramPrice,const char *paramBillNo,const char *paramBillTitle,const char *paramRoleId,
                           int paramZoneId);
    
    /**
     *获取用户安全级别
     */
    void U3D_getUserInfoSecurity();
    
    /**
     *支付宝回调
     */
    void U3D_alixPayResult(const char *paramURL);
    
    /**
     *用户注销
     */
    
    void U3D_PPlogout();
    
#if defined(__cplusplus)
}
#endif


#endif

