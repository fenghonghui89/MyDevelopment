//
//  TRViewController.m
//  my00
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

//每次向上扫，图片上移10（连线：swipe的sent action）
- (IBAction)swipe:(id)sender {
    CGRect frame = self.imageView.frame;
    frame.origin.y -= 10;
    self.imageView.frame = frame;
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
