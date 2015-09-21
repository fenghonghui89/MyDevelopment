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
@property (nonatomic, strong)NSMutableData *fileAllData;//用可变长data存放接收的数据
@property (nonatomic) int fileLength;
@end

@implementation TRViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.serverSocket = [[AsyncSocket alloc]initWithDelegate:self];
    [self.serverSocket acceptOnPort:8000 error:nil];
    self.fileAllData = [NSMutableData data];
}

-(void)onSocket:(AsyncSocket *)sock didConnectToHost:(NSString *)host port:(UInt16)port{
    NSLog(@"对方的ip地址为：%@",host);
}

-(void)onSocket:(AsyncSocket *)sock didAcceptNewSocket:(AsyncSocket *)newSocket{
    self.myNewSocket = newSocket;
    [self.myNewSocket readDataWithTimeout:-1 tag:0];
}

-(void)onSocket:(AsyncSocket *)sock didReadData:(NSData *)data withTag:(long)tag{
    NSLog(@"data:%d",data.length);
    [self.fileAllData appendData:data];//把读取到的数据添加到可变长data中
    
    if (self.fileAllData.length == self.fileLength) {//如果可变长data的长度等于文件的长度
        [self.fileAllData writeToFile:@"/Users/apple/Desktop/bbb.jpg" atomically:YES];
        NSLog(@"self.fileAllData:%d",self.fileAllData.length);
    }
    
    NSLog(@"哈哈哈");
    [sock readDataWithTimeout:-1 tag:0];//继续读取后面的数据（重复调用本方法）
}

/*------------------------------------------客户端代码------------------------------*/

- (IBAction)clicked:(id)sender {
    self.clientSocket = [[AsyncSocket alloc]initWithDelegate:self];
    [self.clientSocket connectToHost:@"127.0.0.1"onPort:8000 error:nil];
    
    //把要传输的文件封装到data中，并把文件长度赋值给属性方便其他方法调用
    NSData *data = [NSData dataWithContentsOfFile:@"/Users/apple/Desktop/Bahamas Aerial.jpg"];
    self.fileLength = data.length;
    
    [self.clientSocket writeData:data withTimeout:-1 tag:0];
}

//整个文件都传输完就会调用该方法
-(void)onSocket:(AsyncSocket *)sock didWriteDataWithTag:(long)tag{
    NSLog(@"发送成功了！");
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
