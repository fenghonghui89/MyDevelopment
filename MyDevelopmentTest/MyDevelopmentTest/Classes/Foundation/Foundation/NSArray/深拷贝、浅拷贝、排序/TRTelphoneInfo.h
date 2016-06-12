//
//  TRTelphoneInfo.h
//  AddressBook(1029)
//
//  Created by apple on 13-10-29.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TRUserInfo.h"
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
