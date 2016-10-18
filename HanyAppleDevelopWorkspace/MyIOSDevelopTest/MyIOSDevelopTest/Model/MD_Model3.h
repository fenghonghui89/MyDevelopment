//
//  MD_Model3.h
//  MyIOSDevelopTest
//
//  Created by 冯鸿辉 on 2016/10/18.
//  Copyright © 2016年 hanyfeng. All rights reserved.
/*
 归档反归档 NSObject NSXML
 */

#import <Foundation/Foundation.h>


@interface TRPerson : NSObject<NSCoding>
@property (nonatomic,copy)NSString *name;
@property (nonatomic,assign)NSInteger age;
//@property (nonatomic,strong)NSArray *books;
@property (nonatomic,strong)NSDictionary *books;
+(TRPerson *)testData;
@end


@interface TRBook : NSObject<NSCoding>
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *author;
@property (nonatomic, strong) NSString *price;
@property (nonatomic, strong) NSString *page;
-(instancetype)initWithName:(NSString *)name author:(NSString *)author price:(NSString *)price page:(NSString *)page;
@end
