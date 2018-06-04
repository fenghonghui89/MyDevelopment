//
//  XTJAppKeyDefine
//  XTJMall
//
//  Created by hanyfeng on 2017/8/1.
//  Copyright © 2017年 hanyfeng. All rights reserved.
//

#ifndef XTJAppKeyDefine_h
#define XTJAppKeyDefine_h

#pragma mark - < 推送key >
#define XTJ_Push_refreshHomePage @"RefreshHomePage" //首页静默推送
#define XTJ_Push_beautyDetail @"beauty_detail" //美丽说文章详情页
#define XTJ_Push_flashSale @"flashSale" //抢购详情页
#define XTJ_Push_orderDetail @"order_detail" //订单详情

#pragma mark - < 通知key >
#define XTJ_KEY_NOTI_UserFollowGoods @"XTJ_KEY_NOTI_UserFollowGoods" //对商品进行关注操作，刷新会员中心
#define XTJ_KEY_NOTI_UserAddressesHasChanged @"XTJ_KEY_NOTI_UserAddressesHasChanged"//用户地址改变

#define XTJ_KEY_NOTI_RefreshCart @"XTJ_KEY_NOTI_RefreshCart"//商品详情页点击加入购物车 购物车生成订单成功 更新tab购物车页和下级购物车页
#define XTJ_KEY_NOTI_RefreshMainCart @"XTJ_KEY_NOTI_RefreshMainCart"//下级购物车页各种操作 只更新tab购物车页
#define XTJ_KEY_NOTI_RefreshReviewList @"XTJ_KEY_NOTI_RefreshReviewList"//下级购物车页各种操作 只更新tab购物车页

#define XTJ_KEY_NOTI_RefreshAllOrder @"XTJ_KEY_NOTI_RefreshAllOrder"//刷新"全部"订单页
#define XTJ_KEY_NOTI_RefreshPendingPayOrder @"XTJ_KEY_NOTI_RefreshPendingPayOrder"//刷新"待支付"订单页
#define XTJ_KEY_NOTI_RefreshPendingShippedOrder @"XTJ_KEY_NOTI_RefreshPendingShippedOrder"//刷新"待收货"订单页
#define XTJ_KEY_NOTI_RefreshPendingExtractOrder @"XTJ_KEY_NOTI_RefreshPendingExtractOrder"//刷新"待自提"订单页
#define XTJ_KEY_NOTI_RefreshFinishOrder @"XTJ_KEY_NOTI_RefreshFinishOrder"//刷新"完成"订单页

#define XTJ_KEY_NOTI_RefreshImagesCapture @"XTJ_KEY_NOTI_RefreshImagesCapture" //相册选择完图片后刷新选照片控件

#define XTJ_KEY_NOTI_RefreshAfterSalesList @"XTJ_KEY_NOTI_RefreshAfterSalesList"//申请售后成功后刷新相关售后列表
#define XTJ_KEY_NOTI_RefreshFeedbackList @"XTJ_KEY_NOTI_RefreshFeedbackList" //发表反馈后刷新反馈列表


#endif /* XTJAppKeyDefine_h */
