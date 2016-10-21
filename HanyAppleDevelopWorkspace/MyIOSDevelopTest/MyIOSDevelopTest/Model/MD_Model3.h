//
//  MD_Model3.h
//  MyIOSDevelopTest
//
//  Created by 冯鸿辉 on 2016/10/18.
//  Copyright © 2016年 hanyfeng. All rights reserved.
/*
 归档反归档 NSObject NSXML
 NSArray NSDictionary NSSet NSEnumerator
 */

#import <Foundation/Foundation.h>
#import "YYModel.h"

@protocol TRStudy <NSObject>
@required -(void)studentStudy;
@end



@interface TRStudent : NSObject<NSCoding,NSCopying,TRStudy>
@property(nonatomic,copy)NSString *name;
@property(nonatomic,assign)NSInteger age;
+(TRStudent *)studentWithName:(NSString *)name age:(NSInteger)age;
-(instancetype)initWithName:(NSString *)name age:(NSInteger)age;

-(NSComparisonResult)compareStudentWithName:(TRStudent*)student;
-(NSComparisonResult)compareStudentWithAge:(TRStudent*)student;
-(NSComparisonResult)compareStudentWithSameAge:(TRStudent*)student;

-(void)studentRun;
@end




@interface TRBook : NSObject<NSCoding>
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *author;
@property (nonatomic, strong) NSString *price;
@property (nonatomic, assign) NSInteger page;
-(instancetype)initWithName:(NSString *)name author:(NSString *)author price:(NSString *)price page:(NSInteger)page;
@end



@interface TRSchool : NSObject<NSCoding>
@property(nonatomic,copy)NSString *schoolName;
@property(nonatomic,assign)NSInteger schoolCode;
-(instancetype)initWithSchoolName:(NSString *)schoolName schoolCode:(NSInteger)schoolCode;
@end



@interface TRMidStudent : TRStudent
@property(nonatomic,strong)TRSchool *school;
@property(nonatomic,strong)NSArray *books;
+(NSArray *)testData;
@end

