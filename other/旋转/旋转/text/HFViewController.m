//
//  HFViewController.m
//  text
//
//  Created by hanyfeng on 14-3-11.
//  Copyright (c) 2014年 hanyfeng. All rights reserved.
//

#import "HFViewController.h"
#import "HFSecondViewController.h"
@interface HFViewController ()

@end

@implementation HFViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
//    [self addObserver];
//    [self didChangeStatusBar];
    
}

- (IBAction)tap:(id)sender
{
    HFSecondViewController *svc = [HFSecondViewController new];
    [self presentViewController:svc animated:YES completion:nil];
}

#pragma mark - 旋屏设置
//IOS6.0或以后的旋转开关
-(BOOL)shouldAutorotate
{
    return YES;
}

//IOS6.0或以后该vc支持的旋转方向
//旋转到支持的方向后，vc的内容会自动旋转，最终效果为正视效果（非倒视或侧视）
//必须至少有一个方向跟设备旋转方向对应 否则会崩溃
-(NSUInteger)supportedInterfaceOrientations{
    return UIInterfaceOrientationMaskAll;
}

#pragma mark - 添加旋屏通知监听及回调
-(void)addObserver{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didChangeStatusBar) name:UIApplicationDidChangeStatusBarFrameNotification object:nil];
}

-(void)didChangeStatusBar{
    UIInterfaceOrientation io = [[UIApplication sharedApplication] statusBarOrientation];
    switch (io) {
        case UIInterfaceOrientationPortrait:
            NSLog(@"Notification-Portrait");
            break;
        case UIInterfaceOrientationPortraitUpsideDown:
            NSLog(@"Notification-UpsideDown");
            break;
        case UIInterfaceOrientationLandscapeLeft:
            NSLog(@"Notification-LandscapeLeft");
            break;
        case UIInterfaceOrientationLandscapeRight:
            NSLog(@"Notification-LandscapeRight");
            break;
        default:
            break;
    }
}

#pragma mark - 系统提供的旋屏回调
-(void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
    switch (toInterfaceOrientation) {
        case UIInterfaceOrientationPortrait:
            NSLog(@"to~~Portrait");
            break;
        case UIInterfaceOrientationPortraitUpsideDown:
            NSLog(@"to~~UpsideDown");
            break;
        case UIInterfaceOrientationLandscapeLeft:
            NSLog(@"to~~LandscapeLeft");
            break;
        case UIInterfaceOrientationLandscapeRight:
            NSLog(@"to~~LandscapeRight");
            break;
        default:
            break;
    }
}

-(void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation
{
    switch (fromInterfaceOrientation) {
        case UIInterfaceOrientationPortrait:
            NSLog(@"from~~Portrait");
            break;
        case UIInterfaceOrientationPortraitUpsideDown:
            NSLog(@"from~~UpsideDown");
            break;
        case UIInterfaceOrientationLandscapeLeft:
            NSLog(@"from~~LandscapeLeft");
            break;
        case UIInterfaceOrientationLandscapeRight:
            NSLog(@"from~~LandscapeRight");
            break;
        default:
            break;
    }

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
