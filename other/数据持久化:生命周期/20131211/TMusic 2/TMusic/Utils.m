//
//  Utils.m
//  Day19
//
//  Created by Tarena on 13-5-2.
//  Copyright (c) 2013年 tarena. All rights reserved.
//

#import "Utils.h"
#import <AVFoundation/AVFoundation.h>
@implementation Utils
+(NSMutableArray *)getMusicsByDirectoryPath:(NSString *)path{
    NSMutableArray *musics = [NSMutableArray array];
    NSFileManager *fm = [NSFileManager defaultManager];
    NSArray *fileNames = [fm contentsOfDirectoryAtPath:path error:Nil];
    for (NSString *fileName in fileNames) {
        NSString *musicPath = [path stringByAppendingPathComponent:fileName];
        
        
        TRMusic * music = [[TRMusic alloc] init];
        //通过歌曲路径获取歌曲信息
        NSDictionary *infoDic = [Utils getMusicInfoByPath:musicPath];
        
        music.path = musicPath;
        music.name = [infoDic objectForKey:@"title"];
        music.album = [infoDic objectForKey:@"album"];
        music.artist = [infoDic objectForKey:@"artist"];
        
        music.downloaded = YES;
        music.highQuality = NO;
        [musics addObject:music];
    }
    return musics;
}
//获取专辑封面
+(UIImage *)getArtworkByPath:(NSString *)path{
    NSURL *fileURL = [NSURL fileURLWithPath:path];
    
    AVURLAsset *mp3Asset = [AVURLAsset URLAssetWithURL:fileURL options:nil];
    for (NSString *format in [mp3Asset availableMetadataFormats]) {
        for (AVMetadataItem *metadataItem in [mp3Asset metadataForFormat:format]) {
            if ([metadataItem.commonKey isEqualToString:@"artwork"]) {
         
                NSData *data = [(NSDictionary*)metadataItem.value objectForKey:@"data"];
               return [UIImage imageWithData:data];
                break;
            }
        }
    }
    return nil;
}

+(NSDictionary *)getMusicInfoByPath:(NSString *)path{
    NSMutableDictionary *infoDic = [NSMutableDictionary dictionary];
 
    NSURL * fileURL=[NSURL fileURLWithPath:path];
    NSString *fileExtension = [[fileURL path] pathExtension];
    if ([fileExtension isEqual:@"mp3"]||[fileExtension isEqual:@"m4a"])
    {
        AudioFileID fileID  = nil;
        OSStatus err        = noErr;
  
        err = AudioFileOpenURL( (CFURLRef) fileURL, kAudioFileReadPermission, 0, &fileID );
        if( err != noErr ) {
            NSLog( @"AudioFileOpenURL failed" );
        }
        UInt32 id3DataSize  = 0;
        err = AudioFileGetPropertyInfo( fileID,   kAudioFilePropertyID3Tag, &id3DataSize, NULL );
        if( err != noErr ) {
            NSLog( @"AudioFileGetPropertyInfo failed for ID3 tag" );
        }
        NSDictionary *piDict = nil;
        UInt32 piDataSize   = sizeof( piDict );
        err = AudioFileGetProperty( fileID, kAudioFilePropertyInfoDictionary, &piDataSize, &piDict );
        if( err != noErr ) {
         
            NSLog( @"AudioFileGetProperty failed for property info dictionary" );
        }
            NSString * Album = [(NSDictionary*)piDict objectForKey:
                            [NSString stringWithUTF8String: kAFInfoDictionary_Album]];
        NSString * Artist = [(NSDictionary*)piDict objectForKey:
                             [NSString stringWithUTF8String: kAFInfoDictionary_Artist]];
        NSString * Title = [(NSDictionary*)piDict objectForKey:
                            [NSString stringWithUTF8String: kAFInfoDictionary_Title]];
        if (!Title) {
            Title = @"";
        }
        if (!Artist) {
            Artist = @"";
        }
        if (!Album) {
            Album = @"";
        }
          [infoDic setObject:Title forKey:@"title"];
         [infoDic setObject:Artist forKey:@"artist"];
        [infoDic setObject:Album forKey:@"album"];
    }
    
    return infoDic;
}

@end
