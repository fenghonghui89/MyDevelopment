//
//  CustomAnnotationView.h
//  LBSMapTest
//
//  Created by 冯鸿辉 on 16/3/22.
//  Copyright © 2016年 DGC. All rights reserved.
//自定义标注

#import <MAMapKit/MAMapKit.h>
#import "CustomCalloutView.h"
@interface CustomAnnotationView : MAAnnotationView
@property (nonatomic, readonly) CustomCalloutView *calloutView;
@end
