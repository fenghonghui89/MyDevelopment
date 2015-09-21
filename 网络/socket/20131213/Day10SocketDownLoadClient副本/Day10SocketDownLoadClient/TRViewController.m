//
//  TRViewController.m
//  Day10SocketDownLoadClient
//
//  Created by HanyFeng on 13-12-18.
//  Copyright (c) 2013年 Hany. All rights reserved.
//

#import "TRViewController.h"
#import "TRDownloadListController.h"
@interface TRViewController ()

@end

@implementation TRViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (IBAction)download:(id)sender {
    NSString* getDownloadList = @"list&& &&";
    NSData* getDownloadListData = [getDownloadList dataUsingEncoding:NSUTF8StringEncoding];
    
    self.clientSocket = [[AsyncSocket alloc] initWithDelegate:self];
    [self.clientSocket connectToHost:@"192.168.10.84" onPort:8000 error:Nil];
    [self.clientSocket writeData:getDownloadListData withTimeout:-1 tag:0];
    [self.clientSocket readDataWithTimeout:-1 tag:0];
}

-(void)onSocket:(AsyncSocket *)sock didReadData:(NSData *)data withTag:(long)tag{
    NSKeyedUnarchiver *unArch = [[NSKeyedUnarchiver alloc]initForReadingWithData:data];
    NSArray* downloadList = [unArch decodeObjectForKey:@"list"];
    [self performSegueWithIdentifier:@"downloadList" sender:downloadList];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([segue.identifier isEqualToString:@"downloadList"]) {
        TRDownloadListController* downloadList = segue.destinationViewController;
        downloadList.downloadList = (NSArray*)sender;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
