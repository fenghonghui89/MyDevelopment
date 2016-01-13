//
//  Utils.h
//  Day19
//
//  Created by Tarena on 13-5-2.
//  Copyright (c) 2013年 tarena. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TRMusic.h"
@interface Utils : NSObject
+(NSMutableArray *)getMusicsByDirectoryPath:(NSString *)path;

//通过歌曲路径得到封面
+(UIImage*)getArtworkByPath:(NSString*)path;
//通过歌曲路径得到歌曲信息
+(NSMutableDictionary *)getMusicInfoByPath:(NSString *)path;
@end
