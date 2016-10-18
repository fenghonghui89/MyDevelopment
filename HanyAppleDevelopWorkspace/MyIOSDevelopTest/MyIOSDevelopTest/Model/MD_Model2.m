//
//  MD_Model2.m
//  MyIOSDevelopTest
//
//  Created by 冯鸿辉 on 2016/10/18.
//  Copyright © 2016年 hanyfeng. All rights reserved.
//

#import "MD_Model2.h"




#pragma mark - ******************** TRStudent6 ********************
@implementation TRStudent6

-(id)copyWithZone:(NSZone*)zone{//2.深拷贝：重写copyWithZone方法
  return [[TRStudent6 alloc] initwithName:self.name AndAge:self.age];
}

-(NSString *)description{
  return [NSString stringWithFormat:@"name:%@ age:%d",self.name,self.age];
}

+(id)studentInitWithName:(NSString*)name AndAge:(int)age{
  TRStudent6* student = [[TRStudent6 alloc] initwithName:name AndAge:age];
  return student;
}
-(id)initwithName:(NSString*)name AndAge:(int)age{
  if (self == [super init]) {
    self.name = name;
    self.age = age;
  }
  return self;
}

//按照姓名排序
-(NSComparisonResult)compareStudentWithName:(TRStudent6*)student{
  return [self.name compare:student.name];//只能用于字符串比较，默认升序，暂时未知如何降序
}

//按照年龄排序(该方法更直观，如果要逆向输出，可以加负号或者大(小)于改为小(大)于)
-(NSComparisonResult)compareStudentWithAge:(TRStudent6*)student{
  if (self.age<student.age) {//大小写只能用于数字比较，不能用于字符串比较
    return NSOrderedAscending;
  }else if(self.age>student.age) {
    return NSOrderedDescending;
  }
  
  return NSOrderedDescending;
}

//年龄一样的情况下，按照姓名排序
-(NSComparisonResult)compareStudentWithSameAge:(TRStudent6*)student{
  if (self.age<student.age) {
    return NSOrderedAscending;
  }else if(self.age>student.age) {
    return NSOrderedDescending;
  }else if(self.age==student.age){
    return [self.name compare:student.name];
  }
  
  return NSOrderedDescending;
}
@end

#pragma mark - ******************** TRUserInfo ********************
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

#pragma mark - ******************** TRTelphoneInfo ********************
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

