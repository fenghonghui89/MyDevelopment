//
//  XTJTouchView
//  Test_SceneKit_18_Camera
//
//  Created by hanyfeng on 2018/5/4.
//  Copyright © 2018年 hanyfeng. All rights reserved.
//

#import "XTJTouchView.h"

@interface XTJTouchView()
@property(nonatomic,strong)UIPinchGestureRecognizer *pinchGesture;

@end
@implementation XTJTouchView

#pragma mark - Touch Events

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    if (_panningTouch == nil) {
        _panningTouch = [touches anyObject];
    }
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    
    if (_panningTouch) {
        CGPoint p0 = [_panningTouch previousLocationInView:self];
        CGPoint p1 = [_panningTouch locationInView:self];
        
        //x的差值正常 y的差值正负相反
        CGPoint displacement = CGPointMake(p1.x - p0.x, p1.y - p0.y);
        [self.delegate panCamera:displacement];
    }
    
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event {
    [self commonTouchesEnded:touches withEvent:event];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    [self commonTouchesEnded:touches withEvent:event];
}

#pragma mark - < private >
- (void)commonTouchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    if (_panningTouch) {
        if ([touches containsObject:_panningTouch]) {
            _panningTouch = nil;
        }
    }
    
}

@end
