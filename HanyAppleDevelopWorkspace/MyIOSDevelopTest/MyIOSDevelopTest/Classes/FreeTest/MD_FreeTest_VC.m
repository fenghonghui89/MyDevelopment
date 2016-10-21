//
//  MD_FreeTest_VC.m
//  MyDevelopmentTest
//
//  Created by 冯鸿辉 on 16/2/26.
//  Copyright © 2016年 hanyfeng. All rights reserved.
//





#import "MD_FreeTest_VC.h"

#pragma mark - ******************* MD_FreeTest_VC *******************
@interface MD_FreeTest_VC ()

@property (weak, nonatomic) IBOutlet UIButton *btn;


@end

@implementation MD_FreeTest_VC


#pragma mark - < vc lifecycle >
- (void)viewDidLoad {
  
  [super viewDidLoad];


}

-(void)viewDidAppear:(BOOL)animated{
  
  [super viewDidAppear:animated];
  [self test_map];
}

#pragma mark - < method >

-(void)customInitUI{
  
}


-(void)test_map{

}
#pragma mark - < action >
- (IBAction)btnTap:(id)sender {
  
}

@end
