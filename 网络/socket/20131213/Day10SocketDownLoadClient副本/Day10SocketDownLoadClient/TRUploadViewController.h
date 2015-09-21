//
//  TRUploadViewController.h
//  Day10SocketDownLoadClient
//
//  Created by HanyFeng on 13-12-19.
//  Copyright (c) 2013年 Hany. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AsyncSocket.h"
@interface TRUploadViewController : UIViewController
@property(nonatomic,strong)AsyncSocket* clientSocket;
@end
