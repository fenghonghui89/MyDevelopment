//
//  Mydate.h
//  text
//
//  Created by HanyFeng on 14-1-4.
//  Copyright (c) 2014年 Hany. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Mydate : NSObject
@property(nonatomic,assign)int year;
@property(nonatomic,assign)int mon;
@property(nonatomic,assign)int day;
-(id)initWithYear:(int)year andMon:(int)mon andDay:(int)day;
-(void)show;
-(void)addDay;
@end
