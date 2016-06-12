//
//  ColorPiker.m
//  MyDevelopmentTest
//
//  Created by 冯鸿辉 on 16/6/12.
//  Copyright © 2016年 hanyfeng. All rights reserved.
//

#import "ColorPiker.h"

@implementation ColorPiker

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
  
  if (self.delegate && [self.delegate respondsToSelector:@selector(aColorPikerIsSelected:)]) {
    [self.delegate aColorPikerIsSelected:[self backgroundColor]];
  }
  
  self.layer.borderColor = [[UIColor redColor] CGColor];
  self.layer.borderWidth = 1.5f;
}

@end
