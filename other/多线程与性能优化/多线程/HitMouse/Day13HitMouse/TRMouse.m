//
//  TRMouse.m
//  Day13HitMouse
//
//  Created by Tarena on 13-12-18.
//  Copyright (c) 2013年 Tarena. All rights reserved.
//

#import "TRMouse.h"

@implementation TRMouse

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor redColor];
        [self addTarget:self action:@selector(clickedMouseAction) forControlEvents:UIControlEventTouchUpInside];//点击事件——打掉地鼠
        [NSThread detachNewThreadSelector:@selector(countDownAction) toTarget:self withObject:Nil];//在子线程中实现3秒后消失
    }
    return self;
}

//点击事件——打掉地鼠
-(void)clickedMouseAction{
    [self removeFromSuperview];
    int successCount = [self.delegate.successCountLabel.text intValue] +1;
    self.delegate.successCountLabel.text = [NSString stringWithFormat:@"%d",successCount];
}

//在子线程中实现3秒后消失
-(void)countDownAction{
    for (int i=3; i>0; i--) {
        
        //不能放在这里，因为此时地鼠只是创建出来，并未回到主线程加入到界面中
        //        if (!self.superview) {
        //            return;
        //        }
        
        [self performSelectorOnMainThread:@selector(updateUI:) withObject:[NSNumber numberWithInt:i] waitUntilDone:NO];//回到主线程，地鼠身上显示时间
        [NSThread sleepForTimeInterval:1];
        
        //0.5s后，判断地鼠是否被点击掉了，如果不在则结束子线程方法
        if (!self.superview) {
            return;
        }
    }
    
    //没有必要回到主线程 因为子线程会立即结束 会及时调用渲染界面的方法
    [self removeFromSuperview];
    
    //老鼠时间到之后 界面失败数量加1
    int failCount = [self.delegate.failCountLabel.text intValue] +1;
    self.delegate.failCountLabel.text = [NSString stringWithFormat:@"%d",failCount];
}

//回到主线程，地鼠身上显示时间
-(void)updateUI:(NSNumber *)number{
    [self setTitle:[NSString stringWithFormat:@"%d",[number intValue]] forState:UIControlStateNormal];
}

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect
 {
 // Drawing code
 }
 */

@end
