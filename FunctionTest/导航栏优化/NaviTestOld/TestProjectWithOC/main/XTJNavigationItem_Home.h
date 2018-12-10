//
//  XTJNavigationItem_Home.h
//  XTJMall
//
//  Created by hanyfeng on 2018/5/17.
//  Copyright © 2018年 hanyfeng. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface XTJNavigationItem_Home : UIView


@property(nonatomic,copy)dispatch_block_t rightBarButton0Handler;
@property (weak, nonatomic) IBOutlet UIImageView *messageImageView;

@property(nonatomic,copy)dispatch_block_t leftBarButton0Handler;
@property (weak, nonatomic) IBOutlet UIImageView *qrcodeImageView;

@property (weak, nonatomic) IBOutlet UIImageView *cameraImageView;
@property (weak, nonatomic) IBOutlet UIView *textField_bgView_home;
@property (weak, nonatomic) IBOutlet UIImageView *searchIconImageView;
@property(nonatomic,copy)dispatch_block_t centerBarButtonHandler;
@property(nonatomic,copy)dispatch_block_t camera_tapHandler;
@property (weak, nonatomic) IBOutlet UILabel *label_keyword;
@end
