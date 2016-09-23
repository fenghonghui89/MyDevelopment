//
//  MDSubclassUIControl.m
//  MyDevelopmentTest
//
//  Created by 冯鸿辉 on 16/5/18.
//  Copyright © 2016年 hanyfeng. All rights reserved.
//

#import "MDSubclassUIControl.h"

@interface MDSubclassUIControl()
@property(nonatomic,copy)NSString *tagstr;
@end
@implementation MDSubclassUIControl

-(instancetype)initWithFrame:(CGRect)frame{

  self = [super initWithFrame:frame];
  if (self) {
//    self.backgroundColor = [UIColor redColor];
  }
  return self;
}

//-(void)setHighlighted:(BOOL)highlighted{
//
//  [super setHighlighted:highlighted];
//  
//  if (highlighted == YES) {
//    self.alpha = 0.5;
//  }else{
//    self.alpha = 1;
//  }
//}

-(void)drawRect:(CGRect)rect{
  
  NSLog(@"drawRect~%@",self.tagstr);
  
//  CGContextRef context = UIGraphicsGetCurrentContext();
//  CGContextSaveGState(context);
//  
//  [[UIColor orangeColor] setFill];
  
  [self.img drawInRect:self.bounds];
  
//  CGContextRestoreGState(context);
}

-(BOOL)beginTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event{
  
  NSLog(@"beginTrackingWithTouch~");
  self.tagstr = @"begin~~~";
  [super beginTrackingWithTouch:touch withEvent:event];
  self.img = [UIImage imageNamed:@"000.jpg"];
  [self setNeedsDisplay];
  
  return YES;
}

-(void)endTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event{
  
  NSLog(@"endTrackingWithTouch~");
  self.tagstr = @"end~~~";
  [super endTrackingWithTouch:touch withEvent:event];
  self.img = [UIImage imageNamed:@"1111.jpg"];
  [self setNeedsDisplay];
}
@end
