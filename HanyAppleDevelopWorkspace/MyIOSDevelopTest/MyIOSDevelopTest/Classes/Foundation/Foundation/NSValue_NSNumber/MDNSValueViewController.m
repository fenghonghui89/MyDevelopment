//
//  MDNSValueViewController.m
//  MyDevelopmentTest
//
//  Created by hanyfeng on 15/3/10.
//  Copyright (c) 2015年 hanyfeng. All rights reserved.
//

#import "MDNSValueViewController.h"

@interface MDNSValueViewController ()

@end

@implementation MDNSValueViewController

- (void)viewDidLoad{
  
  [super viewDidLoad];
  
  
}

#pragma mark - < method > -
#pragma mark NSValue 把结构体转换成对象
-(void)test_NSValue{
  
  //定义结构体
  typedef struct POINT {
    int x;
    int y;
  }Point;
  
  //声明一个结构体变量并给成员赋值
  Point p;
  p.x = 3;
  p.y = 4;
  
  //封装成对象
  NSValue* value = [NSValue valueWithBytes:&p objCType:@encode(Point)];
  
  //解封
  Point newPoint;
  [value getValue:&newPoint];
  NSLog(@"point: x:%d,y:%d",newPoint.x,newPoint.y);
}

#pragma mark NSNumber 把基本数据类型转换成对象
-(void)test_NSNumber{

  int i =18,i1;
  NSNumber* num = [NSNumber numberWithInt:i];
  NSLog(@"num:%@",num);
  i1 = [num intValue];
  NSLog(@"i1:%d",i1);
  
  char c = 'a';
  NSNumber* cha = [[NSNumber alloc]initWithChar:c];
  NSLog(@"cha:%@",cha);
  
  float f = 12.03,f1=0;
  NSNumber* flo = [[NSNumber alloc]initWithFloat:f];
  NSLog(@"flo:%@",flo);
  f1 = [flo floatValue];
  NSLog(@"f1:%f",f1);

}
@end
