//
//  MDStudent.h
//  MyDevelopmentTest
//
//  Created by 冯鸿辉 on 16/1/29.
//  Copyright © 2016年 hanyfeng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MDBag.h"
@class MDBag;
@interface MDStudent : NSObject
@property(nonatomic,assign)NSInteger age;
@property(nonatomic,copy)NSString *name;
@property(nonatomic,strong)MDBag *bag;
@end
