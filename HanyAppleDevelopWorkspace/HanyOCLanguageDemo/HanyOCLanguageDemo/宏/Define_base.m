//
//  Define_base.m
//  HanyOCLanguageDemo
//
//  Created by 冯鸿辉 on 16/9/22.
//  Copyright © 2016年 MD. All rights reserved.
//

#define PPLog(format, ...) do {                                                                          \
                                fprintf(stderr, "<%s : %d> %s\n",                                           \
                                [[[NSString stringWithUTF8String:__FILE__] lastPathComponent] UTF8String],__LINE__, __func__);                                                        \
                                (NSLog)((format), ##__VA_ARGS__);                                           \
                                fprintf(stderr, "-------\n");                                               \
                                } while (0)

#import "Define_base.h"


@interface Define_base ()

@end

@implementation Define_base

-(void)root_Define_base{

  
}


-(void)kl_define0{

  int a = 0;
  if (a) PPLog(@"");
  
  else{
    PPLog(@"0000");
  }
}
@end
