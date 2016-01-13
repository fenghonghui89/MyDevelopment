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
@end
