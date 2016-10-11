//
//  MD_UndoManager_VC.m
//  MyDevelopmentTest
//
//  Created by 冯鸿辉 on 16/6/12.
//  Copyright © 2016年 hanyfeng. All rights reserved.
//

#import "MD_UndoManager_VC.h"

@interface MD_UndoManager_VC()

@end
@implementation MD_UndoManager_VC

-(void)viewDidLoad{

 
}

-(void)test{

}

- (IBAction)btnTap:(id)sender {
  [self.undoManager undo];
}



- (IBAction)btnTap1:(id)sender {
  [self.undoManager redo];
}

-(void)undoAction:(NSNumber *)number{
  
  NSLog(@"number:%ld",(long)[number integerValue]);
  [self.undoManager registerUndoWithTarget:self
                                  selector:@selector(undoAction:)
                                    object:number];
}


@end
