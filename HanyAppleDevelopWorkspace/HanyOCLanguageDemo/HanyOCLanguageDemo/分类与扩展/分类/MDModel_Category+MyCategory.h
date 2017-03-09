//
//  MDModel_Category+MyCategory.h
//  HanyOCLanguageDemo
//
//  Created by 冯鸿辉 on 16/7/5.
//  Copyright © 2016年 MD. All rights reserved.
//分类

/*
 分类与runtime的应用
 添加属性 - 分类一般不能添加属性，要添加属性要用到runtime，且属性是对象类型
 替换方法 - 看MyIOSDevelpTest - runtime
 访问原始类的私有属性或方法 - 写扩展，在扩展里面写要调用的私有属性和方法
 */
#import "MDModel_Category.h"

@interface MDModel_Category (MyCategory)

//添加属性
@property(nonatomic,copy)NSString *city;

//添加方法
-(void)sayGoodBye;

//访问原始类的私有属性或方法
-(void)introduce;
@end
