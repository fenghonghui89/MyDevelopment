//
//  ViewController.m
//  ChildVC
//
//  Created by hanyfeng on 14-8-19.
//  Copyright (c) 2014年 hanyfeng. All rights reserved.
//

#import "MDMainViewController.h"
#import "FirstViewController.h"
#import "SecondViewController.h"
#import "ThirdViewController.h"
@interface MDMainViewController ()
@property(nonatomic,strong)UIViewController *currentViewController;
@end

@implementation MDMainViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    FirstViewController *firstViewController=[[FirstViewController alloc] initWithNibName:@"FirstViewController" bundle:nil];
    [self addChildViewController:firstViewController];
    
    SecondViewController *secondViewController=[[SecondViewController alloc] initWithNibName:@"SecondViewController" bundle:nil];
    [self addChildViewController:secondViewController];
    
    
    ThirdViewController *thirdViewController=[[ThirdViewController alloc] initWithNibName:@"ThirdViewController" bundle:nil];
    [self addChildViewController:thirdViewController];
    
    //设置刚开始显示时的vc
    [self.view addSubview:thirdViewController.view];
    self.currentViewController = thirdViewController;
}

- (IBAction)tap:(id)sender
{
    FirstViewController *firstViewController=[self.childViewControllers objectAtIndex:0];
    ThirdViewController *thirdViewController=[self.childViewControllers objectAtIndex:2];
    SecondViewController *secondViewController=[self.childViewControllers objectAtIndex:1];
    
    if ((_currentViewController==firstViewController&&[sender tag]==1)||(_currentViewController==secondViewController&&[sender tag]==2) ||(_currentViewController==thirdViewController&&[sender tag]==3) ) {
        return;
    }
    
    UIViewController *oldViewController=_currentViewController;
    
    switch ([sender tag]) {
        case 1:
        {
            NSLog(@"留言及回复");
            [self transitionFromViewController:_currentViewController toViewController:firstViewController duration:4 options:UIViewAnimationOptionTransitionFlipFromLeft animations:^{
            } completion:^(BOOL finished) {
                if (finished) {
                    _currentViewController=firstViewController;
                }else{
                    _currentViewController=oldViewController;
                }
            }];
        }
            break;
        case 2:
        {
            NSLog(@"生日提醒");
            [self transitionFromViewController:_currentViewController toViewController:secondViewController duration:1 options:UIViewAnimationOptionTransitionFlipFromTop animations:^{
                
            } completion:^(BOOL finished) {
                if (finished) {
                    _currentViewController=secondViewController;
                }else{
                    _currentViewController=oldViewController;
                }
            }];
        }
            break;
        case 3: 
        { 
            NSLog(@"好友申请"); 
            [self transitionFromViewController:_currentViewController toViewController:thirdViewController duration:1 options:UIViewAnimationOptionTransitionFlipFromBottom animations:^{
                
            } completion:^(BOOL finished) { 
                if (finished) { 
                    _currentViewController=thirdViewController;
                }else{ 
                    _currentViewController=oldViewController;
                } 
            }]; 
        } 
            break; 
        default: 
            break; 
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
