//
//  MDMouse.m
//  MyDevelopmentTest
//
//  Created by 冯鸿辉 on 16/4/11.
//  Copyright © 2016年 hanyfeng. All rights reserved.
//

#import "MDMouse.h"
@interface MDMouse()

@end
@implementation MDMouse

#pragma mark - < view lifecycle > -
-(instancetype)initWithFrame:(CGRect)frame{

  self = [super initWithFrame:frame];
  if (self) {
    [self setBackgroundColor:[UIColor blackColor]];
    [self setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    [self addTarget:self action:@selector(clickTheMouse) forControlEvents:UIControlEventTouchUpInside];
    
    [NSThread detachNewThreadSelector:@selector(countDownAction) toTarget:self withObject:nil];
  }
  return self;
}

#pragma mark - < method > -

-(void)countDownAction{

  for (int i = 3; i>0; i--) {
    
    //不能放在这里，因为此时地鼠只是创建出来，并未回到主线程加入到界面中，放在这里后面的数字就不会显示
//    if (!self.superview) {
//      return;
//    }

    [self performSelectorOnMainThread:@selector(updateUI:) withObject:[NSNumber numberWithInteger:i] waitUntilDone:NO];
    [NSThread sleepForTimeInterval:1];
   
    if (!self.superview) {
      return;
    }
  }
  
  //没有必要回到主线程 因为子线程会立即结束 会及时调用渲染界面的方法
  [self removeFromSuperview];

}

-(void)updateUI:(NSNumber *)number{
  
  NSString *title = [NSString stringWithFormat:@"%ld",(long)[number integerValue]];
  [self setTitle:title forState:UIControlStateNormal];
  
}

#pragma mark - < action > -
-(void)clickTheMouse{
  
  [self removeFromSuperview];

}
@end
