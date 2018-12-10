//
//  XTJNavigationItem_Home.m
//  XTJMall
//
//  Created by hanyfeng on 2018/5/17.
//  Copyright © 2018年 hanyfeng. All rights reserved.
//

#import "XTJNavigationItem_Home.h"
#import "XTJRootDefine.h"
@interface XTJNavigationItem_Home()
@end
@implementation XTJNavigationItem_Home

-(CGSize)intrinsicContentSize{
    return UILayoutFittingExpandedSize;
}

#pragma mark - < lifecycle >
-(void)dealloc{
    ULog(@"首页导航栏dealloc...");
}

-(void)awakeFromNib{
    [super awakeFromNib];
    [self customInitUI];
}

#pragma mark - < init >
-(void)customInitUI{
    
    self.backgroundColor = [UIColor clearColor];
    
    [self.textField_bgView_home configWithCornerRadius:self.textField_bgView_home.height*0.5 borderWidth:0 borderColor:nil];
    self.textField_bgView_home.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.6];
    
    self.searchIconImageView.image = [[XTJTool sharedInstance] imageFile:@"NavigationBar/搜索"];
    self.cameraImageView.image = [[XTJTool sharedInstance] imageFile:@"NavigationBar/相机"];
    
    self.qrcodeImageView.image = [[XTJTool sharedInstance] imageFile:@"NavigationBar/扫一扫"];
    
    self.messageImageView.image = [[XTJTool sharedInstance] imageFile:@"Page/Message/消息"];
}

#pragma mark - < action >

- (IBAction)leftBtn0Tap:(id)sender {
    !self.leftBarButton0Handler ?: self.leftBarButton0Handler();
}

-(IBAction)right0BtnTap:(id)sender{
    
    !self.rightBarButton0Handler ?: self.rightBarButton0Handler();
}

- (IBAction)cameraBtnTap:(id)sender {
    !self.camera_tapHandler?:self.camera_tapHandler();
}

- (IBAction)centerBtnTap:(id)sender {
    !self.centerBarButtonHandler ?: self.centerBarButtonHandler();
}



@end
