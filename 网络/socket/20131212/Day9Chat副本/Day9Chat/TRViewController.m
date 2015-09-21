//
//  TRViewController.m
//  Day9Chat
//
//  Created by Tarena on 13-12-12.
//  Copyright (c) 2013年 Tarena. All rights reserved.
//

#import "TRViewController.h"

@interface TRViewController ()
@property (weak, nonatomic) IBOutlet UITextView *historyTV;
@property (weak, nonatomic) IBOutlet UITextField *sendInfoTF;
@property (weak, nonatomic) IBOutlet UITextField *ipTF;
@property (nonatomic, copy)NSString *host;
@end

@implementation TRViewController
//服务器端代码
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.serverSocket = [[AsyncSocket alloc]initWithDelegate:self];
    [self.serverSocket acceptOnPort:6000 error:nil];
}

-(void)onSocket:(AsyncSocket *)sock didAcceptNewSocket:(AsyncSocket *)newSocket{
    NSLog(@"有人连接");
    self.myNewSocket = newSocket;
}

-(void)onSocket:(AsyncSocket *)sock didConnectToHost:(NSString *)host port:(UInt16)port{
    NSLog(@"取得IP");
    self.host = host;
    [self.myNewSocket readDataWithTimeout:-1 tag:0];//先取得IP在读取数据
}

-(void)onSocket:(AsyncSocket *)sock didReadData:(NSData *)data withTag:(long)tag{
    NSLog(@"读取数据");
    NSString *info = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    NSString *allText = [NSString stringWithFormat:@"\n%@说：%@",self.host,info];
    self.historyTV.text = [self.historyTV.text stringByAppendingString:allText];
}


//客户端代码
- (IBAction)clicked:(id)sender {
    NSString *ip = self.ipTF.text;
    if ([ip isEqualToString:@""]) {
        ip = @"127.0.0.1";//自己ip
    }else{
        ip = [NSString stringWithFormat:@"192.168.10.%@",self.ipTF.text];
    }
    
    NSString *sendInfo = self.sendInfoTF.text;
    self.clientSocket = [[AsyncSocket alloc]initWithDelegate:self];
    [self.clientSocket connectToHost:ip onPort:6000 error:nil];
    [self.clientSocket writeData:[sendInfo dataUsingEncoding:NSUTF8StringEncoding] withTimeout:-1 tag:0];
    
    self.historyTV.text = [NSString stringWithFormat:@"%@\n我说：%@",self.historyTV.text,sendInfo];
}

-(void)onSocket:(AsyncSocket *)sock didWriteDataWithTag:(long)tag{
    NSLog(@"发送成功");
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
