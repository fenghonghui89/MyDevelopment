//
//  TRXY.m
//  my01
//
//  Created by apple on 13-10-30.
//  Copyright (c) 2013年 Hany. All rights reserved.
//

#import "TRXYZ.h"

@implementation TRXYZ

//-(NSString*)description
//{
//    return [NSString stringWithFormat:@"x:%d,y:%d,z:%d",self.x,self.y,self.z];
//}

-(NSUInteger)hash
{   NSLog(@"执行TRXYZ的hash方法%@",self);
    return self.x+self.y+self.z;
}

-(BOOL)isEqual:(id)object
{
    NSLog(@"执行TRXYZ的isEqual方法%@",self);
    if ([object isKindOfClass:[TRXYZ class]]) {
        TRXYZ* tempXYZ = object;
        if (self.x == tempXYZ.x){
            if (self.y == tempXYZ.y) {
                if (self.z == tempXYZ.z) {
                    return YES;
                }else{
                    return NO;
                }
            }else{
                return NO;
            }
        }else{
            return NO;
        }
    }else{
        return NO;
    }
}
@end
