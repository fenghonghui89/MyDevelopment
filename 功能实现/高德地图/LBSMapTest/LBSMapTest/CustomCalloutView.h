//
//  CustomCalloutView.h
//  LBSMapTest
//
//  Created by 冯鸿辉 on 16/3/22.
//  Copyright © 2016年 DGC. All rights reserved.
//自定义标注气泡

#import <UIKit/UIKit.h>

@interface CustomCalloutView : UIView
@property (nonatomic, strong) UIImage *image; //商户图
@property (nonatomic, copy) NSString *title; //商户名
@property (nonatomic, copy) NSString *subtitle; //地址
@end
