//
//  XTJNavigationBar1.m
//  XTJMall
//
//  Created by hanyfeng on 2017/6/12.
//  Copyright © 2017年 hanyfeng. All rights reserved.
//

#import "XTJNavigationItem_Main.h"


@interface XTJNavigationItem_Main ()

@end
@implementation XTJNavigationItem_Main
-(CGSize)intrinsicContentSize{
    return UILayoutFittingExpandedSize;
}

#pragma mark - < view lifecycle >
-(void)awakeFromNib{
    
    [super awakeFromNib];
    [self customInitUI];
}

-(void)customInitUI{
    self.left0Btn.hidden = NO;
    self.right0Btn.hidden = NO;
    self.right1Btn.hidden = YES;
    self.right2Btn.hidden = YES;
    self.lineView.hidden = YES;
    
    [self.left0Btn setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 40)];
    [self.left0Btn setImage:[[XTJTool sharedInstance] imageFile:@"Arrow/arrows_back"] forState:UIControlStateNormal];
    
    [self.right0Btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.right0Btn.titleLabel setFont:[UIFont systemFontOfSize:15]];
    [self.right0Btn setImage:[[XTJTool sharedInstance] imageFile:@"NavigationBar/选择"] forState:UIControlStateNormal];
    
    [self.right1Btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.right1Btn.titleLabel setFont:[UIFont systemFontOfSize:15]];
    
    [self.right2Btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.right2Btn.titleLabel setFont:[UIFont systemFontOfSize:15]];
}
#pragma mark - < set / get >

-(void)setTitle:(NSString *)title{
    
    _title = title;
    
    self.titleLabel.text = title;
}

#pragma mark - < target-action >



- (IBAction)leftBtn0Tap:(id)sender {
    !self.leftBarButton0Handler ?: self.leftBarButton0Handler();
}



-(IBAction)right0BtnTap:(id)sender{

    
}

-(IBAction)right1BtnTap:(id)sender{
    !self.rightBarButton1Handler ?: self.rightBarButton1Handler();
}


- (IBAction)right2BtnTap:(id)sender {
    
}





@end
