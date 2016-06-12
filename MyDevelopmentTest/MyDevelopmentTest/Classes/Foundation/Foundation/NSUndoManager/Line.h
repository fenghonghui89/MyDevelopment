//
//  Line.h
//  MyDevelopmentTest
//
//  Created by 冯鸿辉 on 16/6/12.
//  Copyright © 2016年 hanyfeng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface Line : NSObject
@property(nonatomic,assign)CGPoint begin;
@property(nonatomic,assign)CGPoint end;
@property(nonatomic,strong)UIColor *color;
@end
