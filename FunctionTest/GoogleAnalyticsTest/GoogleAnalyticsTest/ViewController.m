//
//  ViewController.m
//  GoogleAnalyticsTest
//
//  Created by 冯鸿辉 on 2016/11/14.
//  Copyright © 2016年 HanyAppDev. All rights reserved.
//

#import "ViewController.h"

#import "GAIDictionaryBuilder.h"
#import "GAIFields.h"
#import "GAI.h"

static NSString *const kAllowTracking = @"allowTracking";

@interface ViewController ()
@property(nonatomic,strong)GAIDictionaryBuilder *builder;
@end

@implementation ViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  
  // Do any additional setup after loading the view, typically from a nib.
  [self onLoad:1];
}


#pragma mark 事件跟踪
- (IBAction)dispathBtnTap:(id)sender {
  //类别 操作 标签 事件值
  NSMutableDictionary *event = [[GAIDictionaryBuilder createEventWithCategory:@"UI"
                                                                       action:@"buttonPress"
                                                                        label:@"dispatch"
                                                                        value:nil] build];

  [[[GAI sharedInstance] defaultTracker] send:event];
  [[GAI sharedInstance] dispatch];//手动调度
}

#pragma mark 崩溃跟踪
- (IBAction)carshBtnTap:(id)sender {
  
  @try {
    [NSException raise:@"There is no spoon." format:@"Abort, retry, fail?"];
  } @catch (NSException *exception) {
    id tracker = [[GAI sharedInstance] defaultTracker];
    
    [tracker send:[[GAIDictionaryBuilder
                    createExceptionWithDescription:@"Connection timeout"  // Exception description. May be truncated to 100 chars.异常的相关说明（最多 100 个字符）。nil 是可接受的值。
                    withFatal:@(NO)] build]];  // isFatal (required). NO indicates non-fatal exception.表示异常是否严重。 YES 表示严重

  } @finally {
    
  }
}

#pragma mark 屏幕跟踪
- (IBAction)btn1Tap:(id)sender {

  id tracker = [[GAI sharedInstance] defaultTracker];
  [tracker set:kGAIScreenName value:@"页面1"];
  [tracker send:[[GAIDictionaryBuilder createScreenView] build]];

}


#pragma mark 会话跟踪
- (IBAction)startChat:(id)sender {
  
  id tracker = [[GAI sharedInstance] defaultTracker];
  [tracker set:kGAIScreenName value:@"会话screen"];
  
  GAIDictionaryBuilder *builder = [GAIDictionaryBuilder createScreenView];
  [builder set:@"start" forKey:kGAISessionControl];
  
  [tracker send:[builder build]];
  
  self.builder = builder;
}

- (IBAction)endChat:(id)sender {
  
  [self.builder set:@"end" forKey:kGAISessionControl];
}

#pragma mark 用户计时

- (void)onLoad:(NSTimeInterval)loadTime {
  
  id tracker = [[GAI sharedInstance] defaultTracker];
  GAIDictionaryBuilder *timing = [GAIDictionaryBuilder createTimingWithCategory:@"resources"
                                                                        interval:@((NSUInteger)(loadTime * 1000))
                                                                            name:@"high scores"
                                                                           label:nil];
  NSMutableDictionary *param = [timing build];
  [tracker send:param];
}


#pragma mark 跟踪开关
- (IBAction)switchValueChanged:(UISwitch *)sender {
  
  NSDictionary *appDefaults = @{kAllowTracking: @(sender.on)};
  [[NSUserDefaults standardUserDefaults] registerDefaults:appDefaults];
  [GAI sharedInstance].optOut = ![[NSUserDefaults standardUserDefaults] boolForKey:kAllowTracking];//yes-停止跟踪 on-跟踪
}

#pragma mark 隐藏ip
-(void)anonymizeIp{
  [[[GAI sharedInstance] defaultTracker] set:kGAIAnonymizeIp value:@"1"];
}
@end
