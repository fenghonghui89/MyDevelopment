//
//  MDTool.m
//  MyDevelopmentTest
//
//  Created by hanyfeng on 15/2/16.
//  Copyright (c) 2015年 hanyfeng. All rights reserved.
//

#import "MDTool.h"
@interface MDTool ()

@end

@implementation MDTool

+(MDTool *)sharedInstance
{
    static MDTool *sharedInstance = nil;
    static dispatch_once_t once;
    dispatch_once(&once,^{
        sharedInstance = [[self alloc] init];
    });
    
    return sharedInstance;
}

/**
 *  把plist文件转换成数组返回
 *
 *  @param plistName plist文件名称
 *
 *  @return 转换后的数组
 */
+(NSArray *)getPlistDataByName:(NSString *)plistName
{
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:plistName ofType:@"plist"];
    
    NSArray *data = [NSArray arrayWithContentsOfFile:plistPath];
    
    return data;
}

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
                        andWidth:(float)width andHeight:(float)height
{
    float twidth = (width == 0?MAXFLOAT:width);
    float theight = (height == 0?MAXFLOAT:height);
    UIFont *font = [UIFont systemFontOfSize:fontSize];
    
    if ([[[UIDevice currentDevice] systemVersion] floatValue] < 7.0) {
        //获取字符串的大小  ios6
        CGSize size = [content sizeWithFont:font constrainedToSize:CGSizeMake(twidth, theight) lineBreakMode:NSLineBreakByCharWrapping];
        return size;
        
    }else{
        
        //获取字符串的大小  ios7s
        NSDictionary *attribute_dic = @{NSFontAttributeName: font};
        
        //Helvetica字体默认大小：12号字（点击NSFontAttributeName，旁边绿色的注释有写）
        //    NSAttributedString* atrString = [[NSAttributedString alloc] initWithString:aString];
        //    NSRange range = NSMakeRange(0, atrString.length);
        //    NSDictionary *dic = [atrString attributesAtIndex:0 effectiveRange:&range];
        
        CGRect rect = [content boundingRectWithSize:CGSizeMake(twidth, theight)  options:NSStringDrawingUsesLineFragmentOrigin attributes:attribute_dic context:nil];
        
        return  rect.size;
    }
    
    return CGSizeZero;
}

/**
 *  屏幕宽度
 *
 *  @return 屏幕宽度
 */
+(CGFloat)screenWidth
{
    return [[UIScreen mainScreen] bounds].size.width;
}

/**
 *  屏幕高度
 *
 *  @return 屏幕高度
 */
+(CGFloat)screenHeight
{
    return [[UIScreen mainScreen] bounds].size.height;
}

/**
 *  自适应导航的高度
 *
 *  @return 高度
 */
+ (CGFloat)navigationBarHeight
{
    CGFloat systemVersion = [[[UIDevice currentDevice] systemVersion] floatValue];
    if (systemVersion < 7.0) {
        return 44.0;
    }else if(systemVersion < 8.0){
        return 64.0;
    }else{
        return 64.0;
    }
}

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
+(CGRect)setRectX:(CGFloat)x y:(CGFloat)y w:(CGFloat)w h:(CGFloat)h
{
    return  CGRectMake(x, y, w, h);;
}
@end
