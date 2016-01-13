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
        
        printf("\n");
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(100, 50, 100, 20)];
        NSLog(@"label:%p",label);
        [label setBackgroundColor:[UIColor whiteColor]];
        [label setText:@"3-2 view"];
        [label sizeToFit];
        [label setTextColor:[UIColor greenColor]];
        [self addSubview:label];
        [label release];
        
        UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(100, 100, 100, 20)];
        NSLog(@"btn:%p",btn);
        [btn setBackgroundColor:[UIColor grayColor]];
        [btn setTitle:@"返回到2" forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(rm) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btn];
        [btn release];

    }
    return self;
}

-(void)rm{
    [self.delegate view:self AndText:@"已回调"];
    [self removeFromSuperview];
}

-(void)dealloc{
    NSLog(@"hfv dealloc");
    _delegate = nil;
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
