//
//  TRViewController.m
//  Demo4_Message
//
//  Created by Tarena on 13-11-18.
//  Copyright (c) 2013年 Tarena. All rights reserved.
//

#import "TRViewController.h"

@interface TRViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *inputBackgroundImageView;
@property (weak, nonatomic) IBOutlet UIImageView *textFieldBackgroundImageView;

@end

@implementation TRViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UIImage * inputBack = [UIImage imageNamed:@"ToolViewBkg_Black.png"];
    UIImage * resizedInputBack =
    [inputBack resizableImageWithCapInsets:UIEdgeInsetsMake(10, 10, 10, 10)
                              resizingMode:UIImageResizingModeStretch];
    
    self.inputBackgroundImageView.image = resizedInputBack;
    
    UIImage * textFieldBack = [UIImage imageNamed:@"SendTextViewBkg.png"];
    UIImage * resizedTextFieldBack =
    [textFieldBack resizableImageWithCapInsets:UIEdgeInsetsMake(11, 15, 13, 15)
                                  resizingMode:UIImageResizingModeStretch];
    self.textFieldBackgroundImageView.image = resizedTextFieldBack;
    
    
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
