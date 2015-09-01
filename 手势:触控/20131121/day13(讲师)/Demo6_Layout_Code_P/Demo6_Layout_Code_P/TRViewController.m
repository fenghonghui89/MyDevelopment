//
//  TRViewController.m
//  Demo6_Layout_Code_P
//
//  Created by Tarena on 13-11-21.
//  Copyright (c) 2013年 Tarena. All rights reserved.
//

#import "TRViewController.h"

@interface TRViewController ()

@property (weak, nonatomic) IBOutlet UIButton *button1;
@property (weak, nonatomic) IBOutlet UIButton *button2;

@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@property (weak, nonatomic) IBOutlet UIButton *b1;
@property (weak, nonatomic) IBOutlet UIButton *b2;
@property (weak, nonatomic) IBOutlet UIButton *b3;

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

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    //1.
    CGRect frame;
    
    CGFloat buttonWidth =
    (self.view.bounds.size.width - 20 * 2 - 10) / 2;
    
    frame = CGRectZero;
    frame.size = CGSizeMake(buttonWidth, 40);
    frame.origin = CGPointMake(20, 20);
    self.button1.frame = frame;
    
    frame.origin.x += buttonWidth + 10;
    self.button2.frame = frame;
    
    //  2.
    frame = CGRectZero;
    frame.origin = CGPointMake(20, 70);
    frame.size.width = self.view.bounds.size.width - 20 * 2;
    frame.size.height = self.view.bounds.size.height - 70 - 50;
    self.imageView.frame = frame;
    
    //  3.
    frame = self.b3.frame;
//    frame = CGRectZero;
//    frame.size = CGSizeMake(20, 20);
    frame.origin.y = self.view.bounds.size.height - 20 - frame.size.height;
    frame.origin.x = self.view.bounds.size.width - 20 - frame.size.width;
    self.b3.frame = frame;
    
    frame.origin.x -= (10 + frame.size.width);
    self.b2.frame = frame;
    
    frame.origin.x -= (10 + frame.size.width);
    self.b1.frame = frame;
    
    
    
    
    
    
    
    
}

@end
