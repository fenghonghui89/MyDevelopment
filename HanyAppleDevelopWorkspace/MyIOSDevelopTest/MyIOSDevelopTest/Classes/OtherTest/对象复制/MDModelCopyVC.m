//
//  MDModelCopyVC.m
//  MyIOSDevelopTest
//
//  Created by hanyfeng on 2017/9/15.
//  Copyright © 2017年 hanyfeng. All rights reserved.
//

#import "MDModelCopyVC.h"
#import "XTJSuperClass.h"
#import "XTJSonClass.h"
#import "XTJDaugrtClass.h"
@interface MDModelCopyVC ()

@end

@implementation MDModelCopyVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    XTJSonClass *son = [XTJSonClass new];
    son.name = @"erzi";
    
    XTJDaugrtClass *da = [XTJDaugrtClass new];
    da.name = @"dau";
    
    XTJSuperClass *baba = [XTJSuperClass new];
    baba.name = @"baba";
    baba.son = son;
    baba.daugs = @[da];
    
    
    XTJSuperClass *baba1 = [baba copy];
    baba1.name = @"把把";
    baba1.son.name = @"儿子";
    XTJDaugrtClass *day = baba1.daugs[0];
    day.name = @"女儿";
    
    if ([baba1.daugs isKindOfClass:[NSMutableArray class]]) {
        NSLog(@"是可变");
    }else{
        NSLog(@"不可变");
    }
    NSLog(@"%@ %@ %@ %@%@ %@",baba.name,baba1.name,baba.son.name,baba1.son.name,da.name,day.name);

}




@end
