//
//  TRPoint.m
//  my04
//
//  Created by HanyFeng on 13-11-23.
//  Copyright (c) 2013年 Hany. All rights reserved.
//

#import "TRPoint.h"

@implementation TRPoint

-(id)initWithCGPoint:(CGPoint)CGPoint
{
    self = [super init];
    if (self) {
        self.x = CGPoint.x;
        self.y = CGPoint.y;
    }
    return self;
}

-(CGPoint)cgpoint
{
    return CGPointMake(self.x, self.y);
}

@end
