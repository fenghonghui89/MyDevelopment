//
//  XTJTouchView
//  Test_SceneKit_18_Camera
//
//  Created by hanyfeng on 2018/5/4.
//  Copyright © 2018年 hanyfeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@class XTJTouchView;
@protocol XTJTouchViewDelegate
-(void)touchViewHasDoubleTap:(XTJTouchView *)touchView;
-(void)touchViewHasPan:(XTJTouchView *)touchView direction:(CGPoint)direction;
-(void)touchView:(XTJTouchView *)touchView pinchStartWithXFov:(void(^)(CGFloat xFov))xFovBlock yFov:(void(^)(CGFloat yFov))yFovBlock;
-(void)touchView:(XTJTouchView *)touchView pinchMoveXFov:(CGFloat)xFov yFov:(CGFloat)yFov;
@end
@interface XTJTouchView : UIView
{
    UITouch *_panningTouch;
}
@property(nonatomic,assign)id<XTJTouchViewDelegate>delegate;
@end
