//
//  TRViewController.m
//  Day12HTTPAsync_my
//
//  Created by HanyFeng on 13-12-20.
//  Copyright (c) 2013年 Hany. All rights reserved.
//

#import "TRViewController.h"

@interface TRViewController ()
@property(nonatomic,strong)NSMutableData* allData;
@end

@implementation TRViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)clicked:(id)sender
{
    //创建请求地址
    NSString* musicPath = @"http://music.baidu.com/data/music/file?link=http://zhangmenshiting.baidu.com/data2/music/102797179/893081731387454461128.mp3?xcode=cec5c54d49b95f1f00a37d89b92a5a575b63952a32911b09&song_id=89308173";
    NSURL *url = [NSURL URLWithString:musicPath];
    
    //创建请求对象（同步）
    NSURLRequest* request = [NSURLRequest requestWithURL:url];
    
    //开始异步请求
    NSURLConnection* conn = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    if (conn) {
        NSLog(@"连接成功");
    }
}

#pragma mark - NSURL协议方法

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    NSLog(@"接收到响应！！");
    NSHTTPURLResponse *hur = (NSHTTPURLResponse *)response;
    NSDictionary *dic = [hur allHeaderFields];
    NSLog(@"response:%@",dic);
    self.allData = [NSMutableData data];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    NSLog(@"接收到数据：长度为%d",data.length);
    [self.allData appendData:data];
}

-(void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    NSLog(@"加载完成！！");
    [self.allData writeToFile:@"/Users/hanyfeng/Desktop/aaaaaaa.mp3" atomically:YES];
}

-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    NSLog(@"didFailWithError！！%@",[error localizedDescription]);//错误的本地化描述
}



@end
