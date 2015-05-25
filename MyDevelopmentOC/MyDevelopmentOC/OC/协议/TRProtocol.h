//
//  TRProtocol.h
//  day06-2
//
//  Created by Tarena on 13-10-24.
//  Copyright (c) 2013年 Tarena. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol TRProtocol <NSObject>
-(void)method1;
@required
-(void)method2;
@optional
-(void)method3;
@end

