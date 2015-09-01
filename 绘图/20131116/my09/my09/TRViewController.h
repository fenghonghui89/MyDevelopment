//
//  TRViewController.h
//  my09
//
//  Created by HanyFeng on 13-11-17.
//  Copyright (c) 2013年 Hany. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TRData.h"
#import "TRCircleChartView.h"
@interface TRViewController : UIViewController

@property(nonatomic,strong)NSArray* dataArray;
@property (weak, nonatomic) IBOutlet TRCircleChartView *circleChartView;

@end
