//
//  TRUtils.m
//  Day5Photo_my
//
//  Created by HanyFeng on 13-12-9.
//  Copyright (c) 2013年 Hany. All rights reserved.
//

#import "TRUtils.h"
#import "TRAlbum.h"
@implementation TRUtils
+(NSMutableArray*)getAlbumsFromPath:(NSString*)path
{
    //新建文件管理器
    NSFileManager* fm = [NSFileManager defaultManager];
    //得到根文件夹下每个专辑的名字
    NSArray* directoryNames = [fm contentsOfDirectoryAtPath:path error:nil];
    
    NSMutableArray* albums = [NSMutableArray array];
    for (NSString* directoryName in directoryNames) {
        
        if (![directoryName hasPrefix:@"."]) {//把隐藏文件过滤掉
            
            //1.新建专辑对象存放专辑数据
            TRAlbum* album = [TRAlbum new];
            album.name = directoryName;
            
            //2.得到每个专辑的路径、得到专辑下每张图片的名字
            NSString* directoryPath = [path stringByAppendingPathComponent:directoryName];
            NSArray* imageNames = [fm contentsOfDirectoryAtPath:directoryPath error:nil];
            
            //3.得到每张图片的路径，存进专辑的imagePaths属性
            for (NSString* imageName in imageNames) {
                if (![imageName hasPrefix:@"."]) {
                    NSString* imagePath = [directoryPath stringByAppendingPathComponent:imageName];
                    [album.imagePaths addObject:imagePath];
                }
            }
            
            //4.把专辑对象放进专辑数组
            [albums addObject:album];
        }
    }
    return albums;
}
@end
