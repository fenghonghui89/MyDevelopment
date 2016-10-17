//
//  MD_NSURLSession_VC.m
//  MyDevelopmentTest
//
//  Created by 冯鸿辉 on 16/4/15.
//  Copyright © 2016年 hanyfeng. All rights reserved.
//

#import "MD_NSURLSession_VC.h"

@interface MD_NSURLSession_VC ()<NSURLSessionDataDelegate,NSURLSessionDownloadDelegate>
@property(nonatomic,copy)NSString *content;
@property(nonatomic,strong)NSURLSession *session;
@property(nonatomic,strong)NSURLSessionDownloadTask *downloadTask;
@property(nonatomic,strong)NSData *resumeData;
@property (weak, nonatomic) IBOutlet UIProgressView *progressView;
@end

@implementation MD_NSURLSession_VC

#pragma mark - <<< vc lifecycle >>> -
- (void)viewDidLoad {
  
  [super viewDidLoad];
  
}

-(void)viewDidAppear:(BOOL)animated{

  [super viewDidAppear:animated];
  
  [self test_post_DataTask_block];
}

-(void)viewDidDisappear:(BOOL)animated{

  [super viewDidDisappear:animated];
}

#pragma mark - <<< method >>> -
#pragma mark - NSURLSessionDataTask
#pragma mark get block
-(void)test_get_DataTask{

  //request
  NSURL *url = [NSURL URLWithString:@"http://ws.webxml.com.cn/WebServices/WeatherWS.asmx/getRegionCountry?"];
  
  //session data task
  NSURLSession *session = [NSURLSession sharedSession];
  NSURLSessionDataTask *task = [session dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
    if (!error) {
      NSHTTPURLResponse *httpUrlRespon = (NSHTTPURLResponse *)response;
      NSLog(@"header:%@",[httpUrlRespon allHeaderFields]);
      
      NSString *content = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
      NSLog(@"content:%@",content);
    }else{
      NSLog(@"error:%@",[error localizedDescription]);
    }
  }];
  [task resume];
  
}

#pragma mark post block
-(void)test_post_DataTask_block{
  
  //request
  NSString *postBody = @"theRegionCode=广东";
  NSData *postBodyData = [postBody dataUsingEncoding:NSUTF8StringEncoding];
  
  NSURL *url = [NSURL URLWithString:@"http://ws.webxml.com.cn/WebServices/WeatherWS.asmx/getSupportCityDataset"];
  NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
  [request setHTTPMethod:@"POST"];
  [request setHTTPBody:postBodyData];
  
  //session data task
  NSURLSession *session = [NSURLSession sharedSession];
  NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
    if (!error) {
      NSHTTPURLResponse *httpUrlRespon = (NSHTTPURLResponse *)response;
      NSLog(@"header:%@",[httpUrlRespon allHeaderFields]);
      
      NSString *content = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
      NSLog(@"content:%@",content);
    }else{
      NSLog(@"error:%@",[error localizedDescription]);
    }
  }];
  
  [task resume];
}

#pragma mark post delegate
-(void)test_delegate_DataTask{
  
  //request
  NSString *postBody = @"theRegionCode=广东";
  NSData *postBodyData = [postBody dataUsingEncoding:NSUTF8StringEncoding];
  
  NSURL *url = [NSURL URLWithString:@"http://ws.webxml.com.cn/WebServices/WeatherWS.asmx/getSupportCityDataset"];
  NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
  [request setHTTPMethod:@"POST"];
  [request setHTTPBody:postBodyData];
  
  //session data task
  NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
  
  NSOperationQueue *queue = [[NSOperationQueue alloc] init];
  
  NSURLSession *session = [NSURLSession sessionWithConfiguration:config delegate:self delegateQueue:queue];
  
  NSURLSessionDataTask *task = [session dataTaskWithRequest:request];
  [task setTaskDescription:@"城市"];
  
  [task resume];
}

#pragma mark - NSURLSessionDownloadTask
#pragma mark block
-(void)test_block_download{

  NSURLSession *session = [NSURLSession sharedSession];
  
  NSURL *url = [NSURL URLWithString:@"http://www.sinaimg.cn/home/2016/0412/U6939P30DT20160412105616.jpg"];
  
  NSURLSessionDownloadTask *task = [session downloadTaskWithURL:url completionHandler:^(NSURL * _Nullable location, NSURLResponse * _Nullable response, NSError * _Nullable error) {
    
    if (!error) {
      //目标路径
      NSString *destinationPath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
      destinationPath = [destinationPath stringByAppendingPathComponent:response.suggestedFilename];
      NSURL *destinationURL = [NSURL fileURLWithPath:destinationPath];//转换为file url
      
      //location是沙盒中tmp文件夹下的一个临时url,文件下载后会存到这个位置,由于tmp中的文件随时可能被删除,所以我们需要自己需要把下载的文件挪到需要的地方
      NSError *terror;
      if ([[NSFileManager defaultManager] moveItemAtURL:location toURL:destinationURL error:&terror]) {
        NSLog(@"move success path:%@",[destinationURL absoluteString]);
      }else{
        NSLog(@"move error:%@ path:%@",[terror localizedDescription],[destinationURL absoluteString]);
      }
    }else{
      NSLog(@"download error:%@",[error localizedDescription]);
    }

    
  }];
  
  [task resume];
}

#pragma mark delegate
-(void)test_delegate_download{

  NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
  
  NSOperationQueue *queue = [[NSOperationQueue alloc] init];
  
  NSURLSession *session = [NSURLSession sessionWithConfiguration:config delegate:self delegateQueue:queue];
  
  NSURL *url = [NSURL URLWithString:@"http://www.sinaimg.cn/home/2016/0412/U6939P30DT20160412105616.jpg"];
  NSURLRequest *request = [NSURLRequest requestWithURL:url];
  
  NSURLSessionDownloadTask *downloadTask = [session downloadTaskWithRequest:request];
  [downloadTask resume];
  self.downloadTask = downloadTask;
  
}

#pragma mark suspend cancle
-(void)test_download_suspend_cancle{
  
  NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
  NSOperationQueue *queue = [NSOperationQueue new];
  NSURLSession *session = [NSURLSession sessionWithConfiguration:config delegate:self delegateQueue:queue];
  self.session = session;
  
  NSURL *url = [NSURL URLWithString:@"http://www.sinaimg.cn/home/2016/0412/U6939P30DT20160412105616.jpg"];
  NSURLRequest *request = [NSURLRequest requestWithURL:url];
  
  NSURLSessionDownloadTask *task = [session downloadTaskWithRequest:request];
  [task resume];
}

#pragma mark - NSURLSessionConfiguration
-(void)test_NSURLSessionConfiguration{

  NSURLSessionConfiguration *config = [NSURLSessionConfiguration backgroundSessionConfigurationWithIdentifier:@"background"];
  config.timeoutIntervalForRequest = 10;
  config.allowsCellularAccess = YES;
}
#pragma mark - <<< action >>> -

- (IBAction)btn1Tap:(id)sender {
  
  [self.downloadTask cancelByProducingResumeData:^(NSData * _Nullable resumeData) {
    self.resumeData = resumeData;
  }];
}

- (IBAction)btn2Tap:(id)sender {
  
  [self.downloadTask suspend];
  
}

- (IBAction)btn3Tap:(id)sender {
  
  self.downloadTask = [self.session downloadTaskWithResumeData:self.resumeData];
  [self.downloadTask resume];
}

#pragma mark - <<< callback >>> -
#pragma mark NSURLSessionDataDelegate
-(void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask didReceiveResponse:(NSURLResponse *)response completionHandler:(void (^)(NSURLSessionResponseDisposition))completionHandler{

  NSHTTPURLResponse *httpUrlRespon = (NSHTTPURLResponse *)response;
  NSLog(@"didReceiveResponse:%@",[httpUrlRespon allHeaderFields]);
  
  //允许处理服务器的响应，才会继续接收服务器返回的数据
  completionHandler(NSURLSessionResponseAllow);
  
  self.content = [NSMutableString string];
}

-(void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask didReceiveData:(NSData *)data{
  
  NSString *content = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
  self.content = [self.content stringByAppendingString:content];
  NSLog(@"didReceiveData:%@",content);
  NSLog(@"taskDescription:%@ id:%lu",dataTask.taskDescription,(unsigned long)dataTask.taskIdentifier);
}



#pragma mark NSURLSessionDownloadDelegate
-(void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didWriteData:(int64_t)bytesWritten totalBytesWritten:(int64_t)totalBytesWritten totalBytesExpectedToWrite:(int64_t)totalBytesExpectedToWrite{
  
  NSLog(@"didWriteData:%lld %lld %lld",bytesWritten,totalBytesWritten,totalBytesExpectedToWrite);
  CGFloat progress = 1.0 * totalBytesWritten / totalBytesExpectedToWrite;
  [self.progressView setProgress:progress animated:YES];
}

-(void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didFinishDownloadingToURL:(NSURL *)location{

  //目标路径
  NSString *destinationPath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
  destinationPath = [destinationPath stringByAppendingPathComponent:downloadTask.response.suggestedFilename];
  NSURL *destinationURL = [NSURL fileURLWithPath:destinationPath];//转换为file url
  
  //location是沙盒中tmp文件夹下的一个临时url,文件下载后会存到这个位置,由于tmp中的文件随时可能被删除,所以我们需要自己需要把下载的文件挪到需要的地方
  NSError *terror;
  if ([[NSFileManager defaultManager] moveItemAtURL:location toURL:destinationURL error:&terror]) {
    NSLog(@"move success path:%@",[destinationURL absoluteString]);
  }else{
    NSLog(@"move error:%@ path:%@",[terror localizedDescription],[destinationURL absoluteString]);
  }


}

//请求成功或者失败（如果失败，error有值）
#pragma mark NSURLSessionTeskDelegate
-(void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task didCompleteWithError:(NSError *)error{
  
  if (!error) {
    NSLog(@"didCompleteWithError sussess:%@",self.content);
  }else{
    NSLog(@"didCompleteWithError:%@",[error localizedDescription]);
    self.resumeData = error.userInfo[NSURLSessionDownloadTaskResumeData];//保存下载的数据
  }
  
  
}
@end
