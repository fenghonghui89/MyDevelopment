//
//  MD_UndoManager_DrewView.m
//  MyDevelopmentTest
//
//  Created by 冯鸿辉 on 16/6/12.
//  Copyright © 2016年 hanyfeng. All rights reserved.
//


#import "TouchDrawView.h"

@interface TouchDrawView ()

@end
@implementation TouchDrawView


#pragma mark - <<<<<< override >>>>>>
#pragma mark - view lifecycle
-(instancetype)initWithCoder:(NSCoder *)aDecoder{

  self = [super initWithCoder:aDecoder];
  if (self) {
    self.linesCompleted = [NSMutableArray array];
    self.multipleTouchEnabled = YES;
    self.drawColor = [UIColor blackColor];
    [self becomeFirstResponder];
  }
  return self;
}


#pragma mark - touche
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{

  [self.undoManager beginUndoGrouping];
  
  for (UITouch *touche in touches) {
    
    CGPoint point = [touche locationInView:self];
    
    Line *line = [Line new];
    line.begin = point;
    line.end = point;
    line.color = self.drawColor;
    self.currentLine = line;
  }
}

-(void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{

  for (UITouch *touch in touches) {
    
    [self.currentLine setColor:self.drawColor];
    
    CGPoint point = [touch locationInView:self];
    [self.currentLine setEnd:point];
    
    if (self.currentLine) {
      [self addLine:self.currentLine];
    }
    
    Line *newLine = [Line new];
    [newLine setBegin:point];
    [newLine setEnd:point];
    [newLine setColor:self.drawColor];
    self.currentLine = newLine;
  }
  
  [self setNeedsDisplay];
}

-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{

  [self setNeedsDisplay];
  [self.undoManager endUndoGrouping];
}

-(void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
  
  [self setNeedsDisplay];
}

#pragma mark - draw
-(void)drawRect:(CGRect)rect{
  
  NSLog(@"%d",self.linesCompleted.count);
  CGContextRef context = UIGraphicsGetCurrentContext();
  CGContextSetLineWidth(context, 1);
  CGContextSetLineCap(context, kCGLineCapRound);
  [self.drawColor set];
  
  for (Line *line in self.linesCompleted) {
    [[line color] set];
    CGContextMoveToPoint(context, [line begin].x, [line begin].y);
    CGContextAddLineToPoint(context, [line end].x, [line end].y);
    CGContextStrokePath(context);
  }
}

#pragma mark - other
-(BOOL)canBecomeFirstResponder{
  
  return YES;
}

-(void)didMoveToWindow{
  
  [self becomeFirstResponder];
}
#pragma mark - <<<<<< customize method >>>>>>
#pragma mark - undo
-(void)undo{
  if ([self.undoManager canUndo]) {
    [self.undoManager undo];
    [self setNeedsDisplay];
  }
}

#pragma mark - add / remove line
-(void)addLine:(Line *)line{
  [[self.undoManager prepareWithInvocationTarget:self] removeLine:line];
  [self.linesCompleted addObject:line];
}

-(void)removeLine:(Line *)line{
  if ([self.linesCompleted containsObject:line]) {
    [self.linesCompleted removeObject:line];
  }
}

-(void)removeLineByEndPoint:(CGPoint)point{
  
  NSPredicate *predicate = [NSPredicate predicateWithBlock:^BOOL(id  _Nonnull evaluatedObject, NSDictionary<NSString *,id> * _Nullable bindings) {
    Line *evaluatedLine = (Line *)evaluatedObject;
    return evaluatedLine.end.x == point.x && evaluatedLine.end.y == point.y;
  }];
  
  NSArray *result = [self.linesCompleted filteredArrayUsingPredicate:predicate];
  if (result && result.count>0) {
    [self.linesCompleted removeObject:result[0]];
  }
}




@end
