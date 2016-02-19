//
//  Echo.m
//  MyApp
//
//  Created by 冯鸿辉 on 16/2/18.
//
//

#import "Echo.h"

@implementation Echo

- (void)echo:(CDVInvokedUrlCommand*)command
{
  CDVPluginResult* pluginResult = nil;
  NSString* echo = [command.arguments objectAtIndex:0];
  
  if (echo != nil && [echo length] > 0) {
    pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:echo];
  } else {
    pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR];
  }
  
  [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}

//- (void)echo:(CDVInvokedUrlCommand*)command
//{
//  CDVPluginResult* pluginResult = nil;
//  NSString* echo = [command.arguments objectAtIndex:0];
//  
//  if (echo != nil && [echo length] > 0) {
//    pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:echo];
//  } else {
//    pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR];
//  }
//  
//  [self.commandDelegate runInBackground:^{
//    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
//  }];
//}

@end
