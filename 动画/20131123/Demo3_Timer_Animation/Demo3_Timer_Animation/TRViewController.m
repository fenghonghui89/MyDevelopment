//
//  TRViewController.m
//  Demo3_Timer_Animation
//
//  Created by Tarena on 13-11-23.
//  Copyright (c) 2013年 Tarena. All rights reserved.
//

#import "TRViewController.h"

@interface TRViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@property (nonatomic) int times;//当前帧数（在OC下整型属性就算不初始化赋值一般初始也为0，但C下面必须初始化赋值）
@property (nonatomic, weak) NSTimer * timer;//为了让invalidate方法成功释放timer，要用weak
@end

@implementation TRViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSLog(@"self.times:%d",self.times);
    self.imageView.alpha = 0;//初始化透明度
    
	// Do any additional setup after loading the view, typically from a nib.
}

#define FPS 30.0

//按钮方法
- (IBAction)tap:(id)sender {
    
    self.timer =
    [NSTimer scheduledTimerWithTimeInterval:1.0 / FPS
                                     target:self
                                   selector:@selector(animate:)//每次间隔后都会执行后面的方法
                                   userInfo:nil
                                    repeats:YES];
    
    //scheduledTimer方法会生成一个NSTimer对象并加入到循环队列（可以理解为自动加入到self.view subview中，自动管理内存）
    //[NSTime timerWithTimeInterval:<#(NSTimeInterval)#> target:<#(id)#> selector:<#(SEL)#> userInfo:<#(id)#> repeats:<#(BOOL)#>];该方法和上面的类似，但只是创建出一个对象，不会加入到循环队列
    
}

//动画方法
- (void)animate:(id)sender
{
    //开始值 + 当前的帧数 * (结束值 - 开始值) / (帧频 * 动画时长)
    //0                    1        0        FPS   1
    self.times ++;
    
    self.imageView.alpha =
    0 + self.times * (1 - 0) / (FPS * 1.0);
    
    NSLog(@"self.times:%d", self.times);
 
    //让self.timer停止
    if (self.times > FPS * 1.0) {//当前帧数>总帧数
        [self.timer invalidate];//会彻底销毁对象，所以不能停止再运行
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
