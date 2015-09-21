//
//  TRViewController.m
//  Day9SocketClient
//
//  Created by Tarena on 13-12-12.
//  Copyright (c) 2013年 Tarena. All rights reserved.
//

#import "TRViewController.h"

@interface TRViewController ()
@property(nonatomic,strong)AsyncSocket* clientSocket;
@end

@implementation TRViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
}

//发送按钮
- (IBAction)clicked:(id)sender {
    //1.创建Socket对象
    self.clientSocket = [[AsyncSocket alloc]initWithDelegate:self];
    
    //2.请求建立连接
    [self.clientSocket connectToHost:@"192.168.1.1" onPort:8000 error:nil];
    
    //3.发送数据
    NSString *str = @"你好！！吃了没！";
    NSData *data = [str dataUsingEncoding:NSUTF8StringEncoding];
    [self.clientSocket writeData:data withTimeout:-1 tag:0];
    
    //5.接收服务器回复的数据（didReadData方法不会自动调用，需要先执行此方法）
    [self.clientSocket readDataWithTimeout:-1 tag:0];
    
    //[clientSocket disconnect]; 断开连接
}

//4.当发送完成时调用
-(void)onSocket:(AsyncSocket *)sock didWriteDataWithTag:(long)tag{
    NSLog(@"发送到服务器成功了！");
}

//6.接收服务器回复数据的方法
-(void)onSocket:(AsyncSocket *)sock didReadData:(NSData *)data withTag:(long)tag{
    NSString *str = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    NSLog(@"接收到服务器数据：%@",str);
}

-(void)onSocket:(AsyncSocket *)sock didConnectToHost:(NSString *)host port:(UInt16)port{
    NSLog(@"对方IP:%@",host);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
