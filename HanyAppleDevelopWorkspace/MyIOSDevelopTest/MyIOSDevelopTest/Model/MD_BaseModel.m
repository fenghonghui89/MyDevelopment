//
//  MD_BaseModel.m
//  MyIOSDevelopTest
//
//  Created by 冯鸿辉 on 2016/10/19.
//  Copyright © 2016年 hanyfeng. All rights reserved.
//

#import "MD_BaseModel.h"
#import <objc/runtime.h>
@implementation MD_BaseModel

-(instancetype)initWithCoder:(NSCoder *)aDecoder{

  unsigned int count = 0;
  objc_property_t *properties = class_copyPropertyList([self class], &count);
  
  for (int i = 0;i < count;i ++) {
    objc_property_t property = properties[i];
    const char *name = property_getName(property);
    NSString *key = [NSString stringWithUTF8String:name];
    [self setValue:[aDecoder decodeObjectForKey:key] forKeyPath:key];
  }
  return self;
}

-(void)encodeWithCoder:(NSCoder *)aCoder{

  unsigned int count = 0;
  objc_property_t *properties = class_copyPropertyList([self class], &count);
  
  for (int i = 0;i < count;i ++) {
    objc_property_t property = properties[i];
    const char *name = property_getName(property);
    NSString *key = [NSString stringWithUTF8String:name];
    [aCoder encodeObject:[self valueForKeyPath:key] forKey:key];
  }

}
@end
