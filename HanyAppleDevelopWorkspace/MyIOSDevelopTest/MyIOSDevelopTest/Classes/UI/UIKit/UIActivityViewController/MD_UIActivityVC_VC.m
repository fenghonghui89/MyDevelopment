//
//  MD_UIActivityVC_VC.m
//  MyIOSDevelopTest
//
//  Created by 冯鸿辉 on 2016/11/2.
//  Copyright © 2016年 hanyfeng. All rights reserved.
//

#import "MD_UIActivityVC_VC.h"
#import "ZSCustomActivity.h"

@interface MD_UIActivityVC_VC ()<UIDocumentInteractionControllerDelegate>
@property(nonatomic,strong)UIDocumentInteractionController *documentController;
@end

@implementation MD_UIActivityVC_VC

#pragma mark - < overwrite >
- (void)viewDidLoad {
  [super viewDidLoad];
  // Do any additional setup after loading the view from its nib.
}

#pragma mark - < action >
- (IBAction)btnTap:(id)sender {
  
  NSString *message = [NSString stringWithFormat:@"this is message"];
  NSString *subject = [NSString stringWithFormat:@"this is subject"];
  NSURL *url = [NSURL URLWithString:[@"http://tpages.cn" stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLFragmentAllowedCharacterSet]]];
  UIImage *img = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:@"http://o9ivu69va.bkt.clouddn.com/images/testimg.jpg"]]];
  UIImage *img1 = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:@"http://o9ivu69va.bkt.clouddn.com/images/testimg1.jpg"]]];
  NSArray *files = @[img
                     ,img1
                     ];
  NSArray *activityItems = @[img,img1];
  
  UIActivityViewController *ac = [[UIActivityViewController alloc] initWithActivityItems:activityItems applicationActivities:@[[[ZSCustomActivity alloc] init]]];
  ac.excludedActivityTypes = @[UIActivityTypeAirDrop];

  
  [self presentViewController:ac animated:YES completion:NULL];
}



- (IBAction)btn1Tap:(id)sender {
  
  
  self.documentController = [UIDocumentInteractionController interactionControllerWithURL:[[NSBundle mainBundle] URLForResource:@"000" withExtension:@"jpg"]];
  
  //options
  self.documentController.UTI = @"com.instagram.photo";
  self.documentController.delegate = self;//预览功能必须
  
  //展示
//  [self.documentController presentPreviewAnimated:YES];//预览
//  [self.documentController presentOpenInMenuFromRect:self.view.bounds inView:self.view animated:YES];//view
  [self.documentController presentOptionsMenuFromRect:self.view.bounds inView:self.view animated:YES];//view+可选操作（包含预览）
  
  
  
}

#pragma mark - < callback >
#pragma mark * UIDocumentInteractionControllerDelegate
//预览功能必须
-(UIViewController *)documentInteractionControllerViewControllerForPreview:(UIDocumentInteractionController *)controller{

  return self;
}
@end
