//
//  main.m
//  HanyOCLanguageDemo
//
//  Created by 冯鸿辉 on 16/7/5.
//  Copyright © 2016年 MD. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "Root_Protocol.h"
#import "Root_CategoryAndExtersion.h"
#import "Root_ParamaAndInit.h"
#import "Root_Block.h"
int main(int argc, const char * argv[]) {
  
//  [[Root_Protocol new] root_Protocol];
//  [[Root_CategoryAndExtersion new] root_CategoryAndExtersion];
//  [[Root_ParamaAndInit new] root_ParamaAndInit];
  [[Root_Block new] root_Block];
  
  return 0;
}
