//
//  XMLParser.h
//  TBXML_Test
//
//  Created by hanyfeng on 14-6-23.
//  Copyright (c) 2014年 hanyfeng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TBXML.h"
@interface XMLParser : NSObject

//解析出的数据内部是字典类型
@property (strong,nonatomic) NSMutableArray *notes;

//开始解析
-(void)start;

@end
