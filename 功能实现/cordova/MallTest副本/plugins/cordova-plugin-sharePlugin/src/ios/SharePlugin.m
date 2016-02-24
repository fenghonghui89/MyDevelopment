/********* SharePlugin.m Cordova Plugin Implementation *******/

#import <Cordova/CDV.h>

@interface SharePlugin : CDVPlugin {
  // Member variables go here.
}

- (void)share:(CDVInvokedUrlCommand*)command;
@end

@implementation SharePlugin

- (void)share:(CDVInvokedUrlCommand*)command
{
  CDVPluginResult* pluginResult = nil;
  NSString *title = [command.arguments objectAtIndex:0];
  NSString *content = [command.arguments objectAtIndex:1];
  NSString *imgUrl = [command.arguments objectAtIndex:2];
  NSString *shareUrl = [command.arguments objectAtIndex:3];
  NSLog(@"%@ %@ %@ %@",title,content,imgUrl,shareUrl);
  pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:@"OK"];

  [self.commandDelegate runInBackground:^{
    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
  }];
}

@end
