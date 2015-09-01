//
//  TRPoint.m
//  Demo3_DrawPad
//
//  Created by Tarena on 13-11-21.
//  Copyright (c) 2013年 Tarena. All rights reserved.
//

#import "TRPoint.h"

@implementation TRPoint

- (id)initWithCGPoint:(CGPoint)cgPoint
{
    self = [super init];
    if (self) {
        self.x = cgPoint.x;
        self.y = cgPoint.y;
    }
    return self;
}

- (CGPoint)CGPoint
{
    return CGPointMake(self.x, self.y);
}

@end
