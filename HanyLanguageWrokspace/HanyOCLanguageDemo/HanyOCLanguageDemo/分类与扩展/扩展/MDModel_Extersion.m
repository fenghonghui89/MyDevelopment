//
//  MDModel_Extersion.m
//  HanyOCLanguageDemo
//
//  Created by 冯鸿辉 on 16/7/5.
//  Copyright © 2016年 MD. All rights reserved.
//

#import "MDModel_Extersion.h"

@interface MDModel_Extersion ()

@property(nonatomic,assign)int age1;
-(void)methodExtension;//扩展方法1

@end


@implementation MDModel_Extersion

-(void)methodSimple{
  
  NSLog(@"Myclass method");
}


-(void)methodExtension{
  
  NSLog(@"Extension method");
}
@end
