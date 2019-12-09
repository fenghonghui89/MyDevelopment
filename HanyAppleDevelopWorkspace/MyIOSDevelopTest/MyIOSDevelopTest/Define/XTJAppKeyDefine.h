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

#define XTJ_KEY_NOTI_refreshCategoryPage @"XTJ_KEY_NOTI_refreshCategoryPage" //获取商品分类信息后刷新分类列表

#define XTJ_KEY_NOTI_RefreshCart @"XTJ_KEY_NOTI_RefreshCart"//下级购物车页各种操作 商品详情页点击加入购物车 购物车生成订单成功 更新其他下级购物车页和当前下级购物车页
#define XTJ_KEY_NOTI_RefreshMainCart @"XTJ_KEY_NOTI_RefreshMainCart"//当前显示的下级购物车页 初始化请求更新tab购物车页

#define XTJ_KEY_NOTI_RefreshReviewList @"XTJ_KEY_NOTI_RefreshReviewList"//发表评价后刷新评价列表

#define XTJ_KEY_NOTI_RefreshMyOrderList @"XTJ_KEY_NOTI_RefreshMyOrderList"//刷新我的订单列表

#define XTJ_KEY_NOTI_RefreshAfterSalesList @"XTJ_KEY_NOTI_RefreshAfterSalesList"//申请售后成功后刷新相关售后列表
#define XTJ_KEY_NOTI_RefreshFeedbackList @"XTJ_KEY_NOTI_RefreshFeedbackList" //发表反馈后刷新反馈列表

#define BJ_NOTI_UserProfileHasChanged @"BJ_NOTI_UserProfileHasChanged"//改变了头像或个人信息
#define XTJ_KEY_NOTI_CSUnreadCount @"XTJ_KEY_NOTI_CSUnreadCount"//客服未读消息数更新 通知商品详情页

#endif /* XTJAppKeyDefine_h */
