//
//  TRPoint.m
//  my01
//
//  Created by apple on 13-10-30.
//  Copyright (c) 2013年 Hany. All rights reserved.
//

#import "TRPoint.h"
#import "MDTool.h"
#import "MDDefine.h"
@implementation TRPoint

//-(NSString*)description
//{
//    return [NSString stringWithFormat:@"x:%d,y:%d",self.x,self.y];
//}


#pragma mark - ************** override **************
#pragma mark - < runtime > -
+(void)initialize{
  
  DRLog(@"%@ initialize",[self class]);
}

-(instancetype)init{
  
  self = [super init];
  if (self) {
    DRLog(@"%@ init",[self class]);
  }
  return self;
}
#pragma mark - < NSSet 唯一性 >
-(NSUInteger)hash//1.重写hash方法，使对象的hash值相同
{
    NSLog(@"执行TRPoint的hash方法%@",self);
    return self.x+self.y;
}

-(BOOL)isEqual:(id)object//2.hash一样则用isEqual比较对象的类型关系和实例变量是否一样
{
    NSLog(@"执行了TRPoint的isEqual方法%@",self);
    if ([object isKindOfClass:[TRPoint class]]) {//2.1先比较对象的类型关系
        TRPoint* tempPoint = object;//2.2再比较对象的实例变量的关系
        if (self.x == tempPoint.x){
            if (self.y == tempPoint.y) {
                return YES;
            }else {
                return NO;
            }
        }else {
            return NO;
        }
    }else{
        return NO;
    }
}
@end
