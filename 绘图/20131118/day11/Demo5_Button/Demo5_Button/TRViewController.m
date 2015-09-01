//
//  TRViewController.m
//  Demo5_Button
//
//  Created by Tarena on 13-11-18.
//  Copyright (c) 2013年 Tarena. All rights reserved.
//

#import "TRViewController.h"

@interface TRViewController ()
@property (weak, nonatomic) IBOutlet UIButton *button;

@end

@implementation TRViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UIImage * image = [UIImage imageNamed:@"ToolViewEmotion.png"];
    [self.button setImage:image forState:UIControlStateNormal];
    
    UIImage * highlightedImage = [UIImage imageNamed:@"ToolViewEmotionHL.png"];
    [self.button setImage:highlightedImage forState:UIControlStateHighlighted];
    
    
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
