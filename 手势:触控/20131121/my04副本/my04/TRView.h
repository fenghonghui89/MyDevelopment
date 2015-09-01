//
//  TRView.h
//  my04
//
//  Created by HanyFeng on 13-11-23.
//  Copyright (c) 2013年 Hany. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TRPoint.h"
@interface TRView : UIView
@property(nonatomic,assign)NSMutableArray* drawLines;
@property(nonatomic,strong)NSMutableArray* points;
@end
