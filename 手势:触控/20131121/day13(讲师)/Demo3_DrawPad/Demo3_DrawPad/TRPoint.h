//
//  TRPoint.h
//  Demo3_DrawPad
//
//  Created by Tarena on 13-11-21.
//  Copyright (c) 2013年 Tarena. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TRPoint : NSObject

@property (nonatomic) CGFloat x;
@property (nonatomic) CGFloat y;

- (id)initWithCGPoint:(CGPoint)cgPoint;
- (CGPoint)CGPoint;

@end
