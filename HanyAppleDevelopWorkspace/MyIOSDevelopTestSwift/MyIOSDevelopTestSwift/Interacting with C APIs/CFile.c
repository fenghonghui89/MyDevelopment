//
//  CFile.c
//  MyDevelopmentSwift
//
//  Created by 冯鸿辉 on 16/7/7.
//  Copyright © 2016年 MD. All rights reserved.
//

#include "CFile.h"

typedef enum  {
  ErrorNone = 0,
  ErrorFileNotFound = -1,
  ErrorInvalidFormat = -2,
}Error;