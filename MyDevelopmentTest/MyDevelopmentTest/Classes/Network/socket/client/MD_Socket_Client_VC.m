//
//  MD_Socket_Client_VC.m
//  MyDevelopmentTest
//
//  Created by 冯鸿辉 on 16/3/25.
//  Copyright © 2016年 hanyfeng. All rights reserved.
//

#import "MD_Socket_Client_VC.h"
#import "AsyncSocket.h"

typedef NS_ENUM(NSInteger,messageType) {
  messageTypeClient = 0,
  messageTypeServer = 1,
  messageTypeSystem = 2
};

@interface MD_Socket_Client_VC ()<AsyncSocketDelegate,UITextViewDelegate>
@property(nonatomic,strong)AsyncSocket *clientSocket;
@property (weak, nonatomic) IBOutlet UITextView *contentTextView;
@property (weak, nonatomic) IBOutlet UIButton *sendBtn;
@property (weak, nonatomic) IBOutlet UIButton *closeBtn;
@property (weak, nonatomic) IBOutlet UITextView *messageTextView;
@property(nonatomic,copy)NSString *content;
@property(nonatomic,copy)NSString *message;
@end

@implementation MD_Socket_Client_VC

#pragma mark - < vc lifecycle > -
- (void)viewDidLoad {
  
  [super viewDidLoad];

}

-(void)viewDidAppear:(BOOL)animated{
  
  [super viewDidAppear:animated];
  
  [self customInit];
  [self customInitUI];
}

#pragma mark - < method > -
-(void)customInit{

  NSLog(@"本机ip:%@",[[MDTool sharedInstance] IPAddress]);
  
  self.clientSocket = [[AsyncSocket alloc] initWithDelegate:self];
  
  NSError *error = nil;
  [self.clientSocket connectToHost:@"192.168.5.157" onPort:8000 error:&error];
  if (error) {
    NSLog(@"error :%@",[error localizedDescription]);
  }

  [self.clientSocket readDataWithTimeout:-1 tag:1001];
}

-(void)customInitUI{

  self.contentTextView.text = @"你好，我是客户端";
  self.contentTextView.delegate = self;
  
  [self.messageTextView setEditable:NO];
  
  self.message = @"";
}

-(void)refreshMessageTF:(NSString *)message type:(messageType)type{
  
  switch (type) {
    case messageTypeClient:
      self.message = [self.message stringByAppendingString:[NSString stringWithFormat:@"客户端消息：%@\n",message]];
      break;
    case messageTypeServer:
      self.message = [self.message stringByAppendingString:[NSString stringWithFormat:@"服务端消息：%@\n",message]];
      break;
    case messageTypeSystem:
      self.message = [self.message stringByAppendingString:[NSString stringWithFormat:@"系统消息：%@\n",message]];
      break;
    default:
      break;
  }
  
  self.messageTextView.text = self.message;
}
#pragma mark - < action > -
- (IBAction)sendBtnTap:(id)sender {
  
  NSString *content = self.contentTextView.text;
  NSData *data = [content dataUsingEncoding:NSUTF8StringEncoding];
  [self.clientSocket writeData:data withTimeout:-1 tag:100];
  
  [self refreshMessageTF:content type:messageTypeClient];
}


- (IBAction)closeBtnTap:(id)sender {
  
  [self.clientSocket disconnect];
}

#pragma mark - < callback > - 
#pragma mark AsyncSocketDelegate
-(void)onSocket:(AsyncSocket *)sock didWriteDataWithTag:(long)tag{
  
  NSLog(@"发送成功");
  
  [self refreshMessageTF:@"发送成功" type:messageTypeSystem];
}

-(void)onSocket:(AsyncSocket *)sock didReadData:(NSData *)data withTag:(long)tag{

  NSLog(@"didReadData");
  
  NSString *message = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
  [self refreshMessageTF:message type:messageTypeServer];
}

-(void)onSocket:(AsyncSocket *)sock didConnectToHost:(NSString *)host port:(UInt16)port{
  
  NSLog(@"didConnectToHost:%@ %ld",host,(long)port);
  
  NSString *message = [NSString stringWithFormat:@"已经连接上，ip:%@ port:%ld",host,(long)port];
  [self refreshMessageTF:message type:messageTypeSystem];
}

-(void)onSocket:(AsyncSocket *)sock willDisconnectWithError:(NSError *)err{
  
  NSLog(@"willDisconnectWithError:%@",[err localizedDescription]);
  
  NSString *message = [NSString stringWithFormat:@"出错了：%@",[err localizedDescription]];
  [self refreshMessageTF:message type:messageTypeSystem];
}

-(void)onSocketDidDisconnect:(AsyncSocket *)sock{
  
  NSLog(@"断开连接了");
  
  [self refreshMessageTF:@"断开连接了" type:messageTypeSystem];
}

#pragma mark UITextFieldDelegate

-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
  if ([text isEqualToString:@"\n"]) {
    [self.contentTextView resignFirstResponder];
    return NO;
  }
  
  return YES;
}
@end
