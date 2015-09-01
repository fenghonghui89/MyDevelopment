//
//  TRPoint.h
//  my04
//
//  Created by HanyFeng on 13-11-23.
//  Copyright (c) 2013年 Hany. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TRPoint : NSObject
@property(nonatomic,assign)CGFloat x;
@property(nonatomic,assign)CGFloat y;
-(id)initWithCGPoint:(CGPoint)CGPoint;//把cgpoint类型转换为TRPoint类型
-(CGPoint)cgpoint;//把TRPoint类型转换为CGPoint
@end
