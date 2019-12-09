//
//  MD_Scocket_ClientServer_VC.m
//  MyDevelopmentTest
//
//  Created by 冯鸿辉 on 16/3/28.
//  Copyright © 2016年 hanyfeng. All rights reserved.
//


#import "MD_Scocket_ClientServer_VC.h"
#import "AsyncSocket.h"
#import "NSString+VerifyRegex.h"
@interface MD_Scocket_ClientServer_VC ()<AsyncSocketDelegate,UITextViewDelegate,UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *userNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *ipTextField;
@property (weak, nonatomic) IBOutlet UITextView *contentTextView;
@property (weak, nonatomic) IBOutlet UITextView *messageTextView;

@property(nonatomic,copy)NSString *ip;//对方ip


@property(nonatomic,strong)AsyncSocket *clientSocket;
@property(nonatomic,strong)AsyncSocket *serverSocket;
@property(nonatomic,strong)AsyncSocket *myNewSocket;
@property(nonatomic,strong)AsyncSocket *currentSocket;
@end

@implementation MD_Scocket_ClientServer_VC

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
    self.ip = @"192.168.5.157";
  }else{
    self.ip = @"192.168.5.142";
  }
  
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
  
  NSString *am = [self.messageTextView.text stringByAppendingString:[message stringByAppendingString:@"\n"]];
  self.messageTextView.text = am;
}

#pragma mark - < action > -
- (IBAction)sendBtnTap:(id)sender {
  
  
  if (![self.ip validIpAddress]) {
    UIAlertView *av = [[UIAlertView alloc] initWithTitle:@"ip不对" message:nil delegate:self cancelButtonTitle:@"好的" otherButtonTitles: nil];
    [av show];
    return;
  }
  
  NSString *content = [NSString stringWithFormat:@"%@:%@",self.userNameTextField.text,self.contentTextView.text];
  NSData *data = [content dataUsingEncoding:NSUTF8StringEncoding];
  
  if (self.currentSocket) {
    [self.currentSocket writeData:data withTimeout:-1 tag:1001];
  }else{
    self.clientSocket = [[AsyncSocket alloc] initWithDelegate:self];
    [self.clientSocket connectToHost:self.ip onPort:8000 error:nil];
    [self.clientSocket writeData:data withTimeout:-1 tag:1001];
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
  
  self.myNewSocket = newSocket;//必须要有，否则一连接就会中断
  [self.myNewSocket readDataWithTimeout:-1 tag:1003];//必须要有，否则服务端后面收不到数据
  
  [self refreshMessageTextView:@"<系统>:有客户端连接进来"];
}

-(void)onSocket:(AsyncSocket *)sock didReadData:(NSData *)data withTag:(long)tag{
  
  [self refreshMessageTextView:[NSString stringWithFormat:@"<系统>：收到数据tag:%ld",tag]];
  
  NSString *message = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
  [self refreshMessageTextView:message];
  
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

  self.ip = host;
  self.ipTextField.text = host;
  
  NSString *str = [NSString stringWithFormat:@"<系统>:已经连接上：%@ %ld",host,(long)port];
  [self refreshMessageTextView:str];
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
