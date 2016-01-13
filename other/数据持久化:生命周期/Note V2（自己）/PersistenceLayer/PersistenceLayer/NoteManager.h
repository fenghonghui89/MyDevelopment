//
//  NoteManage.h
//  MyNote
//
//  Created by hanyfeng on 14-5-13.
//  Copyright (c) 2014年 hanyfeng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Note.h"
@interface NoteManager : NSObject

+(NoteManager *)shareNoteManager;
-(void)createData:(Note *)parmaNote;
-(void)deleteData:(Note *)parmaNote;
-(void)changeData:(Note *)parmaNote;
-(Note *)findData:(Note *)parmaNote;
-(NSMutableArray *)allData;
@end
