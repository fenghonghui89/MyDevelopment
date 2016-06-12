//
//  TRTelphoneInfo.m
//  AddressBook(1029)
//
//  Created by apple on 13-10-29.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import "TRTelphoneInfo.h"

@implementation TRTelphoneInfo

+(id)telpInfoWithUser:(TRUserInfo *)userinfo{
    return [[TRTelphoneInfo alloc]initInfoWithUser:userinfo];
}
-(id)initInfoWithUser:(TRUserInfo *)userinfo{
    if (self=[super init]) {
        _telphoneInfo=[[NSMutableArray alloc]initWithObjects:userinfo, nil];
    }
    return self;
}

-(void)addUserInfo:(TRUserInfo*)userInfoA{
    [_telphoneInfo addObject:userInfoA];
}

-(void)removeUserInfo:(NSString *)removeName{
    int i,count;
    TRUserInfo* temUserInfo;
    do{
        i=0;
        count=0;
        for (TRUserInfo* userInfo in _telphoneInfo) {
            if ([userInfo.name isEqualToString:removeName]) {
                temUserInfo=userInfo;count++;i++;
            }
        }//通过快速枚举遍历(for)的过程中,不能使用remove方法删除数组元素,会报错
        if (count)
        {[_telphoneInfo removeObject:temUserInfo];count--;NSLog(@"The user has been deleted!");}
    }while (count>0);
    if(!i)
        NSLog(@"Sorry, can not find the name you wanna remove!");
}

-(void)lookupUserName:(NSString*)searchName{
    int i=0;
    for (TRUserInfo* userInfo in _telphoneInfo) {
        if ([userInfo.name isEqualToString:searchName]) {
            NSLog(@"The User Searching is Name: %@ Email: %@ Telphone: %@",userInfo.name,userInfo.email,userInfo.telphone);
            i++;
        }
    }
    if (!i)
        NSLog(@"Sorry, can not find the name you search!");
}
-(void)TelpInfoList{
    NSEnumerator* lUserInfo=[_telphoneInfo objectEnumerator];
    id usInfo;
    while (usInfo=[lUserInfo nextObject]) {
        TRUserInfo* temUser=usInfo;
        NSLog(@"User Name: %@ Email: %@ Telphone: %@",temUser.name,temUser.email,
              temUser.telphone);
    }
}

-(void)sort{
    NSArray* sortArray=[_telphoneInfo sortedArrayUsingSelector:@selector(compareUserInfo:)];
    /*对数组的排序,不管是可变数组还是不可变数组,排序完都需要新建一个数组存放排序后的元素,对于原数组是不因排序而受影响的,维持原来的顺序*/
    NSLog(@"After Sorted: %@",sortArray);
}

@end
