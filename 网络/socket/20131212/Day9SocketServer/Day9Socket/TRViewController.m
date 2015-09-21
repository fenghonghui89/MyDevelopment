//
//  TRViewController.m
//  Day9Socket
//
//  Created by Tarena on 13-12-12.
//  Copyright (c) 2013年 Tarena. All rights reserved.
//

#import "TRViewController.h"

@interface TRViewController ()
@property (nonatomic, strong)AsyncSocket *serverSocket;
@property (nonatomic, strong)AsyncSocket *myNewSocket;
@end

@implementation TRViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //创建服务器
    self.serverSocket = [[AsyncSocket alloc]initWithDelegate:self];
    NSError *err = nil;
    //监听端口
    [self.serverSocket acceptOnPort:8000 error:&err];
    if (err) {
        NSLog(@"%@",[err localizedDescription]);
    }
}

//协议方法1：didAccept-当有客户端请求连接的时候会进到此方法
-(void)onSocket:(AsyncSocket *)sock didAcceptNewSocket:(AsyncSocket *)newSocket{
    NSLog(@"1.sock:%@ newSock:%@",sock,newSocket);
    NSLog(@"有客户端请求连接");
    //需要用新的socket对象把newSocket记住，不然newSocket就会被释放掉
    self.myNewSocket = newSocket;
    //有人进来了，就调用接收数据的方法（timeout超时为负数，则无限等待）
    [newSocket readDataWithTimeout:-1 tag:0];
}

//协议方法2：didConnectToHost-当连接成功的时候调用，只能用于获取对方的ip
-(void)onSocket:(AsyncSocket *)sock didConnectToHost:(NSString *)host port:(UInt16)port{
    NSLog(@"对方的ip地址为：%@",host);
    NSLog(@"2.sock:%@",sock);
}

//协议方法3：didReadData-读到数据的时候会进到此方法
-(void)onSocket:(AsyncSocket *)sock didReadData:(NSData *)data withTag:(long)tag{
    NSLog(@"3.sock:%@",sock);
    //把数据解析成字符串
    NSString *info = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    NSLog(@"接收到客户端的数据：%@",info);
    
    //回复数据（参数sock就是当前服务器和客户端建立连接成功的Socket）
    NSString *str = @"吃过了 都几点了 还不吃！！";
    NSData *strData = [str dataUsingEncoding:NSUTF8StringEncoding];
    [sock writeData:strData withTimeout:-1 tag:1];
}

//协议方法4：DidDisconnect-当连接断开的时候调用
-(void)onSocketDidDisconnect:(AsyncSocket *)sock{
    NSLog(@"4.sock:%@",sock);
    NSLog(@"连接断开了");
}

//当回复完成时调用
-(void)onSocket:(AsyncSocket *)sock didWriteDataWithTag:(long)tag{
    NSLog(@"回复客户端成功了！");
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
