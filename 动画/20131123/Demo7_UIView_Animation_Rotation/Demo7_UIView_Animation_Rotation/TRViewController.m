//
//  TRViewController.m
//  Demo7_UIView_Animation_Rotation
//
//  Created by Tarena on 13-11-23.
//  Copyright (c) 2013年 Tarena. All rights reserved.
//

#import "TRViewController.h"

@interface TRViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *aircraft;

@end

@implementation TRViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

	// Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [self spinAnimationOnView:self.aircraft
                     duration:1.0
                    clockwise:NO];
    
}

- (void) spinAnimationOnView:(UIView *)view
                    duration:(NSTimeInterval)duration
                   clockwise:(BOOL)clockwise
{   //  1.  转 90度, 花 duration / 4
    //  2.  转完以后 再递归
    [UIView animateWithDuration:duration / 4.0
                          delay:0
                        options:UIViewAnimationOptionCurveLinear//匀速
                     animations:
     ^{
         view.transform = CGAffineTransformRotate
         (view.transform, M_PI_2 * (clockwise ? 1 : -1));
     }
                     completion:
     ^(BOOL finished) {
         [self spinAnimationOnView:view duration:duration clockwise:clockwise];
     }
     ];
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
