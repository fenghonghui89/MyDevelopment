//
//  TRDownloadListController.h
//  Day10SocketDownLoadClient
//
//  Created by HanyFeng on 13-12-18.
//  Copyright (c) 2013年 Hany. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AsyncSocket.h"
@interface TRDownloadListController : UITableViewController<AsyncSocketDelegate>
@property(nonatomic,strong)NSArray* downloadList;
@property(nonatomic,strong)AsyncSocket* clientSocket;
@end
