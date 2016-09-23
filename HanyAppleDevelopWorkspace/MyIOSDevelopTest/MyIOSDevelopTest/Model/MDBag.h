//
//  MDBag.h
//  MyDevelopmentTest
//
//  Created by 冯鸿辉 on 16/1/29.
//  Copyright © 2016年 hanyfeng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MDStudent.h"
@class MDStudent;
@interface MDBag : NSObject
@property(nonatomic,weak)MDStudent *student;
@property(nonatomic,assign)NSInteger model;
@property(nonatomic,copy)NSString *brand;
@end
