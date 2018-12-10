//
//  HFAdd.m
//  UIView
//
//  Created by hanyfeng on 14-3-27.
//  Copyright (c) 2014年 hanyfeng. All rights reserved.
//

#import "HFAddView.h"

@implementation HFAddView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
        NSLog(@"label:%p",label);
        [label setText:@"哈哈"];
        [label setTintColor:[UIColor redColor]];
        [self addSubview:label];
        [label release];
    }
    return self;
}

-(void)dealloc{
    NSLog(@"AddView dealloc:%p",self);
    [super dealloc];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
