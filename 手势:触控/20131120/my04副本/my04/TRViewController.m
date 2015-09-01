//
//  TRViewController.m
//  my04
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
    //记得要关闭 using auto layout
    UIRotationGestureRecognizer* rotationGR = [[UIRotationGestureRecognizer alloc] initWithTarget:self action:@selector(rotation:)];
    
    [self.view addGestureRecognizer:rotationGR];


}

-(void)rotation:(UIRotationGestureRecognizer*)rotationGR
{
//正确：拿出来改一改再放回去
    CGAffineTransform transform = self.imageView.transform;
    transform = CGAffineTransformRotate(transform, rotationGR.rotation);
    self.imageView.transform = transform;
    NSLog(@"%.2f",rotationGR.rotation);
    
    //清空rotation（虽然每次开始转动时为0，但实际上会不断叠加？）
    rotationGR.rotation = 0;
    
    
    
//错误：每次调整都会从初始状态开始
    /*
    self.imageView.transform = CGAffineTransformMakeRotation(rotationGR.rotation);
     */
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
