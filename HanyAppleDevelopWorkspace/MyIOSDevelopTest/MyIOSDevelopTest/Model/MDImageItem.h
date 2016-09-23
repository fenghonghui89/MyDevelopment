//
//  MDImageItem.h
//  MyDevelopmentTest
//
//  Created by 冯鸿辉 on 16/3/24.
//  Copyright © 2016年 hanyfeng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface MDImageItem : NSObject
@property(nonatomic,copy)NSString *imageName;
@property(nonatomic,copy)NSString *imageUrl;
@property(nonatomic,strong)UIImage *image;

-(id)initWithDic:(NSDictionary *)dic;
+(NSMutableArray *)handleData:(NSData *)data;
@end
