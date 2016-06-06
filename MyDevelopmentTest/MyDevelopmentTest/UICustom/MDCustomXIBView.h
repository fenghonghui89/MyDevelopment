//
//  MDCustomView.h
//  MyDevelopmentTest
//
//  Created by 冯鸿辉 on 16/6/6.
//  Copyright © 2016年 hanyfeng. All rights reserved.
//xib可自定义 可调整的属性
/*
 在viewDidAppeare添加才显示 在viewDidLoad添加不显示
 */
#import <UIKit/UIKit.h>

@interface MDCustomXIBView : UIView
@property (nonatomic, assign)IBInspectable CGFloat cornerRadius;
@property (nonatomic, assign)IBInspectable CGFloat bwidth;
@property (nonatomic, assign)IBInspectable UIColor *bcolor;
@end
