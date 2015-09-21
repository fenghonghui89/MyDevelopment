//
//  TRViewController.m
//  Day10SocketDownLoadServer
//
//  Created by HanyFeng on 13-12-18.
//  Copyright (c) 2013年 Hany. All rights reserved.
//

#import "TRViewController.h"
#import "TRDownloadListViewController.h"

@interface TRViewController ()

@property (weak, nonatomic) IBOutlet UITextView *content_textView;
@property(nonatomic,strong)NSString* host;

@property(nonatomic,strong)NSMutableData* fileData;
@property(nonatomic,strong)NSString* fileName;
@property(nonatomic,assign)int fileLength;

@property(nonatomic,strong)NSMutableArray* filePathAndLength_array;
@end

@implementation TRViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	self.serverSocket = [[AsyncSocket alloc] initWithDelegate:self];
    [self.serverSocket acceptOnPort:8000 error:nil];
    self.filePathAndLength_array = [NSMutableArray array];
}

-(void)onSocket:(AsyncSocket *)sock didAcceptNewSocket:(AsyncSocket *)newSocket{
    self.myNewSocket = newSocket;
    NSString* message = @"\n有人连接";
    self.content_textView.text = [self.content_textView.text stringByAppendingString:message];
}

-(void)onSocket:(AsyncSocket *)sock didConnectToHost:(NSString *)host port:(UInt16)port{
    self.host = host;
    NSString* message = [NSString stringWithFormat:@"\n对方IP为%@",self.host];
    self.content_textView.text = [self.content_textView.text stringByAppendingString:message];
    [self.myNewSocket readDataWithTimeout:-1 tag:0];
}

-(void)onSocket:(AsyncSocket *)sock didReadData:(NSData *)data withTag:(long)tag{
    NSData* headerData = [data subdataWithRange:NSMakeRange(0, 100)];
    NSString *headerString = [[NSString alloc]initWithData:headerData encoding:NSUTF8StringEncoding];
    NSArray* array = [headerString componentsSeparatedByString:@"&&"];
    NSString* fileType = [array objectAtIndex:0];
    
    if ([headerString componentsSeparatedByString:@"&&"].count == 3 && [fileType isEqualToString: @"upload"]) {
        self.fileName = [array objectAtIndex:1];
        self.fileLength = [(NSString*)[array objectAtIndex:2] intValue];
        self.fileData = [NSMutableData data];
        
        NSData* subFileData = [data subdataWithRange:NSMakeRange(100, data.length-100)];
        [self.fileData appendData:subFileData];
        if (self.fileData.length == self.fileLength) {
            NSString* filePath = [@"/Users/apple/Desktop/未命名文件夹" stringByAppendingPathComponent:self.fileName];
            [self.fileData writeToFile:filePath atomically:YES];
            
            NSString* message = [NSString stringWithFormat:@"\n文件：%@ 上传完成",self.fileName];
            self.content_textView.text = [self.content_textView.text stringByAppendingString:message];
            
            NSString* filePathAndLength = [NSString stringWithFormat:@"%@&&%d",filePath,self.fileLength];
            [self.filePathAndLength_array addObject:filePathAndLength];
        }
        
    }else if([fileType isEqualToString: @"list"]){
        NSMutableData* listData = [NSMutableData data];
        NSKeyedArchiver* arch = [[NSKeyedArchiver alloc] initForWritingWithMutableData:listData];
        [arch encodeObject:self.filePathAndLength_array forKey:@"list"];
        [arch finishEncoding];
        [sock writeData:data withTimeout:-1 tag:0];
        
    }else{
        [self.fileData appendData:data];
        if (self.fileData.length == self.fileLength) {
            NSString* filePath = [@"/Users/apple/Desktop/未命名文件夹" stringByAppendingPathComponent:self.fileName];
            [self.fileData writeToFile:filePath atomically:YES];
            
            NSString* message = [NSString stringWithFormat:@"\n文件：%@ 上传完成",self.fileName];
            self.content_textView.text = [self.content_textView.text stringByAppendingString:message];
            
            NSString* filePathAndLength = [NSString stringWithFormat:@"%@&&%d",filePath,self.fileLength];
            [self.filePathAndLength_array addObject:filePathAndLength];
        }
    }

    [self.myNewSocket readDataWithTimeout:-1 tag:0];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([segue.identifier isEqualToString:@"downloadList"]) {
        TRDownloadListViewController* downloadList = segue.destinationViewController;
        downloadList.filePathAndLength_array = self.filePathAndLength_array;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
