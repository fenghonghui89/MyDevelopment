//
//  HFViewController.m
//  Animation
//
//  Created by hanyfeng on 14-3-27.
//  Copyright (c) 2014年 hanyfeng. All rights reserved.
//

#import "HFViewController.h"

@interface HFViewController ()
@property (weak, nonatomic) IBOutlet UILabel *label1;
@property (weak, nonatomic) IBOutlet UILabel *label2;

@end

@implementation HFViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    /*
     NSLog(@"1 start---%d",[[self.view subviews] indexOfObject:self.label1]);
     NSLog(@"2 start---%d",[[self.view subviews] indexOfObject:self.label2]);
     
     //交换两个subview的层级
     [self.view exchangeSubviewAtIndex:[[self.view subviews] indexOfObject:self.label1]
     withSubviewAtIndex:[[self.view subviews] indexOfObject:self.label2]];
     
     NSLog(@"1--lable1:%f %f",self.label1.frame.origin.x,self.label1.frame.origin.y);
     NSLog(@"1--label2:%f %f",self.label2.frame.origin.x,self.label2.frame.origin.y);
     */
}


- (IBAction)change:(id)sender
{
    CGRect frame1 = self.label1.frame;
    CGRect frame2 = self.label2.frame;

    //开始动画
    [UIView beginAnimations:@"add" context:nil];
    
    //设置委托
    [UIView setAnimationDelegate:self];
    
    //动画持续时间
    [UIView setAnimationDuration:2];
    
    //动画结束后执行方法
    [UIView setAnimationDidStopSelector:@selector(changeView1:)];
    
    //动画开始前执行方法
//    [UIView setAnimationWillStartSelector:@selector(changeView2:)];
    
    //动画速度曲线
    [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
    
    //动画过渡方式
//    [UIView setAnimationTransition:UIViewAnimationTransitionCurlUp forView:self.view cache:YES];
    
//    self.label1.frame = frame2;
//    self.label2.frame = frame1;
    
    [self.label1 setFrame:frame2];
    [self.label2 setFrame:frame1];

    //结束动画
    [UIView commitAnimations];
    
}


-(void)changeView1:(NSString*)paramAnimationID{
    NSLog(@"changeView");
    
    if ([paramAnimationID isEqualToString:@"add"]) {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            UIImage *image = [UIImage imageNamed:@"icon.jpg"];
//            [NSThread sleepForTimeInterval:3];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                UIImageView *iv = [[UIImageView alloc] initWithImage:image];
                [iv setFrame:CGRectMake(150, 300, 100, 100)];
                [self.view addSubview:iv];
            });
        });
        NSLog(@"add");
    }else{
        NSLog(@"not");
    }
}

-(void)changeView2:(NSString*)paramAnimationID{
    NSLog(@"changeView");
    if ([paramAnimationID isEqualToString:@"add"]) {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            UIImage *image = [UIImage imageNamed:@"icon.jpg"];
//            [NSThread sleepForTimeInterval:3];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                UIImageView *iv = [[UIImageView alloc] initWithImage:image];
                [iv setFrame:CGRectMake(150, 400, 100, 100)];
                [self.view addSubview:iv];
            });
        });
        NSLog(@"add");
    }else{
        NSLog(@"not");
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
