//
//  TRMyClass.h
//  day06-2
//
//  Created by Tarena on 13-10-24.
//  Copyright (c) 2013年 Tarena. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TRProtocol2.h"
#import "TRProtocol3.h"
@interface TRMyClass : NSObject<TRProtocol2,TRProtocol3>

-(void)method4;
@end
