//
//  MD_Responder_VC.m
//  MyDevelopmentTest
//
//  Created by 冯鸿辉 on 16/7/7.
//  Copyright © 2016年 hanyfeng. All rights reserved.
//

#import "MD_Responder_VC.h"
#import "UIView+STKit.h"
#import "MDCustomXIBView.h"

@interface MD_Responder_VC ()
@property(nonatomic,strong)MDCustomXIBView *xibView;
@end

@implementation MD_Responder_VC


#pragma mark - **************** vc lifecycle **************

- (void)viewDidLoad {
  
  [super viewDidLoad];

}

-(void)viewDidAppear:(BOOL)animated{

  [super viewDidAppear:animated];
  
  [self customInitUI];
}

#pragma mark - ************** method ****************
-(void)customInitUI{

  MDCustomXIBView *cv = [[[NSBundle mainBundle] loadNibNamed:@"MDCustomXIBView" owner:self options:nil] lastObject];
  cv.frame = CGRectMake(100, 100, 50, 50);
  [self.view addSubview:cv];
  self.xibView = cv;
  
}
#pragma mark - ************* action ****************

- (IBAction)btnTap:(id)sender {
  
  STLogResponderChain(self.xibView);
  
  UIViewController *vc = self.xibView.btn.viewController;
  NSLog(@"%@",vc);
  NSLog(@"%@",self.xibView.btn.findFirstResponder);
}


@end
