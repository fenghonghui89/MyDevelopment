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

-(void)onSocket:(AsyncSocket *)sock didConnectToHost:(NSString *)host port:(UInt16)port{
    NSLog(@"对方的ip地址为：%@",host);
}

-(void)onSocket:(AsyncSocket *)sock didAcceptNewSocket:(AsyncSocket *)newSocket{
    self.myNewSocket = newSocket;
    [self.myNewSocket readDataWithTimeout:-1 tag:0];
}

-(void)onSocket:(AsyncSocket *)sock didReadData:(NSData *)data withTag:(long)tag{
    NSData *headerData = [data subdataWithRange:NSMakeRange(0, 100)];//读取接收到数据的前100个字节
    NSString *headerString = [[NSString alloc]initWithData:headerData encoding:NSUTF8StringEncoding];//把该数据转换为字符串（一个未经修改的data的前100个字节大部分为nil，也可能通过编码表转换后是乱码）
    
    if (headerString && [headerString componentsSeparatedByString:@"&&"].count == 2) {//按照设计，如果数据的前100个字节是字符串且可以按照分隔符分割成2份，则认为是第一分部数据（即自行定义的消息头文件：文件名&&文件长度）
        
        //把消息头文件转换为文件名和文件长度
        NSArray *headers = [headerString componentsSeparatedByString:@"&&"];
        NSString *fileName = [headers objectAtIndex:0];
        int fileLength = [headers[1] intValue];
        self.reciveFileLength = fileLength;
        self.reciveFileName = fileName;
        NSLog(@"%@ %d",self.reciveFileName,self.reciveFileLength);
        
        //如果确定这次接收的数据是第一分部数据（含消息头文件），则初始化可变长data，把剩余的数据放入可变长data
        NSData *subFileData = [data subdataWithRange:NSMakeRange(100, data.length-100)];
        self.fileAllData = [NSMutableData data];
        [self.fileAllData appendData:subFileData];
        
        //判断文件是否接受完成，完成则输出文件
        if (self.fileAllData.length == self.reciveFileLength) {
            NSString *newPath = [@"/Users/apple/Desktop/未命名文件夹" stringByAppendingPathComponent:self.reciveFileName];
            [self.fileAllData writeToFile:newPath atomically:YES];
        }
        
    }else {
        
        //如果接收到的不是第一次的数据，直接把接收到的数据加到fileAllData里面
        [self.fileAllData appendData:data];
        
        //判断文件是否接受完成，完成则输出文件
        if (self.fileAllData.length == self.reciveFileLength) {
            NSString *newPath = [@"/Users/apple/Desktop/未命名文件夹" stringByAppendingPathComponent:self.reciveFileName];
            [self.fileAllData writeToFile:newPath atomically:YES];
        }
    }
    
    //继续读取后面的数据
    [sock readDataWithTimeout:-1 tag:0];
}

/*---------------------------------------------客户端代码---------------------------------------------*/

- (IBAction)clicked:(id)sender {
    self.clientSocket = [[AsyncSocket alloc]initWithDelegate:self];
    [self.clientSocket connectToHost:@"127.0.0.1"onPort:8000 error:nil];
    
    //把文件用data封装
    NSString *filePath = @"/Users/apple/Desktop/Bahamas Aerial.jpg";
    NSData *fileData = [NSData dataWithContentsOfFile:filePath];
    NSLog(@"%d",fileData.length);
    
    //把文件名和文件长度组合成字符串，并用data封装成消息头
    NSString *fileName = [filePath lastPathComponent];
    int fileLength = fileData.length;
    NSString *headerString = [NSString stringWithFormat:@"%@&&%d",fileName,fileLength];
    NSData *headerData = [headerString dataUsingEncoding:NSUTF8StringEncoding];
    
    //创建一个长度为100个字节的可变长data，把消息头放进可变长data，然后把文件数据附加到消息头后面
    NSMutableData *sendAllData = [NSMutableData dataWithLength:100];
    //NSMutableData* sendAllData = [NSMutableData data];//错误
    [sendAllData replaceBytesInRange:NSMakeRange(0, headerData.length) withBytes:headerData.bytes];//把消息头用二进制表示，并替换可变长data
    [sendAllData appendData:fileData];
    
    //传输数据
    [self.clientSocket writeData:sendAllData withTimeout:-1 tag:0];
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
