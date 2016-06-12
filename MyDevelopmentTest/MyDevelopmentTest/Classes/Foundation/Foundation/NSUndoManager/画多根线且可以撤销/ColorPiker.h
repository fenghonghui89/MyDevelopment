//
//  ColorPiker.h
//  MyDevelopmentTest
//
//  Created by 冯鸿辉 on 16/6/12.
//  Copyright © 2016年 hanyfeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ColorPikerDelegate<NSObject>
@optional
-(void)aColorPikerIsSelected:(UIColor *)color;
@end

@interface ColorPiker : UIView
@property(nonatomic,weak)id<ColorPikerDelegate> delegate;
@end
