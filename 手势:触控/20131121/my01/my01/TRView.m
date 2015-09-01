//
//  TRView.m
//  my01
//
//  Created by HanyFeng on 13-11-21.
//  Copyright (c) 2013年 Hany. All rights reserved.
//

#import "TRView.h"

@implementation TRView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

//Began
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    NSLog(@"began %d",[touches count]);
    for (UITouch* touch in touches) {//取出位置
        CGPoint location = [touch locationInView:self.superview];//位置的坐标（相对于指定视图坐标系的）
        NSLog(@"began: %.2f %.2f",location.x,location.y);
    }
}

//Moved
-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    NSLog(@"moved %d",[touches count]);
    for (UITouch* touch in touches) {
        CGPoint location = [touch locationInView:self];
        NSLog(@"moved: %.2f %.2f",location.x,location.y);
    }
    
}

//Ended
-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    NSLog(@"ended %d",[touches count]);
    for (UITouch* touch in touches) {
        CGPoint location = [touch locationInView:self];
        NSLog(@"ended: %.2f %.2f",location.x,location.y);
    }
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
