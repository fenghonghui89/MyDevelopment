//
//  MD_Socket_UDP_VC.m
//  MyDevelopmentTest
//
//  Created by 冯鸿辉 on 16/3/29.
//  Copyright © 2016年 hanyfeng. All rights reserved.
//

#import "MD_Socket_UDP_VC.h"
#import "AsyncUdpSocket.h"
@interface MD_Socket_UDP_VC ()
@property(nonatomic,strong)AsyncUdpSocket *udpSocket;
@property(nonatomic,strong)NSTimer *timer;
@end

@implementation MD_Socket_UDP_VC


- (void)viewDidLoad {
  
  [super viewDidLoad];
}

-(void)viewDidAppear:(BOOL)animated{
  
  [super viewDidAppear:animated];
  
  [self customInit];
}

-(void)viewDidDisappear:(BOOL)animated{

  [self.timer invalidate];
  [super viewDidDisappear:animated];
}

#pragma mark - < method > -
-(void)customInit{
  
  self.udpSocket = [[AsyncUdpSocket alloc] initWithDelegate:self];
  [self.udpSocket bindToPort:9000 error:nil];//绑定一个端口
  [self.udpSocket enableBroadcast:YES error:nil];//开启广播
  [self.udpSocket receiveWithTimeout:-1 tag:1000];
  
  self.timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(findSomeone) userInfo:nil repeats:YES];
  
}

-(void)findSomeone{

  NSString *info = @"谁在线";
  NSData *data = [info dataUsingEncoding:NSUTF8StringEncoding];
  [self.udpSocket sendData:data toHost:@"255.255.255.255" port:9000 withTimeout:-1 tag:1000];
}

#pragma mark - < action > -
- (IBAction)sendBtnTap:(id)sender {
  
  NSData *data = [@"我在线" dataUsingEncoding:NSUTF8StringEncoding];
  
  NSString *ip = nil;
  if ([[[MDTool sharedInstance] machineName] isEqualToString:@"iPhone7,2"]) {
    ip = @"192.168.5.108";
  }else{
    ip = @"192.168.5.123";
  }
  
  [self.udpSocket sendData:data toHost:@"255.255.255.255" port:9000 withTimeout:-1 tag:1000];
}

#pragma mark - < callback > -
-(BOOL)onUdpSocket:(AsyncUdpSocket *)sock didReceiveData:(NSData *)data withTag:(long)tag fromHost:(NSString *)host port:(UInt16)port{
  
  NSLog(@"didReceiveData host:%@,port:%hu",host,port);
  
  [sock receiveWithTimeout:-1 tag:1000];
  
  if ([host hasPrefix:@":"]) {//排除ipv6
    return YES;
  }
  
  NSString *info = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
  NSLog(@"接收到信息：%@",info);
  
  if ([info isEqualToString:@"谁在线"]) {
    if ([[[MDTool sharedInstance] ShowIPAddress] isEqualToString:host]) {//排除自己发送的
      return YES;
    }else{
      //发送“我在线”给对方
    }
  }
  
  if ([info isEqualToString:@"我在线"]) {
    if ([[[MDTool sharedInstance] ShowIPAddress] isEqualToString:host]) {//排除自己发送的
      return YES;
    }else{
      UIAlertView *av = [[UIAlertView alloc] initWithTitle:info message:host delegate:self cancelButtonTitle:@"ok" otherButtonTitles:nil];
      [av show];
    }
  }
  
  
  return YES;
}
@end
