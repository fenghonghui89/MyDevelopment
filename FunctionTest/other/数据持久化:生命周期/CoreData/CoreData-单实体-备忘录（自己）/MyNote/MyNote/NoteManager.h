//
//  NoteManage.h
//  MyNote
//
//  Created by hanyfeng on 14-5-13.
//  Copyright (c) 2014年 hanyfeng. All rights reserved.
//

#import <CoreData/CoreData.h>
#import <Foundation/Foundation.h>
#import "CoreDataNoteManager.h"
#import "Note.h"
#import "NoteManagedObject.h"
@interface NoteManager : CoreDataNoteManager

+(NoteManager *)shareNoteManager;
-(void)createData:(Note *)parmaNote;
-(void)deleteData:(Note *)parmaNote;
-(void)changeData:(Note *)parmaNote;
-(Note *)findData:(Note *)parmaNote;
-(NSMutableArray *)allData;
@end
