//
//  XTJSuperClass.h
//  XTJMall
//
//  Created by hanyfeng on 2017/9/15.
//  Copyright © 2017年 hanyfeng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XTJSonClass.h"
#import "XTJDaugrtClass.h"
@interface XTJSuperClass : NSObject
@property(nonatomic,copy)NSString *name;
@property(nonatomic,strong)XTJSonClass *son;
@property(nonatomic,strong)NSArray *daugs;
@end
