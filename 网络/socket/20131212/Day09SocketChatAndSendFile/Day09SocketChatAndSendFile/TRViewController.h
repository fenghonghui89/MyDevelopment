//
//  TRViewController.h
//  Day09SocketChatAndSendFile
//
//  Created by HanyFeng on 13-12-18.
//  Copyright (c) 2013年 Hany. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AsyncSocket.h"
@interface TRViewController : UIViewController<AsyncSocketDelegate>
@property(nonatomic,strong)AsyncSocket* clientSocket;
@property(nonatomic,strong)AsyncSocket* serverSocket;
@property(nonatomic,strong)AsyncSocket* myNewSocket;
@end
