//
//  NoteManage.m
//  MyNote
//
//  Created by hanyfeng on 14-5-13.
//  Copyright (c) 2014年 hanyfeng. All rights reserved.
//

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
    NSString * plistURL = [self getPlistURL];
    
    if (![fileManager fileExistsAtPath:plistURL]) {
        [fileManager createFileAtPath:plistURL contents:nil attributes:nil];
    }else{
        return;
    }
}

//获取plist文件路径
-(NSString *)getPlistURL
{
    NSString *documentURL = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString *plistURL = [documentURL stringByAppendingPathComponent:@"NotesPlist.plist"];
    return plistURL;
}

#pragma mark - 增删改查数据 -
-(void)createData:(Note *)parmaNote
{
    NSString *plistURL = [self getPlistURL];
    NSMutableArray *noteData = [NSMutableArray arrayWithContentsOfFile:plistURL];
    
    if (noteData.count == 0) {
        noteData = [NSMutableArray array];
    }
    
    NSDictionary *dic = [NSDictionary dictionaryWithObjects:@[parmaNote.date,parmaNote.content] forKeys:@[@"date",@"content"]];
    
    [noteData addObject:dic];
    [noteData writeToFile:plistURL atomically:YES];
}

-(void)deleteData:(Note *)parmaNote
{
    NSString *plistURL = [self getPlistURL];
    NSMutableArray *noteData = [NSMutableArray arrayWithContentsOfFile:plistURL];
    
    for (NSDictionary *dic in noteData) {
        NSDate *date = [dic objectForKey:@"date"];
        if ([date isEqualToDate:parmaNote.date]) {
            [noteData removeObject:dic];
            [noteData writeToFile:plistURL atomically:YES];
            break;
        }
    }
}

-(void)changeData:(Note *)parmaNote
{
    NSString *plistURL = [self getPlistURL];
    NSMutableArray *noteData = [NSMutableArray arrayWithContentsOfFile:plistURL];
    
    for (NSDictionary *dic in noteData) {
        NSDate *date = [dic objectForKey:@"date"];
        if ([date isEqualToDate:parmaNote.date]) {
            [dic setValue:parmaNote.content forKeyPath:@"content"];
            [noteData writeToFile:plistURL atomically:YES];
            return;
        }
    }
}

-(Note *)findData:(Note *)parmaNote
{
    NSString *plistURL = [self getPlistURL];
    NSMutableArray *noteData = [NSMutableArray arrayWithContentsOfFile:plistURL];
    
    for (NSDictionary *dic in noteData) {
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
    NSString *plistURL = [self getPlistURL];
    NSMutableArray *noteData = [NSMutableArray arrayWithContentsOfFile:plistURL];
    NSMutableArray *noteArray = [NSMutableArray array];
    
    for (NSDictionary *dic in noteData) {
        Note *note = [[Note alloc] init];
        note.date = [dic objectForKey:@"date"];
        note.content = [dic objectForKey:@"content"];
        [noteArray addObject:note];
    }
    
    return noteArray;
}
@end
