//
//  UUID.m
//  KeychainTest0
//
//  Created by 冯鸿辉 on 16/4/5.
//  Copyright © 2016年 DGC. All rights reserved.
//

#import "InfoManager.h"
#import "KeyChainStore.h"

@implementation InfoManager

+(NSString *)findInfo:(NSString *)service{

  return [KeyChainStore find:service];
}

+(void)addInfo:(NSString *)data service:(NSString *)service{

  [KeyChainStore add:service data:data];
}

+(void)updateInfo:(NSString *)data service:(NSString *)service{
  
  [KeyChainStore updateKeyData:service data:data];
}

+(void)deleteInfo:(NSString *)service{

  [KeyChainStore deleteKeyData:service];
}
@end
