//
//  MD_Scocket_ClientServer_VC.m
//  MyDevelopmentTest
//
//  Created by 冯鸿辉 on 16/3/28.
//  Copyright © 2016年 hanyfeng. All rights reserved.
//


#import "MD_Socket_SendFile_VC.h"
#import "AsyncSocket.h"
#import "NSString+Category.h"
#import "MD_Socket_SendFile_TVC.h"
@interface MD_Socket_SendFile_VC ()<AsyncSocketDelegate,UITextViewDelegate,UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *userNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *ipTextField;
@property (weak, nonatomic) IBOutlet UITextView *contentTextView;
@property (weak, nonatomic) IBOutlet UITextView *messageTextView;

@property(nonatomic,copy)NSString *ip;//对方ip
@property(nonatomic,strong)NSMutableData *allFileData;
@property(nonatomic,copy)NSString *fileName;
@property(nonatomic,assign)NSInteger fileLength;

@property(nonatomic,strong)AsyncSocket *clientSocket;
@property(nonatomic,strong)AsyncSocket *serverSocket;
@property(nonatomic,strong)AsyncSocket *myNewSocket;
@property(nonatomic,strong)AsyncSocket *currentSocket;
@end

@implementation MD_Socket_SendFile_VC

#pragma mark - < vc lifecycle > -
- (void)viewDidLoad {
  
  [super viewDidLoad];
  
}

-(void)viewDidAppear:(BOOL)animated{
  
  [super viewDidAppear:animated];
  
  [self customInit];
}

#pragma mark - < method > -
-(void)customInit{
  
  self.serverSocket = [[AsyncSocket alloc] initWithDelegate:self];
  [self.serverSocket acceptOnPort:8000 error:nil];
  
  if ([[[MDTool sharedInstance] machineName] isEqualToString:@"iPhone7,2"]) {
    self.ip = @"192.168.5.108";
  }else{
    self.ip = @"192.168.5.123";
  }
//  self.ip = @"127.0.0.1";
  
  self.userNameTextField.returnKeyType = UIReturnKeyDone;
  self.userNameTextField.text = [NSString stringWithFormat:@"%d号",arc4random()%20];
  self.userNameTextField.delegate = self;
  
  self.ipTextField.returnKeyType = UIReturnKeyDone;
  self.ipTextField.text = self.ip;
  self.ipTextField.delegate = self;
  
  self.contentTextView.returnKeyType = UIReturnKeyDone;
  self.contentTextView.text = [NSString stringWithFormat:@"你好我是%@",self.userNameTextField.text];
  self.contentTextView.delegate = self;
  
  self.messageTextView.editable = NO;
  self.messageTextView.text = @"";
}

-(void)refreshMessageTextView:(NSString *)message{
  NSLog(@"%@",message);
  NSString *am = [self.messageTextView.text stringByAppendingString:[message stringByAppendingString:@"\n"]];
  self.messageTextView.text = am;
}

-(void)fileStone{
  
  NSString *path = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
  path = [path stringByAppendingPathComponent:@"testDir"];
  
  NSFileManager *fm = [NSFileManager defaultManager];
  if (![fm fileExistsAtPath:path]) {
    BOOL b = [fm createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:nil];
    if (b) {
      path = [path stringByAppendingPathComponent:self.fileName];
      [self.allFileData writeToFile:path atomically:YES];
      
      UIAlertView *av = [[UIAlertView alloc] initWithTitle:@"finish" message:self.fileName delegate:self cancelButtonTitle:@"ok" otherButtonTitles:nil];
      [av show];
    }else{
      UIAlertView *av = [[UIAlertView alloc] initWithTitle:@"创建文件夹失败" message:nil delegate:self cancelButtonTitle:@"ok" otherButtonTitles:nil];
      [av show];
    }
  }else{
    path = [path stringByAppendingPathComponent:self.fileName];
    [self.allFileData writeToFile:path atomically:YES];
    
    UIAlertView *av = [[UIAlertView alloc] initWithTitle:@"finish" message:self.fileName delegate:self cancelButtonTitle:@"ok" otherButtonTitles:nil];
    [av show];
  }

}

#pragma mark - < action > -

- (IBAction)nextPageBtnTap:(id)sender {
  
  MD_Socket_SendFile_TVC *vc = [[MD_Socket_SendFile_TVC alloc] initWithNibName:@"MD_Socket_SendFile_TVC" bundle:nil];
  [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)sendFileBtnTap:(id)sender {
  
  //网络图片
  NSString *filePath = @"http://n.sinaimg.cn/edu/20160329/lamE-fxqswxx0303687.jpg";
  
  NSURL *url = [NSURL URLWithString:filePath];
  NSURLRequest *request = [NSURLRequest requestWithURL:url];
  NSHTTPURLResponse *response = nil;
  NSError *error = nil;
  NSData *fileData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
  if (error) {
    NSLog(@"error:%@",[error localizedDescription]);
  }else{
    NSLog(@"response:%@",[response allHeaderFields]);
  }
  
  //本地图片 模拟器用
//  NSString *filePath = @"/Users/hanyfeng/Desktop/btn_good_on@2x.png";
//  NSData *fileData = [NSData dataWithContentsOfFile:filePath];
  
  //组装数据
  NSString *fileName = [filePath lastPathComponent];
  NSInteger fileLength = fileData.length;
  NSString *headerStr = [NSString stringWithFormat:@"file&&%@&&%ld",fileName,(long)fileLength];
  NSData *headerData = [headerStr dataUsingEncoding:NSUTF8StringEncoding];
  
  NSMutableData *allData = [NSMutableData dataWithLength:100];
  [allData replaceBytesInRange:NSMakeRange(0, headerData.length) withBytes:headerData.bytes];
  [allData appendData:fileData];
  
  //发送
  if (![self.ip validIpAddress]) {
    UIAlertView *av = [[UIAlertView alloc] initWithTitle:@"ip不对" message:nil delegate:self cancelButtonTitle:@"好的" otherButtonTitles: nil];
    [av show];
    return;
  }
  
  if (self.currentSocket) {
    [self.currentSocket writeData:allData withTimeout:-1 tag:1001];
  }else{
    self.clientSocket = [[AsyncSocket alloc] initWithDelegate:self];
    [self.clientSocket connectToHost:self.ip onPort:8000 error:nil];
    [self.clientSocket writeData:allData withTimeout:-1 tag:1001];
  }
}


- (IBAction)sendBtnTap:(id)sender {
  
  //组装数据
  NSString *headerStr = @"message&&__&&";
  NSData *headerData = [headerStr dataUsingEncoding:NSUTF8StringEncoding];
  
  NSMutableData *allData = [NSMutableData dataWithLength:100];
  [allData replaceBytesInRange:NSMakeRange(0, headerData.length) withBytes:headerData.bytes];
  
  NSString *content = [NSString stringWithFormat:@"%@:%@",self.userNameTextField.text,self.contentTextView.text];
  NSData *contentData = [content dataUsingEncoding:NSUTF8StringEncoding];
  
  [allData appendData:contentData];
  
  //发送
  if (![self.ip validIpAddress]) {
    UIAlertView *av = [[UIAlertView alloc] initWithTitle:@"ip不对" message:nil delegate:self cancelButtonTitle:@"好的" otherButtonTitles: nil];
    [av show];
    return;
  }
  
  if (self.currentSocket) {
    [self.currentSocket writeData:allData withTimeout:-1 tag:1001];
  }else{
    self.clientSocket = [[AsyncSocket alloc] initWithDelegate:self];
    [self.clientSocket connectToHost:self.ip onPort:8000 error:nil];
    [self.clientSocket writeData:allData withTimeout:-1 tag:1001];
  }
}

- (IBAction)closeBtnTap:(id)sender {
  
  [self.clientSocket disconnect];
  [self.myNewSocket disconnect];
  [self.currentSocket disconnect];
  self.currentSocket = nil;
  self.clientSocket = nil;
  self.myNewSocket = nil;
}

- (IBAction)clearBtnTap:(id)sender {
  
  self.messageTextView.text = @"";
}

#pragma mark - < callback > -
#pragma mark AsyncSocketDelegate
-(void)onSocket:(AsyncSocket *)sock didAcceptNewSocket:(AsyncSocket *)newSocket{
  
  [self refreshMessageTextView:@"<系统>:有客户端连接进来"];
  
  self.myNewSocket = newSocket;//必须要有，否则一连接就会中断
  [self.myNewSocket readDataWithTimeout:-1 tag:1003];//必须要有，否则服务端后面收不到数据
  
}

-(void)onSocket:(AsyncSocket *)sock didReadData:(NSData *)data withTag:(long)tag{
  
  [self refreshMessageTextView:[NSString stringWithFormat:@"<系统>：收到数据tag:%ld",tag]];
  
  NSData *headerData = [data subdataWithRange:NSMakeRange(0, 100)];
  NSString *headerStr = [[NSString alloc] initWithData:headerData encoding:NSUTF8StringEncoding];//如果不是第一次的数据大部分为nil 也有个别情况会是乱码
  NSArray *arr = [headerStr componentsSeparatedByString:@"&&"];
  
  if (headerStr && arr.count == 3)//证明是自定义插入数据
  {
    if ([arr[0] isEqualToString:@"file"])//发送的是文件
    {
      self.fileName = arr[1];
      self.fileLength = [arr[2] integerValue];
      NSData *subFileData = [data subdataWithRange:NSMakeRange(100, data.length-100)];
      
      self.allFileData = [NSMutableData data];
      [self.allFileData appendData:subFileData];
      
      if (self.allFileData.length == self.fileLength)
      {
        [self fileStone];
      }
      
    }
    
    else//发送的是文本
    {
      NSData *contentData = [data subdataWithRange:NSMakeRange(100, data.length-100)];
      NSString *content = [[NSString alloc] initWithData:contentData encoding:NSUTF8StringEncoding];
      [self refreshMessageTextView:content];
    }
    
  }
  
  else//证明是文件的余下数据
  {
    [self.allFileData appendData:data];
    if (self.allFileData.length == self.fileLength)
    {
      [self fileStone];
    }
  }
  
  self.currentSocket = sock;//实测跟didWriteDataWithTag的一样，跟clientSocket不一样
  [self.currentSocket readDataWithTimeout:-1 tag:1004];
}

-(void)onSocket:(AsyncSocket *)sock didWriteDataWithTag:(long)tag{
  
  [self refreshMessageTextView:[NSString stringWithFormat:@"<系统>:发送成功"]];
  [self refreshMessageTextView:[NSString stringWithFormat:@"我:%@",self.contentTextView.text]];
  
  self.currentSocket = sock;//实测跟didReadData的一样，跟clientSocket不一样
  [self.currentSocket readDataWithTimeout:-1 tag:1005];
}

-(void)onSocket:(AsyncSocket *)sock didConnectToHost:(NSString *)host port:(UInt16)port{
  
  [self refreshMessageTextView:[NSString stringWithFormat:@"<系统>:已经连接上：%@ %ld",host,(long)port]];
  
  self.ip = host;
  self.ipTextField.text = host;
  
}

-(void)onSocketDidDisconnect:(AsyncSocket *)sock{
  
  [self refreshMessageTextView:@"<系统>:已经断开连接"];
  
  self.currentSocket = nil;
  self.clientSocket = nil;
  self.myNewSocket = nil;
}

-(void)onSocket:(AsyncSocket *)sock willDisconnectWithError:(NSError *)err{
  
  [self refreshMessageTextView:[NSString stringWithFormat:@"<系统>:连接出错中断：%@",[err localizedDescription]]];
  
  self.currentSocket = nil;
  self.clientSocket = nil;
  self.myNewSocket = nil;
}


#pragma mark UITextViewDelegate
-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
  
  if ([text isEqualToString:@"\n"]) {
    [self.contentTextView resignFirstResponder];
    return NO;
  }
  
  return YES;
}
#pragma mark UITextFieldDelegate
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
  
  [textField resignFirstResponder];
  
  if ([textField isEqual:self.ipTextField]) {
    self.ip = textField.text;
  }
  
  
  return YES;
}
@end
