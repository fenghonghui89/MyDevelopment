//
//  ViewController.m
//  pushTest
//
//  Created by hanyfeng on 15/3/24.
//  Copyright (c) 2015年 MD. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITextView *tv1;
@property (weak, nonatomic) IBOutlet UITextView *tv2;

@end

@implementation ViewController

- (void)viewDidLoad {
  
  [super viewDidLoad];
  
//  [self customInitUI];
}

- (void)didReceiveMemoryWarning {
  
  [super didReceiveMemoryWarning];
  
}

-(void)customInitUI{
  NSLog(@"~~~");
  NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
  NSString *decToken = [ud objectForKey:@"deviceToken"];
  NSString *decTokenChange = [ud objectForKey:@"deviceTokenChange"];
  
  self.tv1.text = decToken;
  self.tv2.text = decTokenChange;
}
@end
