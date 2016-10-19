//
//  MD_Model2.h
//  MyIOSDevelopTest
//
//  Created by 冯鸿辉 on 2016/10/18.
//  Copyright © 2016年 hanyfeng. All rights reserved.
/*
 KVO TableView
 */

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


@class MDStudent;
@interface MDBag : NSObject
@property(nonatomic,weak)MDStudent *student;
@property(nonatomic,assign)NSInteger model;
@property(nonatomic,copy)NSString *brand;
@end


@class MDBag;
@interface MDStudent : NSObject
@property(nonatomic,assign)NSInteger age;
@property(nonatomic,copy)NSString *name;
@property(nonatomic,strong)MDBag *bag;
@end



@interface MDImageItem : NSObject
@property(nonatomic,copy)NSString *imageName;
@property(nonatomic,copy)NSString *imageUrl;
@property(nonatomic,strong)UIImage *image;
-(id)initWithDic:(NSDictionary *)dic;
+(NSMutableArray *)handleData:(NSData *)data;
@end
