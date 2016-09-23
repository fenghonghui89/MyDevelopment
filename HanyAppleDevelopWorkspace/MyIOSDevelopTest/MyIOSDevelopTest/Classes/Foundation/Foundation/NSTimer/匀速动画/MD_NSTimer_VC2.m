
//
//  NS_NSTimer_VC2.m
//  MyDevelopmentTest
//
//  Created by hanyfeng on 15/9/16.
//  Copyright (c) 2015年 hanyfeng. All rights reserved.
//

#import "MD_NSTimer_VC2.h"
#define FPS 30.0
@interface MD_NSTimer_VC2()
@property (nonatomic,weak  ) NSTimer     *timer;//为了让invalidate方法成功释放timer，要用weak
@property (nonatomic,assign) NSInteger   times;
@property (nonatomic,strong) UIImageView *iv;
@end
@implementation MD_NSTimer_VC2
-(void)viewDidLoad
{
    [super viewDidLoad];
    [self customInitUI];
    NSLog(@"self.times:%d",self.times);
}

-(void)customInitUI
{
    UIImageView *iv = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Lion.jpg"]];
    iv.frame = CGRectMake(0, 0, viewW, 200);
    iv.alpha = 0;
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
    /*
     scheduledTimer方法会生成一个NSTimer对象并加入到循环队列（可以理解为自动加入到self.view subview中，自动管理内存）
     [NSTime timerWithTimeInterval:<#(NSTimeInterval)#> target:<#(id)#> selector:<#(SEL)#> userInfo:<#(id)#> repeats:<#(BOOL)#>];该方法和上面的类似，但只是创建出一个对象，不会加入到循环队列
     */
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0 / FPS
                                     target:self
                                   selector:@selector(animate:)
                                   userInfo:nil
                                    repeats:YES];
}

- (void)animate:(id)sender
{
    //开始值 + 当前的帧数 * (结束值 - 开始值) / (帧频 * 动画时长)
    //0                    1        0        FPS   1
    self.times ++;
    
    self.iv.alpha = 0 + self.times * (1 - 0) / (FPS * 1.0);
    NSLog(@"self.times:%d", self.times);
    
    //让self.timer停止
    if (self.times > FPS * 1.0) {//当前帧数>总帧数
        [self.timer invalidate];//会彻底销毁对象，所以不能停止再运行
    }
}
@end
