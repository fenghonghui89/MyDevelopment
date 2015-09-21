//
//  TRViewController.h
//  Day9Chat
//
//  Created by Tarena on 13-12-12.
//  Copyright (c) 2013年 Tarena. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AsyncSocket.h"
@interface TRViewController : UIViewController<AsyncSocketDelegate>
@property (nonatomic, strong)AsyncSocket *serverSocket;
@property(nonatomic , strong)AsyncSocket *clientSocket;
@property (nonatomic, strong)AsyncSocket *myNewSocket;
@end
