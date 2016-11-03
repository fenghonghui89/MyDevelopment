//
//  MD_UIActivityVC_VC1.m
//  MyIOSDevelopTest
//
//  Created by 冯鸿辉 on 2016/11/3.
//  Copyright © 2016年 hanyfeng. All rights reserved.
//

#import "MD_UIActivityVC_VC1.h"

@interface MD_UIActivityVC_VC1 ()

@end

@implementation MD_UIActivityVC_VC1

- (void)viewDidLoad {
  [super viewDidLoad];
  // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */
- (IBAction)btnTap:(id)sender {
  
  [self dismissViewControllerAnimated:YES completion:nil];
}

@end
