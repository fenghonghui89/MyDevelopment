//
//  MD_Touch_Point.h
//  MyDevelopmentTest
//
//  Created by hanyfeng on 15/9/15.
//  Copyright (c) 2015年 hanyfeng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MD_Touch_Point : NSObject
@property(nonatomic,assign)CGPoint point;
-(MD_Touch_Point *)initWithPoint:(CGPoint)point;
-(CGPoint)cgpoint;
@end
