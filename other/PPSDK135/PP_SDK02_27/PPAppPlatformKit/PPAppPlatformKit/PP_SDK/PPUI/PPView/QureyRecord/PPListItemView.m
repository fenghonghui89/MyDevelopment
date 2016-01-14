//
//  PPListItemView.m
//  ListViewTest
//
//  Created by Seven on 13-10-17.
//  Copyright (c) 2013年 1. All rights reserved.
//

#import "PPListItemView.h"
#import "PPCommon.h"
#import "PPUIKit.h"

@implementation PPListItemView

@synthesize itemButton,itemIndex,itemStateImageView,dashlineView;

- (PPListItemView *)initWithButtonTitle:(NSString *)title itemFrame:(CGRect)frame
{
    self = [super init];
    if (self) {
//        [self setFrame:frame];
        
        [self setBackgroundColor:[PPCommon getColor:@"f7f7f7"]];
        [[self layer] setMasksToBounds:YES];

        itemButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [itemButton setTitle:title forState:UIControlStateNormal];
        [itemButton setBackgroundColor:[PPCommon getColor:@"f7f7f7"]];
        [[itemButton titleLabel] setFont:[UIFont systemFontOfSize:13]];
        [itemButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [itemButton setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
        //button的titleLabel的边界：上、左、下、右
        [itemButton setTitleEdgeInsets:UIEdgeInsetsMake(0, 93, 0, 0)];
        [itemButton addTarget:self action:@selector(itemButtonPressedDown:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:itemButton];
//        [itemButton setFrame:CGRectMake(0, 0, frame.size.width, frame.size.height-1)];
        
        itemStateImageView = [[UIImageView alloc] init];
        [itemStateImageView setBackgroundColor:[PPCommon getColor:@"2181f7"]];
        [itemButton addSubview:itemStateImageView];
        [itemStateImageView setHidden:YES];
        if (self.isSelected) {
            [itemStateImageView setHidden:NO];
        }
        [itemStateImageView release];
        
        //分割线
        dashlineView = [[UIImageView alloc] init];
//        [dashlineView setImage:[[PPUIKit setLocaImage:@"PPDashline"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 0, 0, 0)
//                                                                                    resizingMode:UIImageResizingModeTile]];
//        [dashlineView setFrame:CGRectMake(93, frame.size.height-1, frame.size.width, 1)];
        [dashlineView setImage:[PPUIKit setLocaImage:@"PPDashline"]];
        [self addSubview:dashlineView];
        [dashlineView release];
        
        [self setFrame:frame];

    }
    return self;
}

- (void) setFrame:(CGRect)frame
{
    [super setFrame:frame];

    [itemButton setFrame:CGRectMake(0, 0, frame.size.width, frame.size.height-1)];
    [itemStateImageView setFrame:CGRectMake(69, (itemButton.frame.size.height - 12) / 2, 2, 12)];
    [dashlineView setFrame:CGRectMake(93, frame.size.height-1, frame.size.width, 1)];
    
}

//按钮按下
- (void)itemButtonPressedDown:(UIButton *)button{
    NSDictionary *dic = [NSDictionary dictionaryWithObject:button.titleLabel.text forKey:@"itemText"];
    
    if (self.delegate) {
        if ([self.delegate respondsToSelector:@selector(listItemView: selectedIndex: withInfo:)]) {
            if ([self isSelected]) {
                [self cancelSelectedState];
            }
            else{
                [self setSelectedState];
            }
            
            [self.delegate listItemView:self selectedIndex:self.itemIndex withInfo:dic];
        }
        else{
            NSLog(@"指定的方法listItemView: selectedIndex: withInfo:未实现");
        }
    }
    else{
        NSLog(@"未设置delegate对象");
    }
}

//设置选中状态
-(void) setSelectedState{
    if (!self.isSelected) {
        self.isSelected = YES;
        [self.itemStateImageView setHidden:NO];
    }
}

//取消选中状态
-(void) cancelSelectedState{
    if (self.isSelected) {
        self.isSelected = NO;
        [self.itemStateImageView setHidden:YES];
    }
}

//-(void)drawRect:(CGRect)rect
//{
//    CGContextRef context =UIGraphicsGetCurrentContext();
////    CGContextBeginPath(context);
//    CGContextSetLineWidth(context, 0.2);
//    CGContextSetStrokeColorWithColor(context, [UIColor blackColor].CGColor);
//    float lengths[] = {2,3};
//    CGContextSetLineDash(context, 0, lengths,2);
//    CGContextMoveToPoint(context, 93, rect.size.height-0.2);
//    CGContextAddLineToPoint(context, rect.size.width, rect.size.height-0.2);
//
//    CGContextStrokePath(context);
//    CGContextClosePath(context);
//}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
