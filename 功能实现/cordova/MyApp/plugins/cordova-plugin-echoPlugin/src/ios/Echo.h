//
//  Echo.h
//  MyApp
//
//  Created by 冯鸿辉 on 16/2/18.
//
//

#import <Cordova/CDVPlugin.h>

@interface Echo : CDVPlugin
- (void)echo:(CDVInvokedUrlCommand*)command;

@end
