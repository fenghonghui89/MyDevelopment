//
//  HFMyFramework.m
//  UIView
//
//  Created by hanyfeng on 14-3-27.
//  Copyright (c) 2014年 hanyfeng. All rights reserved.
//

#import "HFMyFramework.h"
#import "HFAddView.h"
@interface HFMyFramework()
@property(nonatomic,assign)int count;
@end

@implementation HFMyFramework

+(HFMyFramework*)shareMyFramework{
    
    //方法1：传统
    static HFMyFramework *sharedInstance = nil;//创建一个静态变量 初始值为nil
    if (sharedInstance == nil) {
        sharedInstance = [[self alloc] init];
        sharedInstance.count = 1001;
    }

    //方法2：多线程加锁
//    static HFMyFramework *sharedInstance = nil;
//    @synchronized(self)
//    {
//        if (sharedInstance == nil) {
//            sharedInstance = [[self alloc] init];
//        }
//    }

    //方法3：dispatch_once_t
//    static HFMyFramework *sharedInstance = nil;
//    static dispatch_once_t once;
//    dispatch_once(&once,^{
//        sharedInstance = [[self alloc] init];//不能加autoreless，加了会崩
//    });
    
    return sharedInstance;
}

-(void)addView;
{
    NSLog(@"sharedInstance:%@",self);
    float red = arc4random()%11 * 0.1;
    float green = arc4random()%11 * 0.1;
    float blue = arc4random()%11 * 0.1;
    UIColor *color = [UIColor colorWithRed:red green:green blue:blue alpha:1];//工厂方法对象自动放入释放池

    float x = arc4random()%270;
    float y = arc4random()%538;
    CGRect frame = CGRectMake(x, y, 50, 30);
    
    HFAddView *av = [[HFAddView alloc] initWithFrame:frame];
    NSLog(@"AddView:%p",av);
    [av setBackgroundColor:color];
    [av setTag:self.count];
    [[[UIApplication sharedApplication] keyWindow] insertSubview:av atIndex:0];//加在window上，index:0：最底层
    self.count++;
    [av release];
}

-(void)deleteAddView{
    if (self.count == 1000) {
        NSLog(@"清理完毕");
        return;
    }
    
    //从指定view里面获取指定tag对应的view
    UIWindow *window = [[UIApplication sharedApplication] keyWindow];
    UIView *view = [window viewWithTag:self.count-1];
    
    //防止取得的view已经被上面的方法删除
    if (view == nil) {
        self.count--;
        [self deleteAddView];
        return;
    }
    
    [view removeFromSuperview];
    self.count--;
}

//历史遗留原因，单例模式下可能要复写该方法，以杜绝非单例化的创建实例
//+(id)allocWithZone:(struct _NSZone *)zone{
//
//}


@end
