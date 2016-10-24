//
//  MDModel_Category+MyCategory.m
//  HanyOCLanguageDemo
//
//  Created by 冯鸿辉 on 16/7/5.
//  Copyright © 2016年 MD. All rights reserved.
//

#import "MDModel_Category+MyCategory.h"
#import <objc/runtime.h>
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
@end
