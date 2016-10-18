//
//  MD_Model2.h
//  MyIOSDevelopTest
//
//  Created by 冯鸿辉 on 2016/10/18.
//  Copyright © 2016年 hanyfeng. All rights reserved.
/*
 NSObject  NSString
 深拷贝浅拷贝 排序
 */

#import <Foundation/Foundation.h>





@interface TRStudent6 : NSObject <NSCopying>//1.深拷贝：先遵守NSCopying协议

@property(nonatomic,copy)NSString* name;
@property(nonatomic,assign)int age;

+(id)studentInitWithName:(NSString*)name AndAge:(int)age;
-(id)initwithName:(NSString*)name AndAge:(int)age;

-(NSComparisonResult)compareStudentWithName:(TRStudent6*)student;
-(NSComparisonResult)compareStudentWithAge:(TRStudent6*)student;
-(NSComparisonResult)compareStudentWithSameAge:(TRStudent6*)student;
@end



@interface TRUserInfo : NSObject

@property(nonatomic,copy)NSString* name;
@property(nonatomic,copy)NSString* email;
@property(nonatomic,copy)NSString* telphone;

+(id)userInfoWithName:(NSString*)name AndEmail:(NSString*)email AndTelphone:(NSString*)telphone;
-(id)initWithName:(NSString*)name AndEmail:(NSString*)email AndTelphone:(NSString*)telphone;
-(NSComparisonResult)compareUserInfo:(NSString*)userInfoC;
-(void)print;

@end


@interface TRTelphoneInfo : NSObject

//@property(nonatomic,copy)NSString* telpName;
@property(nonatomic)NSMutableArray* telphoneInfo;

+(id)telpInfoWithUser:(TRUserInfo*)userinfo;
-(id)initInfoWithUser:(TRUserInfo *)userinfo;
-(void)addUserInfo:(TRUserInfo*)userInfoA;
-(void)removeUserInfo:(NSString*)removeName;
-(void)lookupUserName:(NSString*)searchName;
-(void)TelpInfoList;
-(void)sort;

@end
