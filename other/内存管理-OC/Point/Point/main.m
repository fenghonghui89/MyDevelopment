//
//  main.m
//  Point
//
//  Created by hanyfeng on 14-4-23.
//  Copyright (c) 2014年 hanyfeng. All rights reserved.
//
//变量的地址、指针、对象、指针变量的地址、指针的大小

#import <Foundation/Foundation.h>

int main(int argc, const char * argv[])
{

    @autoreleasepool {
        
        int i = 3;
        NSLog(@"int i:%d %p,%lu",*&i,&i,sizeof(&i));
        
        int *j = &i ;
        NSLog(@"int *j:%p %p %lu",j,&j,sizeof(j));
        
        NSObject *o = [[NSObject alloc] init];
        NSLog(@"NSObject *o:%p %p %lu",o,&o,sizeof(o));
        
    }
    return 0;
}

