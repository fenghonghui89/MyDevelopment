/*
    Copyright (C) 2016 Apple Inc. All Rights Reserved.
    See LICENSE.txt for this sample’s licensing information
    
    Abstract:
    Handles keyboard (OS X), touch (iOS) and controller (iOS, tvOS) input for controlling the game.
*/

#import "AAPLGameViewControllerPrivate.h"

@implementation ViewController18 (GameControls)

#pragma mark - Touch Events

//- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
////    for (UITouch *touch in touches) {
////        if (_panningTouch == nil) {
////            // Start panning
////            _panningTouch = [touches anyObject];
////        }
////
////        if (_panningTouch)
////            break; // We already have what we need
////    }
//
//    if (_panningTouch == nil) {
//        _panningTouch = [touches anyObject];
//    }
//}
//
//- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
//
//    if (_panningTouch) {
//        CGPoint p0 = [_panningTouch previousLocationInView:self.view];
//        CGPoint p1 = [_panningTouch locationInView:self.view];
//
//        //x的差值正常 y的差值正负相反
//        CGPoint displacement = CGPointMake(p1.x - p0.x, p1.y - p0.y);
//        [self panCamera:displacement];
//    }
//
//}
//
//- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event {
//    [self commonTouchesEnded:touches withEvent:event];
//}
//
//- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
//    [self commonTouchesEnded:touches withEvent:event];
//}
//
//#pragma mark - < private >
//- (void)commonTouchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
//    if (_panningTouch) {
//        if ([touches containsObject:_panningTouch]) {
//            _panningTouch = nil;
//        }
//    }
//
//}


@end
