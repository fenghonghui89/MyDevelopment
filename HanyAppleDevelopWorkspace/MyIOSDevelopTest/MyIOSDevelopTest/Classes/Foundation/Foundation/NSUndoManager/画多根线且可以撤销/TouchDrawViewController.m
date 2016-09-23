//
//  TouchDrawViewController.m
//  MyDevelopmentTest
//
//  Created by 冯鸿辉 on 16/6/12.
//  Copyright © 2016年 hanyfeng. All rights reserved.
//

#import "TouchDrawViewController.h"
#import "ColorPiker.h"
#import "TouchDrawView.h"
@interface TouchDrawViewController ()<ColorPikerDelegate>
@property (weak, nonatomic) IBOutlet ColorPiker *selector1;
@property (weak, nonatomic) IBOutlet ColorPiker *selector2;
@property (weak, nonatomic) IBOutlet ColorPiker *selector3;
@property (weak, nonatomic) IBOutlet ColorPiker *selector4;
@property (weak, nonatomic) IBOutlet TouchDrawView *drawArea;

@end

@implementation TouchDrawViewController

#pragma mark - <<<<<< override >>>>>>
- (void)viewDidLoad {
  [super viewDidLoad];
  
  [self.selector1 setDelegate:self];
  [self.selector2 setDelegate:self];
  [self.selector3 setDelegate:self];
  [self.selector4 setDelegate:self];
}

#pragma mark - <<<<< action >>>>>
- (IBAction)undoBtnTap:(id)sender {

  [self.drawArea undo];
}

- (IBAction)redoBtnTap:(id)sender {
  
  [self.drawArea redo];
}

- (IBAction)actionBtnTap:(id)sender {
  
//  [self.drawArea.undoManager removeAllActions];
  NSLog(@"%d",self.drawArea.undoManager.levelsOfUndo);
}

#pragma mark - <<<<< callback >>>>>

-(void)aColorPikerIsSelected:(UIColor *)color{
  
  [self.drawArea setDrawColor:color];
  
  self.selector1.layer.borderWidth = 0.0f;
  self.selector2.layer.borderWidth = 0.0f;
  self.selector3.layer.borderWidth = 0.0f;
  self.selector4.layer.borderWidth = 0.0f;
}

@end
