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
@property (nonatomic, strong)NSMutableData *fileAllData;
@property (nonatomic) int reciveFileLength;
@property (nonatomic, copy) NSString *reciveFileName;
@end

@implementation TRViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.serverSocket = [[AsyncSocket alloc]initWithDelegate:self];
    [self.serverSocket acceptOnPort:8000 error:nil];
}

-(void)onSocket:(AsyncSocket *)sock didAcceptNewSocket:(AsyncSocket *)newSocket{
    self.myNewSocket = newSocket;
}

-(void)onSocket:(AsyncSocket *)sock didConnectToHost:(NSString *)host port:(UInt16)port{
    self.host = host;
    [self.myNewSocket readDataWithTimeout:-1 tag:0];
}

-(void)onSocket:(AsyncSocket *)sock didReadData:(NSData *)data withTag:(long)tag{
    NSData *headerData = [data subdataWithRange:NSMakeRange(0, 100)];
    NSString *headerString = [[NSString alloc]initWithData:headerData encoding:NSUTF8StringEncoding];//如果不是第一次的数据大部分为nil 也有个别情况会是乱码
    
    if (headerString && [headerString componentsSeparatedByString:@"&&"].count == 3) {//两个条件都满足 说明是第一部分数据
        
        NSArray *headers = [headerString componentsSeparatedByString:@"&&"];
        NSString *type = headers[0];
        
        if ([type isEqualToString:@"file"]) {
            NSString *fileName = [headers objectAtIndex:1];
            int fileLength = [headers[2] intValue];
            self.reciveFileLength = fileLength;
            self.reciveFileName = fileName;
            
            NSData *subFileData = [data subdataWithRange:NSMakeRange(100, data.length-100)];
            
            self.fileAllData = [NSMutableData data];
            [self.fileAllData appendData:subFileData];
            //判断文件是否接受完成
            if (self.fileAllData.length == self.reciveFileLength) {
                NSString *newPath = [@"/Users/apple/Desktop/未命名文件夹" stringByAppendingPathComponent:self.reciveFileName];
                [self.fileAllData writeToFile:newPath atomically:YES];
            }

        }else{//如果接收到的类型为文本的话
            NSData *messageData = [data subdataWithRange:NSMakeRange(100, data.length-100)];
            
            
            NSString *info = [[NSString alloc]initWithData:messageData encoding:NSUTF8StringEncoding];
            NSString *allText = [NSString stringWithFormat:@"\n%@说：%@",self.host,info];
            self.historyTV.text = [self.historyTV.text stringByAppendingString:allText];
        }
        
        
        
    }else{//如果接收到的不是第一次的数据 直接把接收到的数据加到fileAllData里面
        [self.fileAllData appendData:data];
        
        if (self.fileAllData.length == self.reciveFileLength) {
            NSString *newPath = [@"/Users/apple/Desktop/未命名文件夹" stringByAppendingPathComponent:self.reciveFileName];
            [self.fileAllData writeToFile:newPath atomically:YES];
        }
        
    }
    
    //继续读取后面的数据
    [sock readDataWithTimeout:-1 tag:0];
}

- (IBAction)clicked:(id)sender {
    NSString *ip = self.ipTF.text;
    if ([ip isEqualToString:@""]) {
        ip = @"127.0.0.1";//自己ip
    }
    NSString *sendInfo = self.sendInfoTF.text;
    NSMutableData *sendAllData = nil;
    //判断发送内容为文本还是文件
    if ([sendInfo hasPrefix:@"/"]) {
        //文件路径
        NSString *filePath = self.sendInfoTF.text;
        
        NSData *fileData = [NSData dataWithContentsOfFile:filePath];
        
        NSString *fileName = [filePath lastPathComponent];
        int fileLength = fileData.length;
        
        NSString *headerString = [NSString stringWithFormat:@"file&&%@&&%d",fileName,fileLength];
        
        
        sendAllData = [TRUtils getAllDataByHeaderString:headerString];
        
        [sendAllData appendData:fileData];
        
    }else{//如果是文本
        NSString *headerString = @"message&& &&";
        sendAllData = [TRUtils getAllDataByHeaderString:headerString];
        //如果是发文本 那就直接把文本转成data追加在消息头的后面
        [sendAllData appendData:[sendInfo dataUsingEncoding:NSUTF8StringEncoding]];
    }
    
    
    self.clientSocket = [[AsyncSocket alloc]initWithDelegate:self];
    
    [self.clientSocket connectToHost:ip onPort:8000 error:nil];
    
    
    [self.clientSocket writeData:sendAllData withTimeout:-1 tag:0];
    
    self.historyTV.text = [NSString stringWithFormat:@"%@\n我说：%@",self.historyTV.text,sendInfo];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
