//
//  TRUtils.m
//  Day4FindFile_my
//
//  Created by HanyFeng on 13-12-9.
//  Copyright (c) 2013年 Hany. All rights reserved.
//

#import "TRUtils.h"

@implementation TRUtils
+(void)findFileInDirecotryPath:(NSString *)path
{
    //得到文件管理器
    NSFileManager* fm = [NSFileManager defaultManager];
    //得到文件夹下所有文件的名称
    NSArray* fileNames = [fm contentsOfDirectoryAtPath:path error:nil];
    
    for (NSString* fileName in fileNames) {
        NSString* filePath = [path stringByAppendingPathComponent:fileName];//得到文件的完整路径
        
        BOOL isDirectory;
        if ([fm fileExistsAtPath:filePath isDirectory:&isDirectory] && isDirectory) {//如果是文件夹，则递归方法
            [TRUtils findFileInDirecotryPath:filePath];
        }else {//如果是文件，则判断后缀，类型符合就复制到文件夹下
            if ([fileName hasSuffix:@"jpg"]) {
                NSString* newDirectoryPath = @"/Users/apple/Desktop/未命名文件夹 2";
                NSString* newFilePath = [newDirectoryPath stringByAppendingPathComponent:fileName];
                [fm copyItemAtPath:filePath toPath:newFilePath error:nil];
            }
        }
    }
}
@end
