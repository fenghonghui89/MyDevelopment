//
//  HFCommon.m
//  MyWeiboClient
//
//  Created by hanyfeng on 14-8-14.
//  Copyright (c) 2014年 hanyfeng. All rights reserved.
//

#import "HFCommon.h"
#import "RTLabel.h"
#import "UIViewExt.h"
@implementation HFCommon

+(CGSize)getStringSizeWithString:(NSString *)content andFont:(UIFont *)font andWidth:(float)width andHeight:(float)height;
{
    float twidth = (width == 0?MAXFLOAT:width);
    float theight = (height == 0?MAXFLOAT:height);
    
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

+(UIImage *)getImagePathWithDirectoryName:(NSString *)directoryName andImageName:(NSString *)imageName
{
    NSString *componentPath = [NSString stringWithFormat:@"MyWeiboClient.bundle/%@/%@",directoryName,imageName];
    NSString *imagePath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:componentPath];
    
    UIImage *image = [[UIImage alloc] initWithContentsOfFile:imagePath];
    return [image autorelease];
}

#pragma mark - 通过rtlabel计算高度
+(float)getTextHeightWithFontSize:(float)paramFontSize andWidth:(float)paramWidth andText:(NSString *)text
{
    RTLabel *rtlabel = [[RTLabel alloc] init];
    [rtlabel setText:text];
    [rtlabel setFont:[UIFont systemFontOfSize:paramFontSize]];
    rtlabel.width = paramWidth;
    return rtlabel.optimumSize.height;
}

@end
