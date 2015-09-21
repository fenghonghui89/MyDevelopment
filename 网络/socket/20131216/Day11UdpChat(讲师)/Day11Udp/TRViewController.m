//
//  TRViewController.m
//  Day11Udp
//
//  Created by Tarena on 13-12-16.
//  Copyright (c) 2013年 Tarena. All rights reserved.
//

#import "TRViewController.h"

@interface TRViewController ()
@property (nonatomic ,strong)AsyncUdpSocket *udpSocket;
@property (nonatomic, strong)NSMutableArray *onlineIPs;
@end

@implementation TRViewController

- (void)viewDidLoad
{
    self.onlineIPs = [NSMutableArray array];
    [super viewDidLoad];
    //1.创建udpSocket对象
    self.udpSocket = [[AsyncUdpSocket alloc]initWithDelegate:self];
//    2.绑定一个端口
    [self.udpSocket bindToPort:9000 error:Nil];
    
//    3.设置为广播
    [self.udpSocket enableBroadcast:YES error:Nil];
    
    //4.读取数据  如果有人给本设备的ip发udp消息 就会自动调用 didreciveData
    [self.udpSocket receiveWithTimeout:-1 tag:0];
    
    
    [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(findSomeone) userInfo:Nil repeats:YES];
}
-(void)findSomeone{
    NSData *data = [@"谁在线" dataUsingEncoding:NSUTF8StringEncoding];
    [self.udpSocket sendData:data toHost:@"255.255.255.255" port:9000 withTimeout:-1 tag:0];
}
-(BOOL)onUdpSocket:(AsyncUdpSocket *)sock didReceiveData:(NSData *)data withTag:(long)tag fromHost:(NSString *)host port:(UInt16)port{
    //过滤掉ipv6的地址
    if ([host hasPrefix:@":"]) {
        return YES;
    }
    NSString *info = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    if ([info isEqualToString:@"谁在线"]) {
        NSString *sendInfo = @"我在线";
        [sock sendData:[sendInfo dataUsingEncoding:NSUTF8StringEncoding] toHost:host port:9000 withTimeout:-1 tag:0];
    }else if ([info isEqualToString:@"我在线"]){
        
        if (![self.onlineIPs containsObject:host]) {
            [self.onlineIPs addObject:host];
            [self.onlineListTV reloadData];
        }
       
        
    }
    
    
    NSLog(@"接收到%@说：%@",host,info);

    //持续读取数据
    [sock receiveWithTimeout:-1 tag:0];
    return YES;
}
- (IBAction)clicked:(id)sender {
    NSData *data = [@"你好！！" dataUsingEncoding:NSUTF8StringEncoding];
    [self.udpSocket sendData:data toHost:@"255.255.255.255" port:9000 withTimeout:-1 tag:0];
}




- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    
    return self.onlineIPs.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    
    cell.textLabel.text = [self.onlineIPs[indexPath.row] componentsSeparatedByString:@"."][3];
    
    return cell;
    
}








@end
