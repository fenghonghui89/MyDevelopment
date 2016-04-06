//
//  ViewController.m
//  KeychainTest0
//
//  Created by 冯鸿辉 on 16/4/5.
//  Copyright © 2016年 DGC. All rights reserved.
//

#import "ViewController.h"
#import "InfoManager.h"
#import "Define.h"
@interface ViewController ()
@property (weak, nonatomic) IBOutlet UILabel *lab;

@end

@implementation ViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  // Do any additional setup after loading the view, typically from a nib.
  
}

- (IBAction)deleteBtnTap:(id)sender {
  
  [InfoManager deleteInfo:KEY_PASSWORD];
  [self.lab setText:[InfoManager findInfo:KEY_PASSWORD]];
}

- (IBAction)updateBtnTap:(id)sender {
  
  [InfoManager updateInfo:@"222222" service:KEY_PASSWORD];
  [self.lab setText:[InfoManager findInfo:KEY_PASSWORD]];
}

- (IBAction)findBtnTap:(id)sender {
  
  [self.lab setText:[InfoManager findInfo:KEY_PASSWORD]];
  
}

- (IBAction)addBtnTap:(id)sender {
  
  [InfoManager addInfo:@"11111111" service:KEY_PASSWORD];
  [self.lab setText:[InfoManager findInfo:KEY_PASSWORD]];
}
@end
