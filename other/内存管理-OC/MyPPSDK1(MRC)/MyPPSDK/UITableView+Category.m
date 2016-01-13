//
//  UITableView+Category.m
//  MyPPSDK
//
//  Created by hanyfeng on 14-4-29.
//  Copyright (c) 2014年 hanyfeng. All rights reserved.
//

#import "UITableView+Category.h"

@implementation UITableView (Category)
-(void)dealloc{
    NSLog(@"UITableView dealloc:%p",self);
    [super dealloc];
}
@end
