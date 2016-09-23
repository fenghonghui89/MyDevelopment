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
#import "Root_Define.h"
int main(int argc, const char * argv[]) {
  
//  [[Root_Protocol new] root_Protocol];//协议
//  [[Root_CategoryAndExtersion new] root_CategoryAndExtersion];//分类与扩展
//  [[Root_ParamaAndInit new] root_ParamaAndInit];//属性与初始化
//  [[Root_Block new] root_Block];//block
  [[Root_Define new] root_Define];//宏
  
  return 0;
}
