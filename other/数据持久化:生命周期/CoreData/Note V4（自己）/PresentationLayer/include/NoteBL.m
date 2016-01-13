//
//  NoteBL.m
//  MyNote
//
//  Created by hanyfeng on 14-5-13.
//  Copyright (c) 2014年 hanyfeng. All rights reserved.
//

#import "NoteBL.h"

@implementation NoteBL
-(NSMutableArray *)createNote:(Note *)parmaNote
{
    NoteManager *noteManager = [NoteManager shareNoteManager];
    [noteManager createData:parmaNote];
    return [noteManager allData];
}

-(NSMutableArray *)deleteNote:(Note *)parmaNote
{
    NoteManager *noteManager = [NoteManager shareNoteManager];
    [noteManager deleteData:parmaNote];
    return [noteManager allData];
}

-(void)changeNote:(Note *)parmaNote
{
    NoteManager *noteManager = [NoteManager shareNoteManager];
    [noteManager changeData:parmaNote];
}

-(Note *)fineNote:(Note *)parmaNote
{
    NoteManager *noteManager = [NoteManager shareNoteManager];
    return [noteManager findData:parmaNote];
}

-(NSMutableArray *)allNote
{
    NoteManager *noteManager = [NoteManager shareNoteManager];
    return [noteManager allData];
}
@end
