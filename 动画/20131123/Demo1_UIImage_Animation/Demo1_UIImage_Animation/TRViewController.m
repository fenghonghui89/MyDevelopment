//
//  TRViewController.m
//  Demo1_UIImage_Animation
//
//  Created by Tarena on 13-11-23.
//  Copyright (c) 2013年 Tarena. All rights reserved.
//

#import "TRViewController.h"

@interface TRViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation TRViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.imageView.image =
    [UIImage animatedImageNamed:@"playing" duration:2.0];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
