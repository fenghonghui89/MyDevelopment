//
//  TRViewController.m
//  my02
//
//  Created by HanyFeng on 13-11-18.
//  Copyright (c) 2013年 Hany. All rights reserved.
//

#import "TRViewController.h"

@interface TRViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIImageView *imageView2;
@property (strong, nonatomic) IBOutlet UIImageView *iv3;

@end

@implementation TRViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    UIImage* image = [UIImage imageNamed:@"icon-small.png"];
    UIImage* resizableImage = [image resizableImageWithCapInsets:UIEdgeInsetsMake(1, 9, 1, 9) resizingMode:UIImageResizingModeStretch];//距离上左下右的边距，所形成的矩形为响应拉伸的范围
    self.imageView.image = resizableImage;
    
    UIImage* image2 = [UIImage imageNamed:@"tabbar_item_store.png"];
    UIImage* resizableImage2 = [image2 resizableImageWithCapInsets:UIEdgeInsetsMake(10, 10, 10, 10) resizingMode:UIImageResizingModeTile];
    self.imageView2.image = resizableImage2;
    
    
    UIImage* image3 = [UIImage imageNamed:@"jfda_cont_bg.png"];
    UIImage* resizableImage3 = [image3 resizableImageWithCapInsets:UIEdgeInsetsMake(0, 47, 0, 47) resizingMode:UIImageResizingModeStretch];
    self.iv3.image = resizableImage3;

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
