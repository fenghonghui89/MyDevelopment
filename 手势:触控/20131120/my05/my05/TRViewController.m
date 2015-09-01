//
//  TRViewController.m
//  my05
//
//  Created by HanyFeng on 13-11-20.
//  Copyright (c) 2013年 Hany. All rights reserved.
//

#import "TRViewController.h"

@interface TRViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation TRViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
	UIPanGestureRecognizer* panGR = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(pan:)];
    [self.imageView addGestureRecognizer:panGR];//加入到imageView，如果加入到self.view就会全屏幕都会响应
}

-(void)pan:(UIPanGestureRecognizer*)panGR
{
    //1.相对于刚点击时的点的坐标
    CGPoint delta = [panGR translationInView:self.view];
    NSLog(@"%.2f %.2f",delta.x,delta.y);
    
    //2.通过中间变量修改拖动后图片中心点的坐标（叠加当次拖动的位移量）
    CGPoint center = self.imageView.center;
    center.x += delta.x;
    center.y += delta.y;
    self.imageView.center = center;
    
    //3.清空位移量（因为默认是相对于最初始位置时的数值，会不断叠加）
    [panGR setTranslation:CGPointZero inView:self.view];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
