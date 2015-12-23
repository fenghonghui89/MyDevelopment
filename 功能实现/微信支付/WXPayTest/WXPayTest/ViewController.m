//
//  ViewController.m
//  WXPayTest
//
//  Created by 冯鸿辉 on 15/12/23.
//  Copyright © 2015年 DGC. All rights reserved.
//

#import "ViewController.h"
#import "WXApiRequestHandler.h"
#import "WXApiManager.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}
- (IBAction)btnTap:(id)sender
{
  NSString *res = [WXApiManager jumpToBizPay];
  if( ![@"" isEqual:res] ){
    UIAlertView *alter = [[UIAlertView alloc] initWithTitle:@"支付失败" message:res delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    
    [alter show];
  }
  

}

@end
