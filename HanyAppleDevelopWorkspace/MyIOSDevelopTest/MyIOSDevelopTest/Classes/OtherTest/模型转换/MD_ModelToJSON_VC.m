//
//  MD_ModelToJSON_VC.m
//  MyIOSDevelopTest
//
//  Created by 冯鸿辉 on 2016/10/21.
//  Copyright © 2016年 hanyfeng. All rights reserved.
//

#import "MD_ModelToJSON_VC.h"
#import "MDRootDefine.h"
#import "YYModel.h"

#pragma mark - ******************* User *******************
@interface User : NSObject<NSCopying>
@property(nonatomic,assign) UInt64 uid;
@property(nonatomic,copy) NSString *name;
@end
@implementation User
-(NSString *)description{
  return [NSString stringWithFormat:@"user..%llu %@",self.uid,self.name];
}
-(id)copyWithZone:(NSZone *)zone{

    return [self copyWithZone:zone];
}
@end

#pragma mark - ******************* Author （Model 包含其他 Model） *******************
@interface Author : NSObject<NSCopying>
@property(nonatomic,copy) NSString *name;
@property(nonatomic,assign) NSInteger age;
@property(nonatomic,strong) NSDate *birthday;
@property(nonatomic,strong) NSArray *users;
@end
@implementation Author

//Model 包含其他 Model
+ (NSDictionary *)modelContainerPropertyGenericClass {
  return @{@"users":User.class};
}
-(NSString *)description{
  return [NSString stringWithFormat:@"author..name:%@ \n age:%ld \n birthday:%@ \n users:%@",self.name,(long)self.age,self.birthday,self.users];
}

-(id)copyWithZone:(NSZone *)zone{
    
    Author *author = [[Author allocWithZone:zone] init];
    author.users = [[NSArray alloc] initWithArray:self.users copyItems:YES];
    return [self copyWithZone:zone];
}
@end

#pragma mark - ******************* Book （属性与json key不同 / json与model互转） *******************
@interface Book : NSObject<NSCopying>
@property(nonatomic,copy) NSString *name;
@property(nonatomic,assign) NSInteger page;
@property(nonatomic,copy) NSString *desc;
@property(nonatomic,copy) NSString *bookID;
@property(nonatomic,strong) Author *author;
@property(nonatomic,strong) NSDate *createdAt;
@end
@implementation Book
-(NSString *)description{
  return [NSString stringWithFormat:@"book..name:%@ \n page:%ld \n desc:%@ \n id:%@ \n createdAt:%@ \n author:%@",self.name,(long)self.page,self.desc,self.bookID,self.createdAt,self.author.description];
}

//Model 属性名和 JSON 中的 Key 不相同
+(NSDictionary *)modelCustomPropertyMapper{
  return @{@"name" : @"n",
           @"page" : @"p",
           @"desc" : @"ext.desc",
           @"bookID" : @[@"id",@"ID",@"book_id",@"bookID"]};
}

// 当 JSON 转为 Model 完成后，该方法会被调用。
// 你可以在这里对数据进行校验，如果校验不通过，可以返回 NO，则该 Model 会被忽略。
// 你也可以在这里做一些自动转换不能完成的工作。
- (BOOL)modelCustomTransformFromDictionary:(NSDictionary *)dic {
  NSNumber *timestamp = dic[@"timestamp"];
  if (![timestamp isKindOfClass:[NSNumber class]] || timestamp == nil){
    DRLog(@"timestamp error..");
    return NO;
  }else{
    DRLog(@"timestamp right..");
    _createdAt = [NSDate dateWithTimeIntervalSince1970:timestamp.floatValue];
    return YES;
  }
  
}

// 当 Model 转为 JSON 完成后，该方法会被调用。
// 你可以在这里对数据进行校验，如果校验不通过，可以返回 NO，则该 Model 会被忽略。
// 你也可以在这里做一些自动转换不能完成的工作。
- (BOOL)modelCustomTransformToDictionary:(NSMutableDictionary *)dic {
  if (!_createdAt) {
    DRLog(@"_createdAt error..");
    return NO;
  }else{
    DRLog(@"_createdAt right..");
    dic[@"timestamp"] = @([NSDate date].timeIntervalSince1970);
    return YES;
  }
  
}

-(id)copyWithZone:(NSZone *)zone{
    
    Book *book = [[Book allocWithZone:zone] init];
    book.author = [self.author copy];
    return book;
}
@end


#pragma mark - ******************* MD_ModelToJSON_VC *******************
@interface MD_ModelToJSON_VC ()

@end

@implementation MD_ModelToJSON_VC

- (void)viewDidLoad {
  [super viewDidLoad];
  [self test];
}


-(void)test{
  
  NSDictionary *json = @{@"p":@(666),
                         @"n":@"Harry Potter",
                         @"ext":@{
                             @"desc":@"A book written by J.K.Rowing."
                             },
                         @"author":@{
                             @"name":@"J.K.Rowling",
                             @"age":@(20),
                             @"birthday":@"1965-07-31T00:00:00+0000",
                             @"users":@[
                                 @{@"name":@"peter",@"uid":@(2222)},
                                 @{@"name":@"Jim",@"uid":@(333)}
                                        ]
                             },
                         @"ID":@"100010",
                         @"timestamp":@(1445534567)
                         };
  Book *book = [Book yy_modelWithJSON:json];
  DRLog(@"model..%@",book);
  
  NSDictionary *dic = [book yy_modelToJSONObject];
  DRLog(@"json..%@",dic);

}


@end
