//
//  MDUIScrollView2ViewController.m
//  MyDevelopmentTest
//
//  Created by hanyfeng on 15/2/28.
//  Copyright (c) 2015年 hanyfeng. All rights reserved.
//

#import "MDUIScrollView2ViewController.h"

@interface MDUIScrollView2ViewController ()

@end

@implementation MDUIScrollView2ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIImage *image = [UIImage imageNamed:@"shu.jpg"];
    UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
    
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:self.view.frame];
    scrollView.contentSize = CGSizeMake(imageView.frame.size.width,imageView.frame.size.height);
    
    [scrollView addSubview:imageView];
    [self.view addSubview:scrollView];
}

@end
