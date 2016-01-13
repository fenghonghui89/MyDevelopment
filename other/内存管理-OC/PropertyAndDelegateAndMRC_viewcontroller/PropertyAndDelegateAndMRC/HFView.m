//
//  HFView.m
//  PropertyAndDelegateAndMRC
//
//  Created by hanyfeng on 14-4-22.
//  Copyright (c) 2014年 hanyfeng. All rights reserved.
//

#import "HFView.h"

@implementation HFView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake(100, 50, 100, 20)];
        [label1 setBackgroundColor:[UIColor whiteColor]];
        [label1 setText:@"3-2"];
        [label1 setTextColor:[UIColor greenColor]];
        [self addSubview:label1];
        [label1 release];
        
        UIButton *btn2 = [[UIButton alloc] initWithFrame:CGRectMake(100, 100, 100, 20)];
        [btn2 setBackgroundColor:[UIColor grayColor]];
        [btn2 setTitle:@"返回到2" forState:UIControlStateNormal];
        [btn2 setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        [btn2 addTarget:self action:@selector(rm) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btn2];
        [btn2 release];

    }
    return self;
}

-(void)rm{
    [self.delegate view:self AndText:@"已回调"];
    [self removeFromSuperview];
}

-(void)dealloc{
    NSLog(@"hfv dealloc");
    self.delegate = nil;
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
