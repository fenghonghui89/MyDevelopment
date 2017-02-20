//
//  MDModel_Category+MyCategory.m
//  HanyOCLanguageDemo
//
//  Created by 冯鸿辉 on 16/7/5.
//  Copyright © 2016年 MD. All rights reserved.
//

#import "MDModel_Category+MyCategory.h"
#import <objc/runtime.h>

//通过扩展 调用原始类中的私有属性或方法 step1
@interface MDModel_Category ()
@property(nonatomic,strong)NSString *age;
-(void)introduceMyself;
@end

static const void *tag_city = &tag_city;

@implementation MDModel_Category (MyCategory)

//添加方法
-(void)sayGoodBye{
  
  NSLog(@"bye~");
}


//添加属性
-(void)setCity:(NSString *)city{

  objc_setAssociatedObject(self, tag_city, city, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

-(NSString *)city{

  return objc_getAssociatedObject(self, tag_city);
}


//替换方法
//看MyIOSDevelpTest - runtime


//通过扩展 调用原始类中的私有属性或方法 step2
-(void)introduce{
  
  self.name = @"Hany";//公开属性
  self.age = @"13";//私有属性
  [self introduceMyself];//私有方法
}


@end
