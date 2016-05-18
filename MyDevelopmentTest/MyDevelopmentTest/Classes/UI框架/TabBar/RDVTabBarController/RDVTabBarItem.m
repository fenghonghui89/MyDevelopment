//
//  RDVTabBarItem.m
//  MyDevelopmentTest
//
//  Created by 冯鸿辉 on 16/5/18.
//  Copyright © 2016年 hanyfeng. All rights reserved.
//

#import "RDVTabBarItem.h"

@interface RDVTabBarItem()
@property(nonatomic,strong)UIImage *selectedBackgroundImage;
@property(nonatomic,strong)UIImage *unselectedBackgroundImage;
@property(nonatomic,strong)UIImage *selectedImage;
@property(nonatomic,strong)UIImage *unselectedImage;
@property(nonatomic,copy)NSString *title;
@property(nonatomic,strong)NSDictionary *selectedTitleAttributes;
@property(nonatomic,strong)NSDictionary *unselectedTitleAttributes;
@end
@implementation RDVTabBarItem

#pragma mark - view lifecycle
-(instancetype)initWithFrame:(CGRect)frame{
  self = [super initWithFrame:frame];
  if (self) {
    
  }
  return self;
}

-(instancetype)initWithCoder:(NSCoder *)aDecoder{
  self = [super initWithCoder:aDecoder];
  if (self) {
    
  }
  return self;
}

-(instancetype)init{
  
  return [self initWithFrame:CGRectZero];
}

-(void)drawRect:(CGRect)rect{

  CGSize frameSize = self.frame.size;
  CGSize imageSize = CGSizeZero;
  CGSize titleSize = CGSizeZero;
  NSDictionary *titleAttributes = nil;
  UIImage *backgroundImage = nil;
  UIImage *image = nil;
  
  if (self.selected) {
    backgroundImage = self.selectedBackgroundImage;
    image = self.selectedImage;
    titleAttributes = self.selectedTitleAttributes;
  }else{
    backgroundImage = self.unselectedBackgroundImage;
    image = self.unselectedImage;
    titleAttributes = self.unselectedTitleAttributes;
  }
  
  imageSize = [image size];
  
  CGContextRef context = UIGraphicsGetCurrentContext();
  CGContextSaveGState(context);
  
  [backgroundImage drawInRect:self.bounds];
  
  if (self.title.length > 0) {
    CGRect imageRect = CGRectMake(round(frameSize.width/2-imageSize.width/2),
                                  round(frameSize.height/2-imageSize.width/2),
                                  imageSize.width, imageSize.height);
    [image drawInRect:imageRect];
  }else{
    titleSize = [self.title boundingRectWithSize:CGSizeMake(frameSize.width, 20)
                                         options:NSStringDrawingUsesLineFragmentOrigin
                                      attributes:titleAttributes
                                         context:nil].size;
  }
  
  CGContextRestoreGState(context);
}
#pragma mark - method
-(void)commonInit{

  [self setBackgroundColor:[UIColor clearColor]];
  self.title = @"";
  if (NSFoundationVersionNumber > NSFoundationVersionNumber_iOS_6_0) {
    self.selectedTitleAttributes = @{NSFontAttributeName:[UIFont systemFontOfSize:12],NSForegroundColorAttributeName:[UIColor blackColor]};
    self.unselectedTitleAttributes = [self.selectedTitleAttributes copy];
  }
}
#pragma mark - action
@end
