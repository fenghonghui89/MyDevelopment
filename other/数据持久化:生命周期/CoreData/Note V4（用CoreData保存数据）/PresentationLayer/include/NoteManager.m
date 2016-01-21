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
        
        NSDateFormatter * dateFormatter = [[NSDateFormatter alloc] init];
        
        Note * note1 = [[Note alloc] init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        NSDate *date1 = [dateFormatter dateFromString:@"2014-05-04 14:08:00"];
        note1.date = date1;
        note1.content = @"欢迎使用";
        
        Note * note2 = [[Note alloc] init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        NSDate *date2 = [dateFormatter dateFromString:@"2014-05-04 14:08:00"];
        note2.date = date2;
        note2.content = @"你好";
        
        shareManager = [[self alloc] init];
        shareManager.noteData = [NSMutableArray array];
        [shareManager.noteData addObject:note1];
        [shareManager.noteData addObject:note2];
        
    });
    return shareManager;
}

-(void)createData:(Note *)parmaNote
{
    [self.noteData addObject:parmaNote];
}

-(void)deleteData:(Note *)parmaNote
{
    for (Note *note in self.noteData) {
        if ([note.date isEqualToDate:parmaNote.date]) {
            [self.noteData removeObject:parmaNote];
            break;
        }
    }
}

-(void)changeData:(Note *)parmaNote
{
    for (Note *note in self.noteData) {
        if ([note.date isEqualToDate:parmaNote.date]) {
            note.content = parmaNote.content;
            break;
        }
    }
}

-(Note *)findData:(Note *)parmaNote
{
    for (Note *note in self.noteData) {
        if ([note.date isEqualToDate:parmaNote.date]) {
            return note;
        }
    }
    return nil;
}

-(NSMutableArray *)allData
{
    return self.noteData;
}
@end
