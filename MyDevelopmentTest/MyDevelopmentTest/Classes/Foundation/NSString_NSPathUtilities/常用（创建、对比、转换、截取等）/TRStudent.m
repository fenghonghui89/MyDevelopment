//
//  TRStudent.m
//  my08
//
//  Created by apple on 13-10-26.
//  Copyright (c) 2013年 Hany. All rights reserved.
//

#import "TRStudent.h"

@implementation TRStudent
-(NSString*)description
{
    NSLog(@"执行了description方法");
    return [NSString stringWithFormat:@"age:%d",self.age];
}
@end
