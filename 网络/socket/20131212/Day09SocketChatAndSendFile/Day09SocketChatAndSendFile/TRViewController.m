//
//  TRViewController.m
//  Day09SocketChatAndSendFile
//
//  Created by HanyFeng on 13-12-18.
//  Copyright (c) 2013年 Hany. All rights reserved.
//

#import "TRViewController.h"
#import "TRTool.h"
@interface TRViewController ()
@property (weak, nonatomic) IBOutlet UITextField *content_textField;
@property (weak, nonatomic) IBOutlet UITextField *ip_textField;
@property (weak, nonatomic) IBOutlet UITextView *content_textView;

@property(nonatomic,strong)NSMutableData* receiveFileData;
@property(nonatomic,assign)int receiveFileDataLength;
@property(nonatomic,strong)NSString* fileName;

@property(nonatomic,strong)NSString* host;

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
    NSLog(@"%@",self.host);
    [self.myNewSocket readDataWithTimeout:-1 tag:0];
}

-(void)onSocket:(AsyncSocket *)sock didReadData:(NSData *)data withTag:(long)tag{
    NSData* headerData = [data subdataWithRange:NSMakeRange(0, 100)];
    NSString* headerString = [[NSString alloc] initWithData:headerData encoding:NSUTF8StringEncoding];
    NSArray* array = [headerString componentsSeparatedByString:@"&&"];
    NSString* dataType = [array objectAtIndex:0];
    
    if ([dataType isEqualToString:@"file"] && array.count == 3) {
        self.fileName = [array objectAtIndex:1];
        self.receiveFileDataLength = [[array objectAtIndex:2] intValue];
        self.receiveFileData = [NSMutableData data];
        NSData *subFileData = [data subdataWithRange:NSMakeRange(100, data.length-100)];
        [self.receiveFileData appendData:subFileData];
        
        if (self.receiveFileData.length == self.receiveFileDataLength) {
            NSString* filePath = [@"/Users/apple/Desktop/未命名文件夹" stringByAppendingPathComponent:self.fileName];
            NSLog(@"%@",filePath);
            [self.receiveFileData writeToFile:filePath atomically:YES];
        }
        
    }else if([dataType isEqualToString:@"message"]){
        int allFileDataLength = [[array objectAtIndex:2] intValue];
        NSMutableData* allFileData = [NSMutableData data];
        NSData *subFileData = [data subdataWithRange:NSMakeRange(100, data.length-100)];
        [allFileData appendData:subFileData];
        
        if (allFileData.length == allFileDataLength) {
            NSString* message = [[NSString alloc] initWithData:allFileData encoding:NSUTF8StringEncoding];
            message = [NSString stringWithFormat:@"\n%@说：%@",self.host,message];
            self.content_textView.text = [self.content_textView.text stringByAppendingString:message];
        }
        
    }else{
        [self.receiveFileData appendData:data];
        if (self.receiveFileData.length == self.receiveFileDataLength) {
            NSString* filePath = [@"/Users/apple/Desktop/未命名文件夹" stringByAppendingPathComponent:self.fileName];
            [self.receiveFileData writeToFile:filePath atomically:YES];
        }
    }
    [sock readDataWithTimeout:-1 tag:0];
}

- (IBAction)send_button:(id)sender {
    
    NSString* content = self.content_textField.text;
    NSString* ip = self.ip_textField.text;
    if ([ip isEqualToString:@""]) {
        ip = @"127.0.0.1";
    }
    
    NSMutableData* allData = [NSMutableData dataWithLength:100];
    
    if ([content hasPrefix:@"/"]) {
        NSData* fileData = [[NSData alloc] initWithContentsOfFile:content];
        //NSData* fileData=[NSData dataWithContentsOfFile:content];这样也可以
        NSString* fileName = [content lastPathComponent];
        NSString* headerString = [NSString stringWithFormat:@"file&&%@&&%d",fileName,fileData.length];
        
//        NSData* headerData = [headerString dataUsingEncoding:NSUTF8StringEncoding];
//        [allData replaceBytesInRange:NSMakeRange(0, headerData.length) withBytes:headerData.bytes];
        allData = [TRTool appendHeaderDataOf:headerString ToFileData:allData];
        
        [allData appendData:fileData];
    }else{
        NSData* fileData = [content dataUsingEncoding:NSUTF8StringEncoding];
        NSString* headerString = [NSString stringWithFormat:@"message&& &&%d",fileData.length];
        
//        NSData* headerData = [headerString dataUsingEncoding:NSUTF8StringEncoding];
//        [allData replaceBytesInRange:NSMakeRange(0, headerData.length) withBytes:headerData.bytes];
        allData = [TRTool appendHeaderDataOf:headerString ToFileData:allData];
        
        [allData appendData:fileData];
    }
    
    self.clientSocket = [[AsyncSocket alloc]initWithDelegate:self];
    [self.clientSocket connectToHost:ip onPort:8000 error:nil];
    [self.clientSocket writeData:allData withTimeout:-1 tag:0];
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
