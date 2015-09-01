//
//  TRViewController.m
//  my02
//
//  Created by HanyFeng on 13-11-20.
//  Copyright (c) 2013年 Hany. All rights reserved.
//

#import "TRViewController.h"

@interface TRViewController ()
@property (weak, nonatomic) IBOutlet UILabel *label;

@end

@implementation TRViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	UIPinchGestureRecognizer* pinchGR = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(pinch:)];
    
    [self.view addGestureRecognizer:pinchGR];
}


-(void)pinch:(UIPinchGestureRecognizer*)pinchGR
{
    CGAffineTransform transform = self.label.transform;
    transform = CGAffineTransformScale(transform, pinchGR.scale, pinchGR.scale);
    self.label.transform = transform;
    NSLog(@"pinchGR.scale:%.2f",pinchGR.scale);
    pinchGR.scale = 1;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
