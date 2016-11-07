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
//UIActivityViewController
- (IBAction)btnTap:(id)sender {
  
  NSString *message = [NSString stringWithFormat:@"this is message"];
  NSString *subject = [NSString stringWithFormat:@"this is subject"];
  NSURL *url = [NSURL URLWithString:[@"http://tpages.cn" stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLFragmentAllowedCharacterSet]]];
  UIImage *img = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:@"http://o9ivu69va.bkt.clouddn.com/images/testimg.jpg"]]];
  UIImage *img1 = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:@"http://o9ivu69va.bkt.clouddn.com/images/testimg1.jpg"]]];
  NSString *path = [[NSBundle mainBundle] pathForResource:@"testmv" ofType:@"mp4"];
//  path = @"http://o9ivu69va.bkt.clouddn.com/testmv.mp4";
  NSURL *fileUrl = [NSURL URLWithString:path];
  NSData *file = [NSData dataWithContentsOfFile:path];
  NSArray *files = @[img,img1];
  NSLog(@"url..%@",fileUrl);
  /*
   fb
   显示：@[text,text,...,img,img...url]
   注意：会忽略text；同时有文本与url时只会分享url
   
   google+ 扩展
   显示：@[text,text,...,img,img,...,url]
   注意：同时有图片与url，url会显示为链接；多个链接或文本之间会隔行
   
   twitter
   显示：@[text,text,...,img,url]
   注意：只能分享一张图；分享时url不会显示，分享后才能见到，放在文本末尾；多个文字链接或文本之间会隔行
   
   instagram 扩展
   显示：@[img]
   注意：分享内容只能包含一张图，否则不会出现在列表上；文本可以放到UIPasteboard粘贴板，提示用户分享时粘贴
   
   vimeo/youtube
   自建UIActivity
   */
  
  
  NSArray *activityItems = @[fileUrl];
  
  
  UIActivityViewController *ac = [[UIActivityViewController alloc] initWithActivityItems:activityItems applicationActivities:@[[ZSCustomActivity new]]];
  ac.excludedActivityTypes = @[UIActivityTypeAirDrop];
  [ac setValue:subject forKey:@"subject"];

  if ([ac respondsToSelector:(@selector(setCompletionWithItemsHandler:))]){
    [ac setCompletionWithItemsHandler:^(NSString *activityType, BOOL completed, NSArray * returnedItems, NSError * activityError) {
      NSLog(@"分享成功啦..");
    }];
  }else{
#pragma GCC diagnostic ignored "-Wdeprecated-declarations"
    [ac setCompletionHandler:^(NSString *activityType, BOOL completed) {
      NSLog(@"分享成功啦..");
    }];
#pragma GCC diagnostic warning "-Wdeprecated-declarations"
  }
  
  dispatch_async(dispatch_get_main_queue(), ^{
    [self presentViewController:ac animated:YES completion:NULL];
  });
}


//UIDocumentInteractionController
- (IBAction)btn1Tap:(id)sender {
  
  
  self.documentController = [UIDocumentInteractionController interactionControllerWithURL:[[NSBundle mainBundle] URLForResource:@"000" withExtension:@"jpg"]];
  
  //options
  self.documentController.UTI = @"com.instagram.photo";
  self.documentController.delegate = self;//预览功能必须
  
  //展示
//  [self.documentController presentPreviewAnimated:YES];//预览
//  [self.documentController presentOpenInMenuFromRect:self.view.bounds inView:self.view animated:YES];//view
  [self.documentController presentOptionsMenuFromRect:self.view.bounds inView:self.view animated:YES];//view+可选操作（包含预览，需要声明为属性否则会提前释放）
  
  
  
}

#pragma mark - < callback >
#pragma mark * UIDocumentInteractionControllerDelegate
//预览功能必须
-(UIViewController *)documentInteractionControllerViewControllerForPreview:(UIDocumentInteractionController *)controller{

  return self;
}
@end
