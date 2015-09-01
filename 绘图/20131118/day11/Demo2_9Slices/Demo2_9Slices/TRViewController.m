//
//  TRViewController.m
//  Demo2_9Slices
//
//  Created by Tarena on 13-11-18.
//  Copyright (c) 2013年 Tarena. All rights reserved.
//

#import "TRViewController.h"

@interface TRViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIImageView *imageView2;

@end

@implementation TRViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UIImage * image = [UIImage imageNamed:@"delete_btn.png"];
    UIImage * resizedImage =
    [image resizableImageWithCapInsets:UIEdgeInsetsMake(10, 10, 10, 10)
                          resizingMode:UIImageResizingModeStretch];

    self.imageView.image = resizedImage;
    
    UIImage * image2 = [UIImage imageNamed:@"seperator.png"];
    UIImage * resizedImage2 =
    [image2 resizableImageWithCapInsets:UIEdgeInsetsMake(3, 4, 3, 4)
                           resizingMode:UIImageResizingModeTile];
    self.imageView2.image = resizedImage2;
    
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
