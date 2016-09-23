//
//  TRUserInfo.h
//  AddressBook(1029)
//
//  Created by apple on 13-10-29.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TRUserInfo : NSObject

@property(nonatomic,copy)NSString* name;
@property(nonatomic,copy)NSString* email;
@property(nonatomic,copy)NSString* telphone;

+(id)userInfoWithName:(NSString*)name AndEmail:(NSString*)email AndTelphone:(NSString*)telphone;
-(id)initWithName:(NSString*)name AndEmail:(NSString*)email AndTelphone:(NSString*)telphone;
-(NSComparisonResult)compareUserInfo:(NSString*)userInfoC;
-(void)print;

@end
