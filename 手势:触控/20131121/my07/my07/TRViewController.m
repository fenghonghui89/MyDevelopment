//
//  TRViewController.m
//  my07
//
//  Created by HanyFeng on 13-11-21.
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
    CGRect tempFrame = self.imageView.frame;
    tempFrame.size.width = self.view.bounds.size.width - 20 * 2;
    tempFrame.size.height = self.view.bounds.size.height - 70 - 50;
    tempFrame.origin.x = 20;
    tempFrame.origin.y = 70;
    self.imageView.frame = tempFrame;
}

@end
