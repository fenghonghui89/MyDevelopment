//
//  NS_NSTimer_VC3.m
//  MyDevelopmentTest
//
//  Created by hanyfeng on 15/9/16.
//  Copyright (c) 2015年 hanyfeng. All rights reserved.
//

#import "MD_NSTimer_VC3.h"
#define FPS 30.0
@interface MD_NSTimer_VC3()
@property (nonatomic,weak  ) NSTimer     *timer;//为了让invalidate方法成功释放timer，要用weak
@property (nonatomic,assign) NSInteger   times;
@property (nonatomic,strong) UIImageView *iv;

@end
@implementation MD_NSTimer_VC3
-(void)viewDidLoad
{
    [super viewDidLoad];
    [self customInitUI];
}

-(void)customInitUI
{
    UIImageView *iv = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"BurstAircraftAircraftBig.png"]];
    iv.frame = CGRectMake((viewW-70)*0.5, viewH-50-10-89, 70, 89);
    [self.view addSubview:iv];
    _iv = iv;
    
    
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake((viewW-50)*0.5, viewH - 50, 50,50)];
    [btn setTitle:@"改变" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [btn setBackgroundColor:[UIColor greenColor]];
    btn.showsTouchWhenHighlighted = YES;
    [btn addTarget:self action:@selector(tap) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
}

-(void)tap
{
    self.timer =
    [NSTimer scheduledTimerWithTimeInterval:1.0/FPS
                                     target:self
                                   selector:@selector(animate:)
                                   userInfo:nil
                                    repeats:YES ];
}

- (void)animate:(id)sender
{
    //当前值 = 上一次的值 + (目标值 - 上一次值) * 渐进因子
    CGPoint center = self.iv.center;
    
    center.y += (10 - center.y) * 0.1;
    
    self.iv.center = center;
    
    //设置终止条件
    CGFloat d = 10 - center.y;//差距
    if (fabs(d) < 0.5) {//当间距的绝对值<0.5就停止，直接为目标值
        center.y = 10;
        self.iv.center = center;
        [self.timer invalidate];
    }
    
}

@end
