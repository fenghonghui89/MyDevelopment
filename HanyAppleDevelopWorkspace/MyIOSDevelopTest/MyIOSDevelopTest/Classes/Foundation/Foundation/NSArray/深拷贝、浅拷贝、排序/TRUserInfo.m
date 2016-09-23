//
//  TRUserInfo.m
//  AddressBook(1029)
//
//  Created by apple on 13-10-29.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import "TRUserInfo.h"

@implementation TRUserInfo

-(NSString*)description{
    return [NSString stringWithFormat:@"Name: %@ Email: %@ Telphone: %@",_name,_email,_telphone];
}

+(id)userInfoWithName:(NSString*)name AndEmail:(NSString*)email AndTelphone:(NSString*)telphone{
    return [[TRUserInfo alloc]initWithName:name AndEmail:email AndTelphone:telphone];
}
-(id)initWithName:(NSString*)name AndEmail:(NSString*)email AndTelphone:(NSString*)telphone{
    if (self=[super init]) {
        _name=name; _email=email; _telphone=telphone;
    }return self;
}

-(NSComparisonResult)compareUserInfo:(TRUserInfo*)userInfoC{
    return [_name compare:userInfoC.name];
}

-(void)print{
    NSLog(@"UserName: %@ Email: %@ Telphone: %@",_name,_email,_telphone);
}

@end
