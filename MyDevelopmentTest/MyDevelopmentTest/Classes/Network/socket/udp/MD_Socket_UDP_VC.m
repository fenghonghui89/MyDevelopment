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
@end

@implementation MD_Socket_UDP_VC


- (void)viewDidLoad {
  
  [super viewDidLoad];
}

-(void)viewDidAppear:(BOOL)animated{
  
  [super viewDidAppear:animated];
  
  [self customInit];
}

#pragma mark - < method > -
-(void)customInit{
  
  self.udpSocket = [[AsyncUdpSocket alloc] initWithDelegate:self];
  [self.udpSocket bindToPort:9000 error:nil];
  [self.udpSocket enableBroadcast:YES error:nil];
  [self.udpSocket receiveWithTimeout:-1 tag:1000];
}
#pragma mark - < action > -
- (IBAction)sendBtnTap:(id)sender {
  
  NSData *data = [@"~~~~~!!!!" dataUsingEncoding:NSUTF8StringEncoding];
  
  NSString *ip = nil;
  if ([[[MDTool sharedInstance] machineName] isEqualToString:@"iPhone7,2"]) {
    ip = @"192.168.5.108";
  }else{
    ip = @"192.168.5.123";
  }
  
  [self.udpSocket sendData:data toHost:ip port:9000 withTimeout:-1 tag:1000];
}

#pragma mark - < callback > -
-(BOOL)onUdpSocket:(AsyncUdpSocket *)sock didReceiveData:(NSData *)data withTag:(long)tag fromHost:(NSString *)host port:(UInt16)port{
  
  NSLog(@"didReceiveData host:%@,port:%hu",host,port);
  
  if ([host hasPrefix:@":"]) {//排除ipv6
    
  }else{
    NSString *info = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    NSLog(@"接收到信息：%@",info);
    UIAlertView *av = [[UIAlertView alloc] initWithTitle:info message:nil delegate:self cancelButtonTitle:@"ok" otherButtonTitles:nil];
    [av show];
  }
  
  [sock receiveWithTimeout:-1 tag:1000];
  
  
  return YES;
}
@end
