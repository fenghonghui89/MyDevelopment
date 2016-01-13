//
//  TRAppDelegate.h
//  Day7MusicPlayer
//
//  Created by Tarena on 13-12-10.
//  Copyright (c) 2013年 Tarena. All rights reserved.

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
@interface TRAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (nonatomic, strong)AVAudioPlayer *player;//在AppDelegate中声明player，歌曲的播放与停顿就不会受到播放页面的内存管理影响（切换歌曲时会把原来的player先release掉，再retain新的player）

@end
