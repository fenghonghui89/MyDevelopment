//
//  TRDrawLine.h
//  View_DrawCurve(1122)
//
//  Created by apple on 13-11-22.
//  Copyright (c) 2013年 Tarena. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TRDrawLine : NSObject

@property(nonatomic,strong)NSMutableArray* curvePoints;

@property(nonatomic)CGFloat lineWidth;

@property(nonatomic)UIColor* lineColor;

@end
