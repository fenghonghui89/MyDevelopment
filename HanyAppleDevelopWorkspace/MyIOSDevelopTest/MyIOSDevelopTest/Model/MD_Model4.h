//
//  MD_Model4.h
//  MyIOSDevelopTest
//
//  Created by 冯鸿辉 on 2016/10/18.
//  Copyright © 2016年 hanyfeng. All rights reserved.
/*
 NSObject
 */

#import <Foundation/Foundation.h>

@protocol TRFly <NSObject>
@required -(void)fly;
@end


@interface TRSuperman : NSObject<TRFly>;

@end
