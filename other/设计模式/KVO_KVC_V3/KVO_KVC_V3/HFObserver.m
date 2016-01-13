//
//  HFObserver.m
//  KVO_KVC_V2
//
//  Created by hanyfeng on 14-5-22.
//  Copyright (c) 2014年 hanyfeng. All rights reserved.
//

#import "HFObserver.h"

@implementation HFObserver
-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    NSLog(@"\nkeyPath:%@ \nobject:%@ \nchange:%@ \ncontext:%@ \n\n",keyPath,object,change,context);
}
@end
