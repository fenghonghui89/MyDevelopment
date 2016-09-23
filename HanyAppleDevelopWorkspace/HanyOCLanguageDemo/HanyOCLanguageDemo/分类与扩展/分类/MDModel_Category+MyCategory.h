//
//  MDModel_Category+MyCategory.h
//  HanyOCLanguageDemo
//
//  Created by 冯鸿辉 on 16/7/5.
//  Copyright © 2016年 MD. All rights reserved.
//分类

/*
 分类一般不能添加属性，要添加属性要用到runtime，且属性是对象类型
 */
#import "MDModel_Category.h"

@interface MDModel_Category (MyCategory)
@property(nonatomic,copy)NSString *city;
-(void)sayGoodBye;
@end
