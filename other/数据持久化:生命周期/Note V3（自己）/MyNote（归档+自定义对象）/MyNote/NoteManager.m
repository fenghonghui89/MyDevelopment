//
//  NoteManage.m
//  MyNote
//
//  Created by hanyfeng on 14-5-13.
//  Copyright (c) 2014年 hanyfeng. All rights reserved.
//

#define ARCHIVER_FILE_KEY @"NotesList.archiver"
#define ARCHIVER_KEY @"NotesList"
#import "NoteManager.h"

@implementation NoteManager

static NoteManager *shareManager = nil;
+(NoteManager *)shareNoteManager
{
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        shareManager = [[self alloc] init];
        [shareManager createNotesPlist];
    });
    return shareManager;
}

#pragma mark - 创建plist文件 -
//如果plist不存在，则创建plist文件
-(void)createNotesPlist
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString * archiveredFileURL = [self getArchiveredFileURL];
    
    if (![fileManager fileExistsAtPath:archiveredFileURL]) {
        [fileManager createFileAtPath:archiveredFileURL contents:nil attributes:nil];
    }else{
        return;
    }
}

//获取plist文件路径
-(NSString *)getArchiveredFileURL
{
    NSString *documentURL = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString *archiveredFileURL = [documentURL stringByAppendingPathComponent:ARCHIVER_FILE_KEY];
    return archiveredFileURL;
}

#pragma mark - 增删改查数据 -
-(void)createData:(Note *)parmaNote
{
    NSString *archiveredFileURL = [self getArchiveredFileURL];
    NSData *unarchData = [NSData dataWithContentsOfFile:archiveredFileURL];
    NSMutableArray *noteData = nil;
    
    if (unarchData.length == 0) {
        noteData = [NSMutableArray array];
    }else{
        NSKeyedUnarchiver *unarch = [[NSKeyedUnarchiver alloc] initForReadingWithData:unarchData];
        noteData = [unarch decodeObjectForKey:ARCHIVER_KEY];
        [unarch finishDecoding];
    }
    
    [noteData addObject:parmaNote];
    NSMutableData *archData = [NSMutableData data];
    NSKeyedArchiver *arch = [[NSKeyedArchiver alloc] initForWritingWithMutableData:archData];
    [arch encodeObject:noteData forKey:ARCHIVER_KEY];
    [arch finishEncoding];
    [archData writeToFile:archiveredFileURL atomically:YES];
}

-(void)deleteData:(Note *)parmaNote
{
    NSString *archiveredFileURL = [self getArchiveredFileURL];
    NSData *unarchData = [NSData dataWithContentsOfFile:archiveredFileURL];
    NSKeyedUnarchiver *unarch = [[NSKeyedUnarchiver alloc] initForReadingWithData:unarchData];
    NSMutableArray *noteData = [unarch decodeObjectForKey:ARCHIVER_KEY];
    [unarch finishDecoding];
    
    for (Note *note in noteData) {
        if ([note.date isEqualToDate:parmaNote.date]) {
            [noteData removeObject:note];
            
            NSMutableData *archData = [NSMutableData data];
            NSKeyedArchiver *arch = [[NSKeyedArchiver alloc] initForWritingWithMutableData:archData];
            [arch encodeObject:noteData forKey:ARCHIVER_KEY];
            [arch finishEncoding];
            [archData writeToFile:archiveredFileURL atomically:YES];
            break;
        }
    }
}

-(void)changeData:(Note *)parmaNote
{
    NSString *archiveredFileURL = [self getArchiveredFileURL];
    
    NSMutableArray *noteData = [self allData];
    
    for (Note *note in noteData) {
        if ([note.date isEqualToDate:parmaNote.date]) {
            note.content = parmaNote.content;
            
            NSMutableData *archData = [NSMutableData data];
            NSKeyedArchiver *arch = [[NSKeyedArchiver alloc] initForWritingWithMutableData:archData];
            [arch encodeObject:noteData forKey:ARCHIVER_KEY];
            [arch finishEncoding];
            [archData writeToFile:archiveredFileURL atomically:YES];
            break;
        }
    }
}

-(Note *)findData:(Note *)parmaNote
{
    NSString *archiveredFileURL = [self getArchiveredFileURL];
    NSData *theData = [NSData dataWithContentsOfFile:archiveredFileURL];
    NSKeyedUnarchiver *unarch = [[NSKeyedUnarchiver alloc] initForReadingWithData:theData];
    NSMutableArray *noteData = [unarch decodeObjectForKey:ARCHIVER_KEY];
    [unarch finishDecoding];
    
    for (Note *note in noteData) {
        if ([note.date isEqualToDate:parmaNote.date]) {
            return note;
            break;
        }
    }
    
    return nil;
}

-(NSMutableArray *)allData
{
    NSString *archiveredFileURL = [self getArchiveredFileURL];
    NSData *theData = [NSData dataWithContentsOfFile:archiveredFileURL];
    NSKeyedUnarchiver *unarch = [[NSKeyedUnarchiver alloc] initForReadingWithData:theData];
    NSMutableArray *noteData = [unarch decodeObjectForKey:ARCHIVER_KEY];
    [unarch finishDecoding];
    
    NSLog(@"-----%@",noteData);
    
    return noteData;
}
@end
