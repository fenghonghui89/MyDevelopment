//
//  MDTool.h
//  MyDevelopmentTest
//
//  Created by hanyfeng on 15/2/16.
//  Copyright (c) 2015年 hanyfeng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface MDTool : NSObject
+(MDTool *)sharedInstance;


#pragma mark - 坐标系
/**
 *  屏幕宽度
 *
 *  @return 屏幕宽度
 */
+(CGFloat)screenWidth;

/**
 *  屏幕高度
 *
 *  @return 屏幕高度
 */
+(CGFloat)screenHeight;

/**
 *  导航栏高度
 *
 *  @return 高度
 */
+(CGFloat)navigationBarHeight;

/**
 *  默认状态栏高度
 *
 *  @return 高度
 */
+(CGFloat)stateBarHeight;

/**
 *  默认根vc.view的宽度
 *
 *  @return 宽度
 */
+(CGFloat)viewControllerViewWidth;

/**
 *  默认根vc.view的高度
 *
 *  @return 高度
 */
+(CGFloat)viewControllerViewHeight;

/**
 *  设置rect
 *
 *  @param x x
 *  @param y y
 *  @param w w
 *  @param h h
 *
 *  @return rect
 */
+(CGRect)setRectX:(CGFloat)x y:(CGFloat)y w:(CGFloat)w h:(CGFloat)h;

#pragma mark - color
/**
 *  获取到颜色UICOLOR
 *
 *  @param hexColor “987567”
 *
 *  @return UIColor*
 */
+ (UIColor *)TColor:(NSString *)hexColor;


/**
 *  获取到颜色UICOLOR
 *
 *  @param hexColor “987567”
 *  @param alpha    0 ~ 1
 *
 *  @return UIColor
 */
+ (UIColor *)TColor:(NSString *)hexColor colorAlpha:(CGFloat)alpha;

#pragma mark - other 
void STLogResponderChain(UIResponder *responder);
/**
 *  把plist文件转换成数组返回
 *
 *  @param plistName plist文件名称
 *
 *  @return 转换后的数组
 */
+(NSArray *)getPlistDataByName:(NSString *)plistName;


/**
 *  获取 输出指定文字内容所需的size
 *
 *  @param content  文字内容
 *  @param fontSize 字号
 *  @param width    允许显示的最大宽度，传0代表不限制
 *  @param height   允许显示的最大高度，传0代表不限制
 *
 *  @return 输出指定文字内容所需的size
 */
+(CGSize)getStringSizeWithString:(NSString *)content
                         andFont:(float)fontSize
                        andWidth:(float)width andHeight:(float)height;

/**
 *  获取当前时区的时间
 *
 *  @return 时间字符串yyyy-MM-dd
 */
+(NSString *)getDateTime;

/**
 *  输出设备型号
 *
 */
- (NSString*) machineName;



/**
 *  输出设备相关信息
 *
 */
-(void)showDeviceInfo;

/**
 *  ip address
 *
 *  @return ip
 */
-(NSString *)IPAddress;

/**
 *  md5加密
 *
 *  @param str 原字符串
 *
 *  @return md5加密字符串
 */
+(NSString *)md5:(NSString *)str;

+ (BOOL)cureentThreadIsMain;
@end
