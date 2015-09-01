//
//  TRViewController.m
//  my08
//
//  Created by HanyFeng on 13-11-21.
//  Copyright (c) 2013年 Hany. All rights reserved.
//

#import "TRViewController.h"

@interface TRViewController ()
@property (weak, nonatomic) IBOutlet UIButton *button1;
@property (weak, nonatomic) IBOutlet UIButton *button2;
@property (weak, nonatomic) IBOutlet UIButton *button3;
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

-(void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    CGRect tempFrame1 = self.button1.frame;
    CGRect tempFrame2 = self.button1.frame;
    CGRect tempFrame3 = self.button1.frame;
    
    tempFrame1.origin.x = self.view.bounds.size.width - 100;
    tempFrame1.origin.y = self.view.bounds.size.height - 40;
    tempFrame2.origin.x = self.view.bounds.size.width - 70;
    tempFrame2.origin.y = self.view.bounds.size.height - 40;
    tempFrame3.origin.x = self.view.bounds.size.width - 40;
    tempFrame3.origin.y = self.view.bounds.size.height - 40;
    
    self.button1.frame = tempFrame1;
    self.button2.frame = tempFrame2;
    self.button3.frame = tempFrame3;


}

@end
