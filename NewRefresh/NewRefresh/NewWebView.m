//
//  NewWebView.m
//  NewRefresh
//
//  Created by 冯鸿辉 on 16/3/10.
//  Copyright © 2016年 DGC. All rights reserved.
//

#import "NewWebView.h"

@implementation NewWebView

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
  [super touchesBegan:touches withEvent:event];
  NSLog(@"~touchesBegan");
}

-(void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
  [super touchesMoved:touches withEvent:event];
  NSLog(@"~touchesMoved");
}

-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
  [super touchesEnded:touches withEvent:event];
  NSLog(@"~touchesEnded");
}

@end
