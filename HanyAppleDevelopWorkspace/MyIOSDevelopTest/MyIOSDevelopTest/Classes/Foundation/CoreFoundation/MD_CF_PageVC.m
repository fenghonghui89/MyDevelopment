//
//  MD_CF_PageVC.m
//  MyIOSDevelopTest
//
//  Created by hanyfeng on 2019/6/26.
//  Copyright © 2019 hanyfeng. All rights reserved.
//

#import "MD_CF_PageVC.h"

@interface MD_CF_PageVC ()

@end

@implementation MD_CF_PageVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

#pragma mark -
//用CFTypeID确定cf对象类型
-(void)test_typeID{
    
    CFTypeID type = CFGetTypeID([UIColor whiteColor].CGColor);
    if (CGColorGetTypeID() == type) {
        NSLog(@"anObject is an color.");
    }else{
        NSLog(@"anObject is NOT an color.");
    }
    
    
}

//输出cfstring内容 只能用于调试
-(void)test_cfstring{
    
    NSString *str = @"what happen";
    CFStringRef strcf = (__bridge CFStringRef)str;
    strcf = CFStringCreateWithCString(kCFAllocatorDefault, "sssss?", kCFStringEncodingASCII);
    
    //输出typeID相关
    CFStringRef descrip = CFCopyTypeIDDescription(CFGetTypeID(strcf));
    CFShow(descrip);
    CFShowStr(descrip);
    
    //会输出内容
    descrip = CFCopyDescription(strcf);
    CFShow(descrip);
    CFShowStr(descrip);
}

//比较cf字符串
-(void)test_equalStr{
    
    NSString *str = @"what happen";
    CFStringRef strcf = (__bridge CFStringRef)str;
    //    strcf = CFStringCreateWithCString(kCFAllocatorDefault, "sssss?", kCFStringEncodingASCII);
    
    CFStringRef strcf1 = CFStringCreateWithCString(CFAllocatorGetDefault(), "what happen?", kCFStringEncodingASCII);
    
    bool b = CFEqual(strcf, strcf1);
    if (b) {
        NSLog(@"~~~~~");
    }else{
        NSLog(@".....");
    }
}

//cf与oc免费桥接
-(void)test_tollfree{
    
    NSLocale *gbNSLocale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_GB"];
    CFLocaleRef gbCFLocale = (__bridge CFLocaleRef)gbNSLocale;
    CFStringRef cfIdentifier = CFLocaleGetIdentifier(gbCFLocale);
    NSLog(@"cfIdentifier: %@", (__bridge NSString *)cfIdentifier);
    // Logs: "cfIdentifier: en_GB"
    
    CFLocaleRef myCFLocale = CFLocaleCopyCurrent();
    NSLocale *myNSLocale = (NSLocale *)CFBridgingRelease(myCFLocale);
    NSString *nsIdentifier = [myNSLocale localeIdentifier];
    CFShow((CFStringRef)[@"nsIdentifier: " stringByAppendingString:nsIdentifier]);
    // Logs identifier for current locale
}

//打印cf类型对象
//这只是其中一种方法 可用其他cfstring函数
void describe255(CFTypeRef tested) {
    char buffer[256];
    CFIndex got;
    CFStringRef description = CFCopyDescription(tested);
    CFStringGetBytes(description,
                     CFRangeMake(0, CFStringGetLength(description)),
                     CFStringGetSystemEncoding(), '?', TRUE, buffer, 255, &got);
    buffer[got] = (char)0;
    fprintf(stdout, "%s", buffer);
    CFRelease(description);
}



@end
