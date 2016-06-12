//
//  MD_UndoManager_DrewView.h
//  MyDevelopmentTest
//
//  Created by 冯鸿辉 on 16/6/12.
//  Copyright © 2016年 hanyfeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Line.h"
@interface TouchDrawView : UIView
@property(nonatomic,strong)Line *currentLine;
@property(nonatomic,strong)NSMutableArray *linesCompleted;
@property(nonatomic,strong)UIColor *drawColor;

-(void)redo;
-(void)undo;
@end
