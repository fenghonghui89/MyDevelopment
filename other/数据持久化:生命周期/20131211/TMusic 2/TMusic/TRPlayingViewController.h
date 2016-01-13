//
//  TRPlayingViewController.h
//  TMusic
//
//  Created by Alex Zhao on 13-8-21.
//  Copyright (c) 2013年 Tarena. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "TRMusic.h"
#import <AVFoundation/AVFoundation.h>
@interface TRPlayingViewController : UIViewController<AVAudioPlayerDelegate>

@property (nonatomic, strong) NSArray * playingList;
@property (nonatomic)int index;
//表示当前播放的这首歌
@property (nonatomic, strong) TRMusic * music;
- (IBAction)clicked:(UIButton *)sender;

@end
