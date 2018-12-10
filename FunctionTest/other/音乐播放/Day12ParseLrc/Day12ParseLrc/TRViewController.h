//
//  TRViewController.h
//  Day12ParseLrc
//
//  Created by Tarena on 13-12-17.
//  Copyright (c) 2013年 Tarena. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
@interface TRViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>//遵守协议

@property (weak, nonatomic) IBOutlet UITableView *myTV;
@property (nonatomic, strong)AVAudioPlayer *player;

@end
