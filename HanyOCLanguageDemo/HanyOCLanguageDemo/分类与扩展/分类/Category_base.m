//
//  Category_base.m
//  HanyOCLanguageDemo
//
//  Created by 冯鸿辉 on 16/7/5.
//  Copyright © 2016年 MD. All rights reserved.
//

#import "Category_base.h"
#import "MDModel_Category.h"
#import "MDModel_Category+MyCategory.h"

@implementation Category_base
-(void)root_Category_base{

  [self kl_0];
}

-(void)kl_0{

  MDModel_Category *md = [MDModel_Category new];
  [md sayGoodBye];
  md.city = @"JM";
  NSLog(@"%@",md.city);
}


@end
