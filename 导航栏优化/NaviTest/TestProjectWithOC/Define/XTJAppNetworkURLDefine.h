//
//  XTJAppNetworkURLDefine
//  XTJMall
//
//  Created by hanyfeng on 2017/11/28.
//  Copyright © 2017年 hanyfeng. All rights reserved.
//

#ifndef XTJAppNetworkURLDefine_h
#define XTJAppNetworkURLDefine_h

#pragma mark - < 1.自定义 >
#define XTJ_URL_checkToken @"/app/v1/member/coupon/list.action" //检测token

#pragma mark - < 2.通用接口 >
#define XTJ_URL_getServerTime @"/app/common/getServerTime.action" //2.1 返回服务器当前时间
#define XTJ_URL_getCaptchaId @"/app/common/captcha/getCaptchaId.action" //2.2 获取captchaId(弃用)
#define XTJ_URL_captcha @"/app/common/captcha.action"//2.3 获取图文验证码(弃用)
#define XTJ_URL_getRsaPublicKey @"/app/common/getRsaPublicKey.action"//2.4 获取rsa公钥
#define XTJ_URL_fileUpload @"/app/common/upload.action" //2.5 文件上传
#define XTJ_URL_findAllArea @"/app/common/findAllArea.action" //2.6 查询全国所有地区
#define XTJ_URL_categoryData @"/app/common/category/data.action" //2.7 获取主页信息列表
#define XTJ_URL_AlipaySign @"/app/common/alipay/sign.action" //2.8 支付宝请求参数签名
#define XTJ_URL_color @"/app/common/color/data.action"//2.9 查询色系数据
#define XTJ_URL_staticData @"/app/common/staticData/get.action"//2.10 其他通用静态数据
#define XTJ_URL_update @"/app/common/version/data.action" //2.11 检测更新
#define XTJ_URL_common_returnsShipping @"/app/common/returns/shipping.action" //2.12 售后寄货地址
#define XTJ_URL_advert @"/app/v1/coupon/list.action"//2.13 查询广告数据

#pragma mark - < 3.登录接口 >
#define XTJ_URL_login @"/app/v1/login.action"//3.1 登录
#define XTJ_URL_wechatLogin @"/app/v1/login/wx.action" //3.2 微信快捷登录，根据code检测是否绑定手机号
#define XTJ_URL_alipayLogin @"/app/v1/login/alipay.action" //3.3 支付宝快捷登录，根据code检测是否绑定手机号
#define XTJ_URL_logout @"/app/v1/logout.action"//3.4 退出登录
#define XTJ_URL_scanLogin @"/app/v1/login/scan.action" //3.5 扫码登录
#define XTJ_URL_confirmScanLogin @"/app/v1/login/scan/confirm.action" //3.6 扫码登录确认
#define XTJ_URL_loginSMS @"/app/v1/account/login/sms.action" // 3.7、快捷登录 - 发送短信(新版)
#define XTJ_URL_loginQuick @"/app/v1/account/login/quick.action" // 3.8、快捷登录 - 短信登录(新版)

#pragma mark - < 4.注册接口 >
#define XTJ_URL_registerSMS @"/app/v1/account/register/sms.action"//4.1、用户注册 - 发送短信(新版)
#define XTJ_URL_simpleRegister @"/app/v1/account/register/member.action"//4.3、用户注册(新版)
#define XTJ_URL_accountBindSMS @"/app/v1/account/bind/sms.action" //注册-第三方登录快速注册发送短信验证码(新版)
#define XTJ_URL_accountBindWechat @"/app/v1/account/bind/wechat.action" //4.4 注册-微信登录注册(新版)
#define XTJ_URL_accountBindAlipay @"/app/v1/account/bind/alipay.action" //4.5 注册-支付宝登录注册(新版)

#pragma mark - < 5.会员中心 - 评价接口 >
#define XTJ_URL_UnReviewList @"/app/v1/member/review/list.action" //5.1 未评价列表
#define XTJ_URL_HasReviewedList @"/app/v1/member/review/reviewed_list.action" //5.2 已评价列表
#define XTJ_URL_PostReview @"/app/v1/member/review/review.action" //5.3 评价提交

#pragma mark - < 6.会员中心 - 收货人地址管理 >
#define XTJ_URL_AddMemberReceiver @"/app/v1/member/receiver/add.action"//6.1 添加地址
#define XTJ_URL_DeleteMemberReceiver @"/app/v1/member/receiver/delete.action"//6.2 删除地址
#define XTJ_URL_EditMemberReceiver @"/app/v1/member/receiver/edit.action"//6.3 编辑地址
#define XTJ_URL_MemberReceiverList @"/app/v1/member/receiver/list.action"//6.4 地址列表
#define XTJ_URL_SetDefaultMemberReceiver @"/app/v1/member/receiver/setDefault.action"//6.5 设置为默认地址

#pragma mark - < 7.会员中心 - 优惠券 >
#define XJT_URL_memberCouponList @"/app/v1/member/coupon/list.action" //7.1 列表
#define XTJ_URL_memberCouponDraw @"/app/v1/member/coupon/draw.action" //7.2 领取优惠券
#define XTJ_URL_couponList @"/app/v1/coupon/list.action" //7.3 非会员优惠券列表

#pragma mark - < 8.会员中心 - 售后服务 >
#define XTJ_URL_memberReturnsList @"/app/v1/member/returns/list.action" //8.1 售后服务列表
#define XTJ_URL_memberReturnApply @"/app/v1/member/returns/apply.action" //8.2 申请售后服务
#define XTJ_URL_mermberReturnsProcess @"/app/v1/member/returns/process.action" //8.3 申请记录
#define XTJ_URL_memberReturnsProcessDetail @"/app/v1/member/returns/process/detail.action" //8.4 申请详情
#define XTJ_URL_memberReturnsAddShipments @"/app/v1/member/returns/addShipments.action" //8.5 填写发货信息
#define XTJ_URL_memberReturnsfindDeliveryCorp @"/app/v1/member/returns/findDeliveryCorp.action" //8.6 查询快递公司列表信息
#define XTJ_URL_memberReturnsCancelReturns @"/app/v1/member/returns/cancelReturns.action" //8.6 取消申请
#define XTJ_URL_memberReturnsFinish @"/app/v1/member/returns/finish.action" //8.8 确认问题已解决

#pragma mark - < 9.忘记密码 >
#define XTJ_URL_accountPasswdSMS @"/app/v1/account/passwd/sms.action" //9.2 忘记密码-发送短信(新版)
#define XTJ_URL_accountPasswdReset @"/app/v1/account/passwd/reset.action" //9.3 忘记密码-重设密码(新版)

#pragma mark - < 10.会员中心 - 会员设置 >
#define XTJ_URL_memberPasswordSetting @"/app/v1/member/setting/passwordSetting.action" //10.1会员设置
#define XTJ_URL_memberSetLogo @"/app/v1/member/setting/setLogo.action" //10.2修改头像

#pragma mark - < 11.会员中心 - 商品关注 >
#define XTJ_URL_favoriteList @"/app/v1/member/favorite/list.action" //11.1 列表
#define XTJ_URL_addFavorite @"/app/v1/member/favorite/addFavorite.action" //11.2 添加关注
#define XTJ_URL_deleteFavorite @"/app/v1/member/favorite/deleteFavorite.action" //11.3 取消关注
#define XTJ_URL_checkFavorite @"/app/v1/member/favorite/checkFavorite.action" //11.4 根据商品Id判断是否有记录

#pragma mark - < 12.品牌接口 >
#define XTJ_URL_BrandList @"/app/v1/brand/list.action" //12.1 列表数据
#define XTJ_URL_BrandGoodsList @"/app/v1/brand/goods.action" //12.2 商品列表数据

#pragma mark - < 13.主题专区 >
#define XTJ_URL_topicList @"/app/v1/topic/list.action" //13.1主题专区列表
#define XTJ_URL_topicListV2 @"/app/v2/topic/list.action" //13.3、主题列表页数据接口
#define XTJ_URL_topicIndex @"/app/v2/topic/index.action" //13.4、主题详细页数据接口

#pragma mark - < 14.会员中心 - 我的订单 >
#define XTJ_URL_MemberOrderList @"/app/v1/member/order/list.action" //14.1 列表数据
#define XTJ_URL_MemberOrderDetails @"/app/v1/member/order/details.action" //14.2 订单详情
#define XTJ_URL_MemberOrderTracking @"/app/v1/member/order/tracking.action" //14.3 订单跟踪信息
#define XTJ_URL_MemberOrderDelete @"/app/v1/member/order/delete.action" //14.4 删除订单
#define XTJ_URL_MemberOrderCancle @"/app/v1/member/order/cancle.action" //14.5 取消订单
#define XTJ_URL_MemberOrderReceive @"/app/v1/member/order/receive.action" //14.6确认收货

#pragma mark - < 17.购物车接口 >
#define XTJ_URL_CartItemList @"/app/v1/member/cart/itemList.action" //17.1 购物车商品列表数据
#define XTJ_URL_CartAddItem @"/app/v1/member/cart/addItem.action" //17.2 把商品添加到购物车
#define XTJ_URL_CartEditQuantity @"/app/v1/member/cart/editQuantity.action" //17.3 修改商品的购买数量
#define XTJ_URL_CartRemoveItem @"/app/v1/member/cart/removeItem.action" //17.4 从购物车中移除商品
#define XTJ_URL_CartTransferItem @"/app/v1/member/cart/transferItem.action" //17.5 移到我的关注
#define XTJ_URL_CartSelectItem @"/app/v1/member/cart/selectItem.action" //17.6 选取需要结算的商品
#define XTJ_URL_CartEditItem @"/app/v1/member/cart/editItem.action" //17.7 修改购物车中商品规格

#pragma mark - < 18.商品接口 >
#define XTJ_URL_GoodsData @"/app/v3/goods/data.action" //18.1 查询商品规格、单位信息
#define XTJ_URL_GoodsList @"/app/v1/goods/list.action" //18.2 列表数据
#define XTJ_URL_GoodsSearchData @"/app/v1/search/data.action" //18.3 商品搜索
#define XTJ_URL_GoodSearchSuggest @"/app/v1/search/suggest.action" //18.4 关键字搜索建议

#pragma mark - < 19.商品详情 >
#define XTJ_URL_GoodsDetailData @"/app/v1/goods/detail/data.action" //19.1 获取商品详情
#define XTJ_URL_GoodsDetailReview @"/app/v1/goods/detail/review.action" //19.2 获取商品评论信息

#pragma mark - < 20.下单支付相关 >
#define XTJ_URL_getOrderInfo @"/app/v1/order/getOrderInfo.action" //20.1 获取订单结算界面数据接口(购物车)
#define XTJ_URL_orderCalculate @"/app/v1/order/calculate.action" //20.2 获取订单金额数据接口(购物车)
#define XTJ_URL_orderCreate @"/app/v2/order/create.action" //20.3 提交订单数据接口(购物车)

#define XTJ_URL_orderBuyNow @"/app/v1/order/buyNow.action" //20.4 获取订单结算页数据接口(立即购买)
#define XTJ_URL_orderAmount @"/app/v1/order/amount.action" //20.5 获取订单金额数据接口(立即购买)
#define XTJ_URL_memberOrderSubmit @"/app/v2/order/submit.action" //20.6 提交订单数据接口(立即购买)

#define XTJ_URL_paymentAlipay @"/app/v1/payment/alipay.action" //20.7 生成APP预支付订单(支付宝)
#define XTJ_URL_paymentWeiXin @"/app/v1/payment/weixinpay.action" //20.8 生成APP预支付订单(微信)
#define XTJ_URL_paymentUnionpay @"/app/v1/payment/unionpay.action" //20.9 生成APP预支付订单(银联)
#define XTJ_URL_paymentCheck @"/app/v1/payment/check.action" //20.10 检查支付结果

#define XTJ_URL_orderInfoScan @"/app/v1/order/prep.action" //20.11 获取订单结算界面数据接口(扫码)
#define XTJ_URL_orderSubmitScan @"/app/v1/order/prep/submit.action" //20.12 提交订单数据接口(扫码)
#define XTJ_URL_orderCalculateScan @"/app/v1/order/prep/calculate.action" //20.13 获取订单金额数据接口(扫码)

#pragma mark - < 21.其他接口 >
#define XTJ_URL_startData @"/app/v1/index/startData.action" //21.1、获取程序启动数据接口
#define XTJ_URL_homePageData @"/app/v5/index/data.action" //21.2、首页数据

#pragma mark - < 22.Banner管理 >
#define XTJ_URL_bannerList @"/app/v2/banner/list.action" //22.1、根据位置获取banner数据列表

#pragma mark - < 24.商品小样 >
#define XTJ_URL_sampleOrderList @"/app/v1/sampleOrder/list.action" //24.1、获取购物车中商品样品数据
#define XTJ_URL_sampleOrderSingle @"/app/v2/sampleOrder/form.action" //24.2、获取小样订单表单数据
#define XTJ_URL_sampleOrderSubmit @"/app/v2/sampleOrder/submit.action" //24.3、提交订单接口
#define XTJ_URL_sampleOrderMyList @"/app/v1/sampleOrder/myList.action" //24.4、我的小样订单接口
#define XTJ_URL_sampleOrderTracking @"/app/v1/sampleOrder/tracking.action" //24.5、订单跟踪信息

#pragma mark - < 25.美丽说 >
#define XTJ_URL_beautySayList @"/app/v1/beautysay/list.action" //25.1 资讯列表
#define XTJ_URL_beautySayDetail @"/app/v1/beautysay/detail.action" //25.2 资讯详情

#pragma mark - < 26.图形搜索 >
#define XTJ_URL_imageSearch_search @"/app/v1/imageSearch/search.action" //26.1 根据图像搜索商品
#define XTJ_URL_imageSearch_upload @"/app/v1/imageSearch/upload.action" //26.2 上传图片

#pragma mark - < 27.抢购活动 >
#define XTJ_URL_flashSaleListData @"/app/v1/flashSale/data.action"//抢购专场列表
#define XTJ_URL_flashSaleDetailFirst @"/app/v1/flashSale/detail/frist.action"//抢购专场详情页 第一页
#define XTJ_URL_flashSaleDetailNext @"/app/v1/flashSale/detail/next.action"//抢购专场详情页 其他页

#pragma mark - < 28.用户反馈接口 >
#define XTJ_URL_feedback_classifyList @"/app/v1/member/feedback/classify/list.action"//28.1 反馈分类列表数据接口
#define XTJ_URL_feedback_submit @"/app/v1/member/feedback/submit.action"//28.2 提交反馈数据接口
#define XTJ_URL_feedback_list @"/app/v1/member/feedback/list.action"//28.3 查询反馈记录据接口
#define XTJ_URL_feedback_detail @"/app/v1/member/feedback/detail.action"//28.4 查询反馈详情数据接口
#define XTJ_URL_feedback_return @"/app/v1/member/feedback/return.action"//28.5 提交回复接口

#pragma mark - < 29.获取代支付链接 >
#define XTJ_URL_weixinpayProxy @"/app/v1/payment/weixinpay/proxy.action" // 29.1获取代支付链接

#endif /* XTJAppNetworkURLDefine_h */
