//
//  myUILabel.h
//  UCA
//
//  Created by hanyfeng on 15/8/24.
//  Copyright (c) 2015年 kevenTsang/曾克兵. All rights reserved.
//顶端对齐label

#import <UIKit/UIKit.h>
typedef enum
{
    VerticalAlignmentTop = 0, // default
    VerticalAlignmentMiddle,
    VerticalAlignmentBottom,
} VerticalAlignment;

@interface myUILabel : UILabel
//{
//@private
//    VerticalAlignment _verticalAlignment;
//}
//
//@property (nonatomic) VerticalAlignment verticalAlignment;
@property(nonatomic,assign)VerticalAlignment verticalAlignment;
@end
