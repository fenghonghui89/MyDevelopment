//
//  MDNSArrayNormalViewController.m
//  MyDevelopmentTest
//
//  Created by hanyfeng on 15/3/10.
//  Copyright (c) 2015年 hanyfeng. All rights reserved.
//

#import "MDNSArrayNormalViewController.h"
#import "MD_Model3.h"
@interface MDNSArrayNormalViewController ()

@end

@implementation MDNSArrayNormalViewController

- (void)viewDidLoad{
  [super viewDidLoad];
  
}

#pragma mark NSArray常用方法

-(void)arrayNormal1{
  
  //1.初始化
  //通过一个元素创建一个数组
  //NSArray* array = [NSArray array];//没有元素的数组
  NSArray* array = [NSArray arrayWithObject:@"one"];
  NSLog(@"1.array:%@",array);
  
  //2.通过几个元素创建一个数组
  NSArray* array2 = [NSArray arrayWithObjects:@"one",@"two",@"three",nil];//注意是Objcets，nil是结束标识
  NSLog(@"2.array2:%@ %p",array2,array2);
  
  //3.根据一个数组中的内容，创建新的数组（复制）
  NSArray* array3 = [NSArray arrayWithArray:array2];
  NSLog(@"3.array3:%@ %p",array3,array3);
  
  //4.显示数组中元素的个数
  NSUInteger i = [array2 count];//用int会提示损失精度
  NSLog(@"4.i:%ld",i);
  
  //5.根据数组的下标，访问数组中的元素，下标从0开始
  NSString* str = [array2 objectAtIndex:0];
  NSLog(@"5.str:%@",str);
  
  //6.遍历数组中的元素
  for (int i=0; i<[array2 count]; i++) {
    NSLog(@"6.1 array2[%d]:%@",i,[array2 objectAtIndex:i]);//array[i]也可以
  }
  
  for (NSString* temp in array2) {
    NSLog(@"6.2 array2:%@",temp);
  }
  
  //7.在原来的数组上追加一组对象
  NSArray* array4 = [NSArray arrayWithObjects:@"4",@"5",nil];
  NSArray* array5 = [array2 arrayByAddingObjectsFromArray:array4];//重写了description方法
  NSLog(@"7.array5:%@",array5);
  
  //8.将数组中的元素按指定符号连接起来变为字符串
  NSArray* array6 = [NSArray arrayWithObjects:@"10",@"10",@"10",@"10",nil];
  NSString* str2 = [array6 componentsJoinedByString:@"."];
  NSLog(@"8.str2:%@",str2);
  
  
}

-(void)arrayNormal2{
  
  NSArray* array = [NSArray arrayWithObjects:@"one",@"two",@"three",nil];
  //10.判断数组中是否含有某个对象
  BOOL b = [array containsObject:@"one"];
  NSLog(@"b:%d",b);
  
  //11.得到对象在数组中的下标(如果对象不在数组中，则返回垃圾数值)
  NSUInteger index = [array indexOfObject:@"two"];
  NSLog(@"index:%ld",index);
  
  //12.获取数组最后一个元素
  NSString* strLast = [array lastObject];
  NSLog(@"strLast:%@",strLast);
  
  //13.如果数组中保存的某个对象，给数组中的所有对象都发送一个消息
  //数组中的所有对象必须都拥有该消息，否则会有问题
  //最好先判断对象是否又该方法
  TRStudent* student = [TRStudent new];
  student.age  = 18;
  TRStudent* student2 = [TRStudent new];
  student2.age  = 20;
  NSArray* students = [NSArray arrayWithObjects:student,student2,nil];
  [students makeObjectsPerformSelector:@selector(studentRun)];
}

-(void)arrayNormal3
{
  //char array[] = {'a','b'};//C
  //NSArray* array = [NSArray arrayWithObjects:@"one",@"two",@"three", nil];//OC
  NSArray* array = @[@"one",@"two",@"three"];//IOS 6.0新增
  NSLog(@"array:%@",array);
  NSLog(@"array[0]:%@",[array objectAtIndex:0]);//OC
  NSLog(@"array[0]:%@",array[0]);//IOS 6.0新增
}

#pragma mark NSArray练习：判断ip地址是否正确
-(void)arrayTest1
{
  NSString* strIP = @"192.168.1.99";
  NSString* str = [strIP substringToIndex:10];
  NSString* str1 = @"192.168.1.";
  if ([str caseInsensitiveCompare:str1]==NSOrderedSame) {
    NSArray* arrIP = [strIP componentsSeparatedByString:@"."];
    NSString* str2 = [arrIP objectAtIndex:3];
    int i = [str2 intValue];
    if (i>=2&&i<=100) {
      NSLog(@"可以上网");
    }else{
      NSLog(@"后8位有错，不能上网");
    }
  }else{
    NSLog(@"前24位已经有错，不能上网");
  }
}

#pragma mark NSMutableArray
-(void)array_NSMutableArray
{
  //1.初始化方法（与NSArray一样）
  //NSMutableArray* array1 = [NSMutableArray arrayWithObject:@"one"];
  //NSMutableArray* array1 = [NSMutableArray arrayWithObjects:@"one",@"two",@"three", nil];
  NSMutableArray* array1 = [NSMutableArray arrayWithObjects:@"1",@"2", nil];
  NSLog(@"array1:%@",array1);
  
  
  //2.向数组中添加一个元素
  NSMutableArray* array2 = [NSMutableArray arrayWithObjects:@"one",@"two",@"three", nil];
  [array2 addObject:@"four"];
  NSLog(@"array2:%@",array2);
  
  //3.将数组B中的每一个元素做为一个元素添加到数组A中
  NSMutableArray* array3 = [NSMutableArray arrayWithObjects:@"one",@"two",@"three", nil];
  NSMutableArray* array3_1 = [NSMutableArray arrayWithObjects:@"1",@"2", nil];
  [array3 addObjectsFromArray:array3_1];
  NSLog(@"array3:%@",array3);
  
  //4.将数组B做为一个元素添加到数组A
  NSMutableArray* array4 = [NSMutableArray arrayWithObjects:@"one",@"two",@"three", nil];
  NSMutableArray* array4_1 = [NSMutableArray arrayWithObjects:@"1",@"2", nil];
  [array4 addObject:array4_1];
  NSLog(@"array4:%@",array4);
  
  //5.向数组中指定的下标插入元素
  NSMutableArray* array5 = [NSMutableArray arrayWithObjects:@"one",@"two",@"three", nil];
  [array5 insertObject:@"3" atIndex:2];
  NSLog(@"array5:%@",array5);
  
  //6.移除数组中最后一个元素
  NSMutableArray* array6 = [NSMutableArray arrayWithObjects:@"one",@"two",@"three", nil];
  [array6 removeLastObject];
  NSLog(@"array6:%@",array6);
  
  //7.移除指定下标对象
  NSMutableArray* array7 = [NSMutableArray arrayWithObjects:@"one",@"two",@"three", nil];
  [array7 removeObjectAtIndex:1];
  NSLog(@"array7:%@",array7);
  
  //8.替换指定下标的元素(参数：要替换的元素的下标、替换的元素)
  NSMutableArray* array8 = [NSMutableArray arrayWithObjects:@"one",@"two",@"three", nil];
  [array8 replaceObjectAtIndex:2 withObject:@"2"];
  NSLog(@"array8:%@",array8);
  
  //9.移除数组中所有元素
  NSMutableArray* array9 = [NSMutableArray arrayWithObjects:@"one",@"two",@"three", nil];
  [array9 removeAllObjects];
  NSLog(@"array9:%@",array9);
}
@end
