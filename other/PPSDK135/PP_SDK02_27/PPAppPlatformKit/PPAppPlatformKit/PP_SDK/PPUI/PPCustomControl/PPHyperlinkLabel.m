//
//  HyperlinkLabel.m
//  PPUserUIKit
//
//  Created by seven  mr on 1/14/13.
//  Copyright (c) 2013 张熙文. All rights reserved.
//

#import "PPHyperlinkLabel.h"

#define FONTSIZE 16
#define COLOR(R,G,B,A) [UIColor colorWithRed:R/255.0 green:G/255.0 blue:B/255.0 alpha:A]

@implementation PPHyperlinkLabel
@synthesize delegate;

- (id)init{
    self = [super init];
    if (self) {
        // Initialization code
        
        [self setLineBreakMode:NSLineBreakByWordWrapping|NSLineBreakByTruncatingTail];
        [self setFont:[UIFont systemFontOfSize:FONTSIZE]];
        [self setBackgroundColor:[UIColor clearColor]];
        [self setTextColor:COLOR(59,136,195,1.0)];
        [self setUserInteractionEnabled:YES];
        [self setNumberOfLines:0];
    }
    return self;
}


- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [self setTextColor:[UIColor grayColor]];
}

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint points = [touch locationInView:self];
    if (points.x > 0 && points.y > 0 && points.x <= self.frame.size.width && points.y <= self.frame.size.height) {
        [self setTextColor:[UIColor grayColor]];
    }else{
        [self setTextColor:COLOR(59,136,195,1.0)];
    }
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    [self setTextColor:COLOR(59,136,195,1.0)];
    UITouch *touch = [touches anyObject];
    CGPoint points = [touch locationInView:self];
    
    if (points.x > 0 && points.y > 0 && points.x <= self.frame.size.width && points.y <= self.frame.size.height) {
        
        [delegate myLabel:self];
    }
}
- (void)dealloc {
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

