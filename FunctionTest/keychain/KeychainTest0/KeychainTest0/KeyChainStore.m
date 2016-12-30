//
//  KeyChainStore.m
//  KeychainTest0
//
//  Created by 冯鸿辉 on 16/4/5.
//  Copyright © 2016年 DGC. All rights reserved.
//

#import "KeyChainStore.h"

@implementation KeyChainStore

+ (NSMutableDictionary *)getKeychainQuery:(NSString *)service {
  
  //区别(标识)一个item要用kSecAttrAccount和kSecAttrService
  return [NSMutableDictionary dictionaryWithObjectsAndKeys:
          (id)kSecClassGenericPassword,(id)kSecClass,//定义属于哪种类型的keychain
          service, (id)kSecAttrService,//服务名称
          service, (id)kSecAttrAccount,//账号名称
//          service, (id)kSecAttrGeneric,//用来存储标识符
          (id)kSecAttrAccessibleAfterFirstUnlock,(id)kSecAttrAccessible,//应用何时允许访问keychain数据
          nil];
  
}


//+ (NSMutableDictionary *)getKeychainQuery:(NSString *)service {
//  
//  //区别(标识)一个item要用kSecAttrAccount和kSecAttrService
//  return [NSMutableDictionary dictionaryWithObjectsAndKeys:
//          (id)kSecClassGenericPassword,(id)kSecClass,//定义属于哪种类型的keychain
//          service, (id)kSecAttrService,//服务名称
//          //          service, (id)kSecAttrGeneric,//用来存储标识符
//          (id)kSecAttrAccessibleAfterFirstUnlock,(id)kSecAttrAccessible,//应用何时允许访问keychain数据
//          nil];
//  
//}

+ (NSMutableDictionary *)getKeychainQuery:(NSString *)service userName:(NSString *)username{
  
  //区别(标识)一个item要用kSecAttrAccount和kSecAttrService
  return [NSMutableDictionary dictionaryWithObjectsAndKeys:
          (id)kSecClassGenericPassword,(id)kSecClass,//定义属于哪种类型的keychain
          service, (id)kSecAttrService,//服务名称
          username, (id)kSecAttrAccount,//账号名称
          //          service, (id)kSecAttrGeneric,//用来存储标识符
          (id)kSecAttrAccessibleAfterFirstUnlock,(id)kSecAttrAccessible,//应用何时允许访问keychain数据
          nil];
  
}

#pragma mark - 增删改查
+ (void)add:(NSString *)service data:(id)data {
  

  NSMutableDictionary *keychainQuery = [self getKeychainQuery:service];
  //增加条目不能添加以下两个
//  [keychainQuery setObject:(id)kCFBooleanTrue forKey:(id)kSecReturnData];//指定必须返回CFDataRef格式
//  [keychainQuery setObject:(id)kSecMatchLimitOne forKey:(id)kSecMatchLimit];//指定只返回一条
  
  CFDataRef keyData = NULL;
  if (SecItemCopyMatching((CFDictionaryRef)keychainQuery, (CFTypeRef *)&keyData) == noErr) {
    NSLog(@"存在 不再添加");
  }else{
    NSLog(@"不存在 添加");
    
    [keychainQuery setObject:[NSKeyedArchiver archivedDataWithRootObject:data] forKey:(id)kSecValueData];
    
    OSStatus status = SecItemAdd((CFDictionaryRef)keychainQuery, NULL);
    if (status == noErr) {
      NSLog(@"添加成功");
    }else{
      NSLog(@"添加错误:%d",(int)status);
    }
  }
  
  if (keyData)
    CFRelease(keyData);
  
}


+ (void)add:(NSString *)service password:(NSString *)password userName:(NSString *)userName {
  
  
  NSMutableDictionary *keychainQuery = [self getKeychainQuery:service userName:userName ];
  //增加条目不能添加以下两个
  //  [keychainQuery setObject:(id)kCFBooleanTrue forKey:(id)kSecReturnData];//指定必须返回CFDataRef格式
  //  [keychainQuery setObject:(id)kSecMatchLimitOne forKey:(id)kSecMatchLimit];//指定只返回一条
  
  CFDataRef keyData = NULL;
  if (SecItemCopyMatching((CFDictionaryRef)keychainQuery, (CFTypeRef *)&keyData) == noErr) {
    NSLog(@"存在 不再添加");
  }else{
    NSLog(@"不存在 添加");
    
    [keychainQuery setObject:[NSKeyedArchiver archivedDataWithRootObject:password] forKey:(id)kSecValueData];
    
    OSStatus status = SecItemAdd((CFDictionaryRef)keychainQuery, NULL);
    if (status == noErr) {
      NSLog(@"添加成功");
    }else{
      NSLog(@"添加错误:%d",(int)status);
    }
  }
  
  if (keyData)
    CFRelease(keyData);
  
}

+ (id)find:(NSString *)service {
  
  NSMutableDictionary *keychainQuery = [self getKeychainQuery:service];
  [keychainQuery setObject:(id)kCFBooleanTrue forKey:(id)kSecReturnData];//指定必须返回CFDataRef格式
  [keychainQuery setObject:(id)kSecMatchLimitOne forKey:(id)kSecMatchLimit];//指定只返回一条
  
  id ret = nil;
  CFDataRef keyData = NULL;
  OSStatus status = SecItemCopyMatching((CFDictionaryRef)keychainQuery, (CFTypeRef *)&keyData);
  if (status == noErr) {
    NSLog(@"存在，解码");
    ret = [NSKeyedUnarchiver unarchiveObjectWithData:(__bridge NSData *)keyData];
  }else{
    NSLog(@"不存在，返回nil");
  }
  
  if (keyData)
    CFRelease(keyData);
  
  return ret;
}


+ (void)deleteKeyData:(NSString *)service {
  
  NSMutableDictionary *keychainQuery = [self getKeychainQuery:service];
  
  OSStatus status = SecItemDelete((CFDictionaryRef)keychainQuery);
  if (status == noErr) {
    NSLog(@"删除成功");
  }else{
    NSLog(@"删除失败：%d",(int)status);
  }
  
}

+(void)updateKeyData:(NSString *)service data:(NSString *)data{
  
//  NSMutableDictionary *keychainQuery = [self getKeychainQuery:service];
//
//  
//  NSDictionary *attributes = NULL;
//  CFTypeRef attributes_cf = (__bridge CFTypeRef)attributes;
//  
//  NSMutableDictionary *updateItem = NULL;
//  OSStatus result;
//  
//  result = SecItemCopyMatching((CFDictionaryRef)keychainQuery, (CFTypeRef *)attributes_cf);
//  if (result == noErr) {
//    NSLog(@"找到对应条目");
//    
//    updateItem = [NSMutableDictionary dictionaryWithDictionary:(__bridge NSDictionary *)attributes_cf];
//    [updateItem setObject:[keychainQuery objectForKey:(id)kSecClass] forKey:(id)kSecClass];
//    
//    NSMutableDictionary *tempCheck = [NSMutableDictionary dictionaryWithDictionary:keychainQuery];
//    [tempCheck removeObjectForKey:(id)kSecClass];
//    [tempCheck setObject:[NSKeyedArchiver archivedDataWithRootObject:data] forKey:(id)kSecValueData];
//    
//    result = SecItemUpdate((CFDictionaryRef)keychainQuery, (CFDictionaryRef)tempCheck);
//    if (result == noErr) {
//      NSLog(@"更新成功");
//    }else{
//      NSLog(@"更新失败:%d",(int)result);
//    }
//  }else{
//    NSLog(@"找不到对应条目");
//  }
  

  
  
  NSMutableDictionary *keychainQuery = [self getKeychainQuery:service];
  //不能添加下面两个键值，否则更新失败 -50 -50代表传入的参数有错误
//  [keychainQuery setObject:(id)kCFBooleanTrue forKey:(id)kSecReturnData];//指定必须返回CFDataRef格式
//  [keychainQuery setObject:(id)kSecMatchLimitOne forKey:(id)kSecMatchLimit];//指定只返回一条
  
  CFDataRef keyData = NULL;
  
  OSStatus result;
  
  result = SecItemCopyMatching((CFDictionaryRef)keychainQuery, (CFTypeRef *)keyData);
  if (result == noErr) {
    NSLog(@"找到对应条目");
    
    //要更新的内容
    NSMutableDictionary *tempCheck = [NSMutableDictionary dictionaryWithDictionary:keychainQuery];
    [tempCheck removeObjectForKey:(id)kSecClass];//要去掉这个键值再更新 否则-50
    [tempCheck setObject:[NSKeyedArchiver archivedDataWithRootObject:data] forKey:(id)kSecValueData];
    
    //参数：需要被更新的原始内容 要更新的内容
    result = SecItemUpdate((CFDictionaryRef)keychainQuery, (CFDictionaryRef)tempCheck);
    if (result == noErr) {
      NSLog(@"更新成功");
    }else{
      NSLog(@"更新失败:%d",(int)result);
    }
  }else{
    NSLog(@"找不到对应条目");
  }
}

@end
