//
//  TRView.m
//  Demo1_Touch
//
//  Created by Tarena on 13-11-21.
//  Copyright (c) 2013年 Tarena. All rights reserved.
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

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

- (void)touchesBegan:(NSSet *)touches
           withEvent:(UIEvent *)event
{
    NSLog(@"began %d", [touches count]);
    for (UITouch * touch in touches) {
        CGPoint location = [touch locationInView:self];
        NSLog(@"began: %.2f, %.2f", location.x, location.y);
    }
}

- (void)touchesMoved:(NSSet *)touches
           withEvent:(UIEvent *)event
{
    NSLog(@"moved %d", [touches count]);
    for (UITouch * touch in touches) {
        CGPoint location = [touch locationInView:self];
        NSLog(@"moved: %.2f, %.2f", location.x, location.y);
    }
}

- (void)touchesEnded:(NSSet *)touches
           withEvent:(UIEvent *)event
{
    
}

@end
