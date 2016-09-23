//
//  Student1.h
//  MyDevelopmentTest
//
//  Created by hanyfeng on 15/5/21.
//  Copyright (c) 2015年 hanyfeng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Student1 : NSObject
//从IOS 5.0开始，可以不声明实例变量（系统自动声明带_的实例变量）
//{
//    int _age;
//    char _sex;
//    NSString *_str;
//}

//属性
@property int age;
@property char sex;
@property(nonatomic,copy) NSString *name;


-(void)say;
@end
