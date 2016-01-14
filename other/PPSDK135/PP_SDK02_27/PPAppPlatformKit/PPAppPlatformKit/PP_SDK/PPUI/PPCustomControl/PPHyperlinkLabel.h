//
//  HyperlinkLabel.h
//  PPUserUIKit
//
//  Created by seven  mr on 1/14/13.
//  Copyright (c) 2013 张熙文. All rights reserved.
//

#import <UIKit/UIKit.h>
@class PPHyperlinkLabel;
@protocol PPHyperlinkLabelDelegate <NSObject>
@required
- (void)myLabel:(PPHyperlinkLabel *)myLabel;
@end


@interface PPHyperlinkLabel : UILabel{
    id <PPHyperlinkLabelDelegate> delegate;
}
@property (nonatomic, assign) id <PPHyperlinkLabelDelegate> delegate;
@end

