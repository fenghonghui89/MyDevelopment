//
//  TRMusicGroup.m
//  TMusic
//
//  Created by Alex Zhao on 13-8-21.
//  Copyright (c) 2013年 Tarena. All rights reserved.
//

#import "TRMusicGroup.h"
#import "Utils.h"
@implementation TRMusicGroup

+ (NSArray *) fakeData
{

    NSString *direcotryPath = @"/Users/apple/Desktop/music";
   
    NSArray *musics = [Utils getMusicsByDirectoryPath:direcotryPath];
    
    
    
    
    TRMusicGroup * g1 = [[TRMusicGroup alloc] init];
    g1.name = @"国外单曲";
    g1.musics = [musics copy];
    g1.state = TRMusicGroupStateDownloaded;
    
    TRMusicGroup * g2 = [[TRMusicGroup alloc] init];
    g2.name = @"国内";
    g2.musics = [musics copy];
    g2.state = TRMusicGroupStateDownloaded;
    
    TRMusicGroup * g3 = [[TRMusicGroup alloc] init];
    g3.name = @"国外专辑";
    g3.musics = [musics copy];
    g3.state = TRMusicGroupStateNormal;
    
    TRMusicGroup * g4 = [[TRMusicGroup alloc] init];
    g4.name = @"怀旧";
    g4.musics = @[];
    g4.state = TRMusicGroupStateNormal;
    
    return @[g1, g2, g3, g4];
}

+ (NSTimeInterval) durationWithMinutes:(int)minutes andSeconds:(int)seconds
{
    return minutes * 60 + seconds;
}

@end
