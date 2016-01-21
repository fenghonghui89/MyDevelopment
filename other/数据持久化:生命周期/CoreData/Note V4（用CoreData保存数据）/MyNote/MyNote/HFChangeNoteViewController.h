//
//  HFChangeNoteViewController.h
//  MyNote
//
//  Created by hanyfeng on 14-5-13.
//  Copyright (c) 2014年 hanyfeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Note.h"
#import "NoteBL.h"
@interface HFChangeNoteViewController : UIViewController
@property(nonatomic,assign)NSInteger noteDataIndex;
@property(nonatomic,strong)NSMutableArray *noteData;
@property (weak, nonatomic) IBOutlet UITextView *textView;
@end
