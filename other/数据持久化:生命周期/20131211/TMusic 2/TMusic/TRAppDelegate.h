//
//  TRAppDelegate.h
//  TMusic
//
//  Created by Alex Zhao on 13-8-8.
//  Copyright (c) 2013年 Tarena. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
@interface TRAppDelegate : UIResponder <UIApplicationDelegate>

@property (nonatomic, strong)AVAudioPlayer *player;
@property (strong, nonatomic) UIWindow *window;

@end
