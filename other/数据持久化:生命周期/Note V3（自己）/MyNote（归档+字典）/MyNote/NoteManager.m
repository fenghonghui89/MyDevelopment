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
        [shareManager createArchiveredFile];
    });
    return shareManager;
}

#pragma mark - 创建归档文件 -
-(void)createArchiveredFile
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString * archiveredFileURL = [self getArchiveredFileURL];
    
    if (![fileManager fileExistsAtPath:archiveredFileURL]) {
        [fileManager createFileAtPath:archiveredFileURL contents:nil attributes:nil];
    }else{
        return;
    }
}

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
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithObjects:@[parmaNote.date,parmaNote.content] forKeys:@[@"date",@"content"]];
    
    [noteData addObject:dic];
    
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
    
    for (NSMutableDictionary *dic in noteData) {
        NSDate *date = [dic objectForKey:@"date"];
        if ([date isEqualToDate:parmaNote.date]) {
            [noteData removeObject:dic];
            
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
    NSData *unarchData = [NSData dataWithContentsOfFile:archiveredFileURL];
    NSKeyedUnarchiver *unarch = [[NSKeyedUnarchiver alloc] initForReadingWithData:unarchData];
    NSMutableArray *noteData = [unarch decodeObjectForKey:ARCHIVER_KEY];
    [unarch finishDecoding];
    
    for (NSMutableDictionary *dic in noteData) {
        NSDate *date = [dic objectForKey:@"date"];
        if ([date isEqualToDate:parmaNote.date]) {
            [dic setValue:parmaNote.content forKey:@"content"];
            NSMutableData *archData = [NSMutableData data];
            NSKeyedArchiver *arch = [[NSKeyedArchiver alloc] initForWritingWithMutableData:archData];
            [arch encodeObject:noteData forKey:ARCHIVER_KEY];
            [arch finishEncoding];
            [archData writeToFile:archiveredFileURL atomically:YES];
            return;
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
    
    for (NSMutableDictionary *dic in noteData) {
        NSDate *date = [dic objectForKey:@"date"];
        if ([date isEqualToDate:parmaNote.date]) {
            Note *note = [[Note alloc] init];
            note.date = [dic objectForKey:@"date"];
            note.content = [dic objectForKey:@"content"];
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
    
    if(theData.length == 0)
    {
        return nil;
    }
    
    else
    {
        NSKeyedUnarchiver *unarch = [[NSKeyedUnarchiver alloc] initForReadingWithData:theData];
        NSMutableArray *noteData = [unarch decodeObjectForKey:ARCHIVER_KEY];
        [unarch finishDecoding];
        
        NSMutableArray *noteArray = [NSMutableArray array];
        
        for (NSMutableDictionary *dic in noteData) {
            Note *note = [[Note alloc] init];
            note.date = [dic objectForKey:@"date"];
            note.content = [dic objectForKey:@"content"];
            [noteArray addObject:note];
        }
        return noteArray;
    }
    
}
@end
