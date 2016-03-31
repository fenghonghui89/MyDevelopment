//
//  MDTool.m
//  MyDevelopmentTest
//
//  Created by hanyfeng on 15/2/16.
//  Copyright (c) 2015年 hanyfeng. All rights reserved.
//

#import "MDTool.h"
#import "NSString+Category.h"
#import "IPAddress.h"
#import <CommonCrypto/CommonDigest.h>
#import <sys/utsname.h>
@interface MDTool ()
@property(nonatomic,copy)NSString *IPAdress;
@end

@implementation MDTool

+(MDTool *)sharedInstance
{
  static MDTool *sharedInstance = nil;
  static dispatch_once_t once;
  dispatch_once(&once,^{
    sharedInstance = [[self alloc] init];
    sharedInstance.IPAdress = @"";
  });
  
  return sharedInstance;
}


#pragma mark - 坐标系
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
 *  导航栏高度
 *
 *  @return 高度
 */
+(CGFloat)navigationBarHeight
{
  return 44;
}

/**
 *  默认状态栏高度
 *
 *  @return 高度
 */
+(CGFloat)stateBarHeight
{
  return 20;
}

/**
 *  默认根vc.view的宽度
 *
 *  @return 宽度
 */
+(CGFloat)viewControllerViewWidth
{
  return [self screenWidth];
}

/**
 *  默认根vc.view的高度
 *
 *  @return 高度
 */
+(CGFloat)viewControllerViewHeight
{
  if ([[[UIDevice currentDevice] systemVersion] floatValue] < 7.0) {
    return [self screenHeight] - 20;//减去状态栏高度
  }else{
    return [self screenHeight];
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

#pragma mark - color

/**
 *  获取到颜色UICOLOR
 *
 *  @param hexColor “987567”
 *
 *  @return UIColor*
 */
+ (UIColor *)TColor:(NSString *)hexColor
{
  return [self TColor:hexColor colorAlpha:1];
}

/**
 *  获取到颜色UICOLOR
 *
 *  @param hexColor “987567”
 *  @param alpha    0 ~ 1
 *
 *  @return UIColor
 */
+ (UIColor *)TColor:(NSString *)hexColor colorAlpha:(CGFloat)alpha
{
  NSAssert(hexColor, @"获取到颜色UICOLOR -->hexColor not be nil");
  
  NSString *cString = [[hexColor stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
  
  // String should be 6 or 8 characters
  if ([cString length] < 6) {
    return [UIColor clearColor];
  }
  
  // strip 0X if it appears
  if ([cString hasPrefix:@"0X"]){
    cString = [cString substringFromIndex:2];
  }else if ([cString hasPrefix:@"#"]){
    cString = [cString substringFromIndex:1];
  }else if ([cString length] != 6){
    return [UIColor clearColor];
  }
  
  // Separate into r, g, b substrings
  NSRange range;
  range.location = 0;
  range.length = 2;
  
  //r
  NSString *rString = [cString substringWithRange:range];
  
  //g
  range.location = 2;
  NSString *gString = [cString substringWithRange:range];
  
  //b
  range.location = 4;
  NSString *bString = [cString substringWithRange:range];
  
  // Scan values
  unsigned int r, g, b;
  [[NSScanner scannerWithString:rString] scanHexInt:&r];
  [[NSScanner scannerWithString:gString] scanHexInt:&g];
  [[NSScanner scannerWithString:bString] scanHexInt:&b];
  
  return [UIColor colorWithRed:((float) r / 255.0f) green:((float) g / 255.0f) blue:((float) b / 255.0f) alpha:alpha];
}


#pragma mark - other
/**
 *  展示响应链
 *
 *  @param responder 响应链
 */
void STLogResponderChain(UIResponder *responder) {
  NSLog(@"------------------The Responder Chain------------------");
  NSMutableString *spaces = [NSMutableString stringWithCapacity:4];
  while (responder) {
    NSLog(@"%@%@", spaces, responder.class);
    responder = responder.nextResponder;
    [spaces appendString:@"----"];
  }
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
 *  输出设备型号
 *
 */
- (NSString*) machineName
{
  struct utsname systemInfo;
  uname(&systemInfo);
  NSString *result = [NSString stringWithCString:systemInfo.machine
                                        encoding:NSUTF8StringEncoding];
  
  return result;
}

/**
 *  输出设备相关信息
 *
 */
-(void)showDeviceInfo
{
  UIDevice *device_=[[UIDevice alloc] init];
  NSLog(@"设备所有者的名称－－%@",device_.name);
  NSLog(@"设备的类别－－－－－%@",device_.model);
  NSLog(@"设备的的本地化版本－%@",device_.localizedModel);
  NSLog(@"设备运行的系统－－－%@",device_.systemName);
  NSLog(@"当前系统的版本－－－%@",device_.systemVersion);
  NSLog(@"设备识别码－－－－－%@",device_.identifierForVendor.UUIDString);
}

/**
 *  获取当前时区的时间
 *
 *  @return 时间字符串yyyy-MM-dd
 */
+(NSString *)getDateTime
{
  NSDate *date = [NSDate date];
  NSDateFormatter *df = [[NSDateFormatter alloc] init];
  [df setDateFormat:@"yyyy-MM-dd"];
  NSTimeZone *timezone = [NSTimeZone localTimeZone];
  [df setTimeZone:timezone];
  
  NSString *timeString = [df stringFromDate:date];
  return timeString;
}

/**
 *  ip address
 *
 *  @return ip
 */
-(NSString *)IPAddress{
  InitAddresses();
  GetIPAddresses();
  GetHWAddresses();
  
  if([self.IPAdress isBlankString]){
    self.IPAdress = [NSString stringWithFormat:@"%s",ip_names[1]];
  }
  
  return self.IPAdress;
}

+(NSString *)md5:(NSString *)str
{
  const char *cStr = [str UTF8String];
  unsigned char result[32];
  CC_MD5(cStr, strlen(cStr), result); // This is the md5 call
  return [NSString stringWithFormat:
          @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
          result[0], result[1], result[2], result[3],
          result[4], result[5], result[6], result[7],
          result[8], result[9], result[10], result[11],
          result[12], result[13], result[14], result[15]
          ];
}

+ (BOOL)cureentThreadIsMain
{
  return [[NSThread currentThread] isMainThread];
}

/**
 *  设备uuid
 *
 *  @return uuid
 */
-(void)uuid{
  
  CFUUIDRef puuid = CFUUIDCreate( nil );
  CFStringRef uuidString = CFUUIDCreateString( nil, puuid );
  NSString * result = (NSString *)CFBridgingRelease(CFStringCreateCopy( NULL, uuidString));
  CFRelease(puuid);
  CFRelease(uuidString);
  
  NSLog(@"uuid:%@",result);

}
@end
