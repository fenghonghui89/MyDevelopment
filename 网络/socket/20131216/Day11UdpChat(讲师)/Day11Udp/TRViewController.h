//
//  TRViewController.h
//  Day11Udp
//
//  Created by Tarena on 13-12-16.
//  Copyright (c) 2013年 Tarena. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AsyncUdpSocket.h"
@interface TRViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITextField *sendInfoTF;
@property (weak, nonatomic) IBOutlet UITextView *historyTV;
@property (weak, nonatomic) IBOutlet UITableView *onlineListTV;
@property (weak, nonatomic) IBOutlet UILabel *toSomeoneLabel;

@end
