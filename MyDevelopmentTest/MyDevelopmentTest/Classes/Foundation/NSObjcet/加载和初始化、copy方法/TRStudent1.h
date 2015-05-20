//
//  TRStudent.h
//  my01
//
//  Created by apple on 13-10-25.
//  Copyright (c) 2013年 Hany. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TRStudent1 : NSObject<NSCopying>//1.要运用copy，首先要遵守NSCopying协议

@property(nonatomic,assign)int age;
@property(nonatomic,copy)NSString* name;

-(id)InitWithAge:(int)age andName:(NSString*)name;//如果连对象的值也要复制，可以用初始化方法解决
@end
