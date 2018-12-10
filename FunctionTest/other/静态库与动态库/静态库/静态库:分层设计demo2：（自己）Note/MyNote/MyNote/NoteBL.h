//
//  NoteBL.h
//  MyNote
//
//  Created by hanyfeng on 14-5-13.
//  Copyright (c) 2014年 hanyfeng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Note.h"
#import "NoteManager.h"
@interface NoteBL : NSObject
-(NSMutableArray *)createNote:(Note *)parmaNote;
-(NSMutableArray *)deleteNote:(Note *)parmaNote;
-(void)changeNote:(Note *)parmaNote;
-(Note *)fineNote:(Note *)parmaNote;
-(NSMutableArray *)allNote;
@end
