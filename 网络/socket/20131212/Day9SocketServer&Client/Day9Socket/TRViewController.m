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
@property (nonatomic, strong)AsyncSocket *clientSocket;
@end

@implementation TRViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    //创建服务器
    self.serverSocket = [[AsyncSocket alloc]initWithDelegate:self];
    NSError *err = nil;
    [self.serverSocket acceptOnPort:8000 error:&err];
    if (err) {
        NSLog(@"%@",[err localizedDescription]);
    }
}

//当有客户端请求连接的时候会进到此方法
-(void)onSocket:(AsyncSocket *)sock didAcceptNewSocket:(AsyncSocket *)newSocket{
    NSLog(@"有客户端请求连接");
    //需要把newSocket记住 不然newSocket就会被释放掉
    self.myNewSocket = newSocket;
    
    //有人进来了  就调用接收数据的方法
    [newSocket readDataWithTimeout:-1 tag:0];
}

//当连接成功的时候调用 只要用于获取对方的ip
-(void)onSocket:(AsyncSocket *)sock didConnectToHost:(NSString *)host port:(UInt16)port{
    NSLog(@"对方的ip地址为：%@",host);
}

//读到数据的时候会进到此方法
-(void)onSocket:(AsyncSocket *)sock didReadData:(NSData *)data withTag:(long)tag{
    if (tag == 0) {//表示是客户端发给服务器
        NSString *info = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
        NSLog(@"接收到客户端的数据：-----%@",info);
        
        //参数sock 就是当前服务器和客户端建立连接成功的Socket
        NSString *str = @"吃过了 都几点了 还不吃！！";
        NSData *strData = [str dataUsingEncoding:NSUTF8StringEncoding];
        
        //给对方回复数据
        [sock writeData:strData withTimeout:-1 tag:0];

    }else{//服务器给客户端回复
        NSString *info = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
        NSLog(@"接收到服务器的数据：-----%@",info);

    }
}

//当连接断开的时候调用
-(void)onSocketDidDisconnect:(AsyncSocket *)sock{
    
}

//客户端代码
- (IBAction)clicked:(id)sender {
    
    //    1.创建Socket对象
    self.clientSocket = [[AsyncSocket alloc]initWithDelegate:self];
    //2.请求建立连接
    [_clientSocket connectToHost:@"192.168.10.79"onPort:8000 error:nil];
    NSString *str = @"你好！！吃了没！";
    NSData *data = [str dataUsingEncoding:NSUTF8StringEncoding];
    [_clientSocket writeData:data withTimeout:-1 tag:0];
    
    //写完数据之后 就直接调用读取数据的方法
    [_clientSocket readDataWithTimeout:-1 tag:1];
    
    //    [clientSocket disconnect]; 断开连接
}

-(void)onSocket:(AsyncSocket *)sock didWriteDataWithTag:(long)tag{
    
    if (tag == 0) {
        NSLog(@"发送到服务器成功了！");
    }else if(tag == 1){
        NSLog(@"回复客户端成功了！");
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
