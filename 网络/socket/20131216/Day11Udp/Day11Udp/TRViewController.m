//
//  TRViewController.m
//  Day11Udp
//
//  Created by Tarena on 13-12-16.
//  Copyright (c) 2013年 Tarena. All rights reserved.
//

#import "TRViewController.h"

@interface TRViewController ()
@property (nonatomic ,strong)AsyncUdpSocket *udpSocket;
@end

@implementation TRViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.udpSocket = [[AsyncUdpSocket alloc]initWithDelegate:self];//1.创建AsyncUdpSocket
    [self.udpSocket bindToPort:9000 error:Nil];//2.绑定一个端口
    [self.udpSocket enableBroadcast:YES error:Nil];//3.设置为广播（可选）
    [self.udpSocket receiveWithTimeout:-1 tag:0];//4.读取数据（如果有人给本设备的ip发udp消息，就会自动调用didreciveData）
}

//接收信息
-(BOOL)onUdpSocket:(AsyncUdpSocket *)sock didReceiveData:(NSData *)data withTag:(long)tag fromHost:(NSString *)host port:(UInt16)port{
    if ([host hasPrefix:@":"]) {//如果接收到IPV6的消息，则不输出
        return YES;
    }
    
    NSString *info = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    NSLog(@"接收到%@说：%@",host,info);
    
    [sock receiveWithTimeout:-1 tag:0];//持续读取数据
    return YES;
}

//发送按钮
- (IBAction)clicked:(id)sender {
    NSData *data = [@"你好！！" dataUsingEncoding:NSUTF8StringEncoding];
    [self.udpSocket sendData:data toHost:@"255.255.255.255" port:9000 withTimeout:-1 tag:0];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
