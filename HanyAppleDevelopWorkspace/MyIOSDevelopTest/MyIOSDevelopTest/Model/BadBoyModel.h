//
//  BadBoyModel.h
//  MyIOSDevelopTest
//
//  Created by 冯鸿辉 on 2016/10/20.
//  Copyright © 2016年 hanyfeng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BadBoyModel : NSObject
@property(nonatomic,copy)NSString *name;
@property(nonatomic,assign)NSInteger age;
-(void)displayCurrentModleProperty;
-(instancetype)initWithDictionary:(NSDictionary *)data;
@end
