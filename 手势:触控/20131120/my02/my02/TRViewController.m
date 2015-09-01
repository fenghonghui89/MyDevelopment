//
//  TRViewController.m
//  my02
//
//  Created by HanyFeng on 13-11-20.
//  Copyright (c) 2013年 Hany. All rights reserved.
//

#import "TRViewController.h"

@interface TRViewController ()
@property (weak, nonatomic) IBOutlet UILabel *label;

@end

@implementation TRViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	UIPinchGestureRecognizer* pinchGR = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(pinch:)];
    
    [self.view addGestureRecognizer:pinchGR];
}

//老板键（放大时显示，缩小时隐藏）
-(void)pinch:(UIPinchGestureRecognizer*)pinchGR
{
    NSLog(@"%.2f",pinchGR.scale);
    //scale = x2（当次缩放后两点间连线长度）/ x1（当次刚点击时两点间连线长度）
    
    //数值设置为1会太敏感
    if (pinchGR.scale < 0.5) {
        self.label.hidden = YES;
    }else if(pinchGR.scale > 2){
        self.label.hidden = NO;
    }
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
