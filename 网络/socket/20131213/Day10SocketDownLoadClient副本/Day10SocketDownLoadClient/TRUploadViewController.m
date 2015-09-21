//
//  TRUploadViewController.m
//  Day10SocketDownLoadClient
//
//  Created by HanyFeng on 13-12-19.
//  Copyright (c) 2013年 Hany. All rights reserved.
//

#import "TRUploadViewController.h"

@interface TRUploadViewController ()
@property (weak, nonatomic) IBOutlet UITextField *path_textField;
@property (weak, nonatomic) IBOutlet UITextField *ip_textField;

@end

@implementation TRUploadViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (IBAction)upload:(id)sender {
    NSString* filePath = self.path_textField.text;
    NSString* ip = self.ip_textField.text;
    
    NSString* fileName = [filePath lastPathComponent];
    NSData* fileData = [NSData dataWithContentsOfFile:filePath];
    NSString* headerString = [NSString stringWithFormat:@"upload&&%@&&%d",fileName,fileData.length];
    NSData* headerData = [headerString dataUsingEncoding:NSUTF8StringEncoding];
    
    NSMutableData* allFileData = [NSMutableData dataWithLength:100];
    [allFileData replaceBytesInRange:NSMakeRange(0, headerData.length) withBytes:headerData.bytes];
    [allFileData appendData:fileData];
    
    self.clientSocket = [[AsyncSocket alloc] initWithDelegate:self];
    [self.clientSocket connectToHost:ip onPort:8000 error:Nil];
    [self.clientSocket writeData:allFileData withTimeout:-1 tag:0];
    
}

-(void)onSocket:(AsyncSocket *)sock didWriteDataWithTag:(long)tag{
    NSLog(@"上传完成");
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
