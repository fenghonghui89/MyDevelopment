//
//  MDModel_Category.m
//  HanyOCLanguageDemo
//
//  Created by 冯鸿辉 on 16/7/5.
//  Copyright © 2016年 MD. All rights reserved.
//

#import "MDModel_Category.h"

@interface MDModel_Category ()
@property(nonatomic,strong)NSString *age;
@end

@implementation MDModel_Category

//公开方法
-(void)sayHello{

  NSLog(@"hello~");
}

//私有方法
-(void)introduceMyself{
  
  NSLog(@"I am %@ %@",self.name,self.age);
}
@end
