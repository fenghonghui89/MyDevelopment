//
//  TRViewController.m
//  my06
//
//  Created by HanyFeng on 13-11-21.
//  Copyright (c) 2013年 Hany. All rights reserved.
//前提：关闭autolayout

#import "TRViewController.h"

@interface TRViewController ()
@property (weak, nonatomic) IBOutlet UILabel *label1;
@property (weak, nonatomic) IBOutlet UILabel *label2;

@end

@implementation TRViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(BOOL)shouldAutorotate{
    return YES;
}

-(NSUInteger)supportedInterfaceOrientations{
    return UIInterfaceOrientationMaskAll;
}

-(void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    
    //获取当前设备方向
    UIInterfaceOrientation interfaceOrientation = (UIInterfaceOrientation)[[UIApplication sharedApplication] statusBarOrientation];
    
    if (interfaceOrientation == UIInterfaceOrientationPortrait) {
        NSLog(@"Portrait");
    }else if (interfaceOrientation == UIInterfaceOrientationLandscapeLeft) {
        NSLog(@"LandscapeLeft");
    }else if (interfaceOrientation == UIInterfaceOrientationLandscapeRight) {
        NSLog(@"LandscapeRight");
    }else if (interfaceOrientation == UIInterfaceOrientationPortraitUpsideDown) {
        NSLog(@"PortraitUpsideDown");
    }
    
    //改变控件的frame
    CGFloat labelWidth = (self.view.bounds.size.width - 20*2 - 10)/2;
    
    CGRect tempFrame1 = self.label1.frame;
    tempFrame1.origin.x = 20;
    tempFrame1.origin.y = 20;
    tempFrame1.size.width = labelWidth;
    tempFrame1.size.height = 40;
    self.label1.frame = tempFrame1;
    NSLog(@"label1:%f %f %f %f",self.label1.frame.origin.x,self.label1.frame.origin.y,self.label1.frame.size.width,self.label1.frame.size.height);

    CGRect tempFrame2 = self.label2.frame;
    tempFrame2.origin.x = self.view.bounds.size.width - 20 - labelWidth;
    tempFrame2.origin.y = 20 ;
    tempFrame2.size.width = labelWidth;
    tempFrame2.size.height = 40;
    self.label2.frame = tempFrame2;
    NSLog(@"label2:%f %f %f %f",self.label2.frame.origin.x,self.label2.frame.origin.y,self.label2.frame.size.width,self.label2.frame.size.height);
}

@end
