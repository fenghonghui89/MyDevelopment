/********* SharePlugin.m Cordova Plugin Implementation *******/

#import <Cordova/CDV.h>
#import "DGCShareManager.h"
#import "AppDelegate.h"
@interface SharePlugin : CDVPlugin <DGCShareManagerDelegate>
{
  CDVInvokedUrlCommand *_command;
  CDVPluginResult *_pluginResult;
}
@property(nonatomic,strong)CDVInvokedUrlCommand *command;


- (void)share:(CDVInvokedUrlCommand*)command;
- (void)cleanup:(CDVInvokedUrlCommand*)command;
@end

@implementation SharePlugin

- (void)share:(CDVInvokedUrlCommand*)command
{
  NSString *title = [command.arguments objectAtIndex:0];
  NSString *content = [command.arguments objectAtIndex:1];
  NSString *imgUrl = [command.arguments objectAtIndex:2];
  NSString *shareUrl = [command.arguments objectAtIndex:3];
  NSLog(@"%@ %@ %@ %@",title,content,imgUrl,shareUrl);
  

  self.command = command;
  
  AppDelegate *appDelegate = [UIApplication sharedApplication].delegate;
  [[DGCShareManager shareInstance] share:appDelegate.vc delegate:self title:title shareText:content url:shareUrl imgUrl:imgUrl];
  
}

- (void)cleanup:(CDVInvokedUrlCommand*)command{
  CDVPluginResult* pluginResult = nil;
  pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:@"yeah~"];
  
  [self.commandDelegate runInBackground:^{
    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
  }];

}

-(void)shareManager:(DGCShareManager *)shareManager shareDidFinish:(BOOL)result{
  if (result == YES) {
    [self.commandDelegate runInBackground:^{
      CDVPluginResult* pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:@"share OK"];
      [self.commandDelegate sendPluginResult:pluginResult callbackId:self.command.callbackId];
    }];
  }else{
    [self.commandDelegate runInBackground:^{
      CDVPluginResult* pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:@"share fail"];
      [self.commandDelegate sendPluginResult:pluginResult callbackId:self.command.callbackId];
    }];
  }
}
@end
