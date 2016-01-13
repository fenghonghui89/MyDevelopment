//
//  HFMyFramework.h
//  UIView
//
//  Created by hanyfeng on 14-3-27.
//  Copyright (c) 2014年 hanyfeng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HFMyFramework : NSObject
+(HFMyFramework*)shareMyFramework;
-(void)addView;
-(void)deleteAddView;
@end
