//
//  XTJAppBusinessDefine
//  XTJMall
//
//  Created by hanyfeng on 2017/6/22.
//  Copyright © 2017年 hanyfeng. All rights reserved.
//

#ifndef XTJAppBusinessDefine_h
#define XTJAppBusinessDefine_h

//商品详情页
typedef NS_ENUM(NSInteger,XTJSpecSelectPageType) {
    XTJSpecSelectPageTypeJustConfirm,//购物车修改规格 只有确定
    XTJSpecSelectPageTypeJustConfirmCanEditCount,//商品详情页点击底部加入购物车或立即购买 只有确定
    XTJSpecSelectPageTypeTwoBtnCanEditCount,//商品详情页点击修改尺码 有加入购物车和立即购买
    
    XTJSpecSelectPageTypeBuyNow,
    XTJSpecSelectPageTypeAddToCart,
    XTJSpecSelectPageTypeTwoType
    
};

//售后类型
typedef NS_ENUM(NSInteger,XTJReturnGoodsType) {
    XTJReturnGoodsTypeReturnGoods,//退货
    XTJReturnGoodsTypeChangeGoods//换货
};

//意见反馈类型
typedef NS_ENUM(NSInteger,XTJFeedbackType) {
    XTJFeedbackTypeQuestion = 0,//问题
    XTJFeedbackTypeSuggest = 1,//建议
};

//订单状态
typedef NS_ENUM(NSInteger,XTJOrderStatusType) {
    XTJOrderStatusTypeAll,//全部
    XTJOrderStatusTypePendingPayment,//待支付(要判断是否过期)
    
    XTJOrderStatusTypePendingShipment,//待发货
    XTJOrderStatusTypeShipped,//已发货运输中
    XTJOrderStatusTypeShipment,//待收货=待发货+已发货运输中(只能用来传参不会返回该参数）
    
    XTJOrderStatusTypePendingExtract,//待自提
    XTJOrderStatusTypeExtracted,//已提货
    XTJOrderStatusTypeExtract,//待自提=未提取+已提货（只能用来传参不会返回该参数）
    
    XTJOrderStatusTypeCompleted,//完成=商家配送已收货+自提已提货
    XTJOrderStatusTypeFaild,//失败
    XTJOrderStatusTypeCancled,//取消
    XTJOrderStatusTypeDenied,//拒绝
};

//退换货状态
typedef NS_ENUM(NSInteger,XTJReturnStatusType) {
    XTJReturnStatusTypeReply = 0,//用户已申请售后
    XTJReturnStatusTypeAccept = 1,//客服已经受理
    XTJReturnStatusTypeConfirm = 2,//客服确定售后
    XTJReturnStatusTypeWait = 3,//客服等待收件
    XTJReturnStatusTypeReceive = 4,//客服确认收件
    XTJReturnStatusTypeRefund = 5,//客服确认退款
    XTJReturnStatusTypeResend = 6,//客服重新发货
    XTJReturnStatusTypeFinish = 7//系统退款成功 或 用户已确定收到换货
};

//配送方式
typedef NS_ENUM(NSInteger,XTJDistributionType) {
    XTJDistributionTypeMerchant,//商家配送
    XTJDistributionTypeSelf//门店自提
};

//入口类型
typedef NS_ENUM(NSInteger,XTJSearchType) {
    XTJSearchTypeCategory,//从商品分类进去的列表页进入
    XTJSearchTypeKeyword,//从关键字搜索结果页进入
    XTJSearchTypeBrandId,//从品牌id搜索结果页进入
};

//商品排序
typedef NS_ENUM(NSInteger,XTJGoodsPsortType) {
    XTJGoodsPsortTypeCompositive = 0,//综合
    XTJGoodsPsortTypePriceDown = 1,//价格降序
    XTJGoodsPsortTypePriceUp = 2,//价格升序
    XTJGoodsPsortTypeMonthSalesDown = 3,//月销量降序
    XTJGoodsPsortTypeMonthClickDown = 4,//月点击降序，人气
    XTJGoodsPsortTypeOnlineTimeDown = 5,//上架时间降序，新品
    XTJGoodsPsortTypeSift//筛选
};

//订单生成流程
typedef NS_ENUM(NSInteger,XTJOrderCreateType) {
    XTJOrderCreateTypeFromCart,//从购物车进入
    XTJOrderCreateTypeFromBuyNow,//从立即购买进入
    XTJOrderCreateTypeFromScan//从预订单扫码进入
};

//支付方式
typedef NS_ENUM(NSInteger,XTJPayType) {
    XTJPayTypeWeChat,//微信支付
    XTJPayTypeAliPay,//支付宝支付
    XTJPayTypeUnionpay,//银联支付
    XTJPayTypeHelpPay,//微信好友代付
};

//支付结果
typedef NS_ENUM(NSInteger,XTJPayResultType) {

    XTJPayResultTypeSuccess,
    XTJPayResultTypeCancle,
    XTJPayResultTypeSDKFail,
    XTJPayResultTypeNoComplete,
    XTJPayResultTypeInterfaceError,
};

//登录流程类型
typedef NS_ENUM(NSInteger,BJLoginFlowType) {

    BJLoginFlowTypeSimpleLogin,//普通登录
    BJLoginFlowTypeWechatLogin,//微信登录
    BJLoginFlowTypeAlipayLogin,//支付宝登录
    BJLoginFlowTypeApple//苹果登录
};

//密码正则
//#define XTJPasswordRex @"^[a-zA-Z]{1}([a-zA-Z0-9]|[._]){5,19}$" //首字母 字母 数字 长度
//#define XTJPasswordRex @"^[a-zA-Z0-9]{6,20}$" //字母 数字 长度
//#define XTJPasswordRex @"^[\x21-\x7e]{6,20}$" //常用符号 字母 数字 长度
#define XTJPasswordRex @"^.{6,20}$" //长度

#endif /* XTJAppBusinessDefine_h */
