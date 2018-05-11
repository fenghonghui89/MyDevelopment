//
//  XTJTouchView
//  Test_SceneKit_18_Camera
//
//  Created by hanyfeng on 2018/5/4.
//  Copyright © 2018年 hanyfeng. All rights reserved.
//

#import "XTJTouchView.h"
#import "XTJRootDefine.h"

#define sScaleMax 2
#define sScaleMin 0.5
#define CAMERA_FOX 1
#define CAMERA_HEIGHT 1

@interface XTJTouchView()
{
    CGFloat _currentScale;
    CGFloat _prevScale;
}
@property(nonatomic,strong)UIPinchGestureRecognizer *pinchGesture;
@property(nonatomic,assign)CGFloat xFov;
@property(nonatomic,assign)CGFloat yFov;
@end
@implementation XTJTouchView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
        UIPinchGestureRecognizer *pinch = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(pinch:)];
        self.pinchGesture = pinch;
        [self addGestureRecognizer:pinch];
        
    }
    return self;
}

-(void)pinch:(UIPinchGestureRecognizer *)pinchGestur{
    
//    if (pinchGestur.state != UIGestureRecognizerStateEnded && pinchGestur.state != UIGestureRecognizerStateFailed) {
//
//        if (pinchGestur.scale != NAN && pinchGestur.scale != 0.0) {
//            CGFloat scale = pinchGestur.scale-1;
//            if (scale<0) {
//                scale *= (sScaleMax-sScaleMin);
//            }
//            _currentScale = scale+_prevScale;
//            _currentScale = [self validateScale:_currentScale];
//            CGFloat valScale = [self validateScale:_currentScale];
//            CGFloat xFov = CAMERA_FOX*(1-(valScale-1)*0.15);
//            CGFloat yFov = CAMERA_HEIGHT*(1-(valScale-1)*0.15);
//            [self.delegate pinchCamera:xFov yFov:yFov];
//        }
//    }else if (pinchGestur.state == UIGestureRecognizerStateEnded){
//        _prevScale = _currentScale;
//    }
    
//    NSLog(@"state:%ld %f",(long)pinchGestur.state,pinchGestur.scale);
    
    if (pinchGestur.state != UIGestureRecognizerStateEnded && pinchGestur.state != UIGestureRecognizerStateFailed)
    {
        CGFloat scale = pinchGestur.scale;
        if (scale>0) {
            
        }
        
    }
    else if (pinchGestur.state == UIGestureRecognizerStateEnded)
    {

    }
    
    switch (pinchGestur.state) {
        case UIGestureRecognizerStateBegan:
        {
            XTJBlockWeak(self);
            [self.delegate pinchStartWithXFov:^(CGFloat xFov) {
                weak_self.xFov = xFov;
            } yFov:^(CGFloat yFov) {
                weak_self.yFov = yFov;
            }];
        }
            break;
        case UIGestureRecognizerStateChanged:
        {
            if (pinchGestur.scale<0) {
                return;
            }

            //
            CGFloat scale = pinchGestur.scale;
            if (scale<1) {
                scale = (1-scale)+1;
            }else if (scale>1) {
                scale = 1-(scale-1);
            }
            NSLog(@"...scale:%f %f",pinchGestur.scale,scale);

            //计算视场
            CGFloat xFov_final = self.xFov*scale;
            CGFloat yFov_final = self.yFov*scale;

            //限制最小值 值越小视野越小物体越大
            if (xFov_final<10) {
                xFov_final = 10;
            }
            if (yFov_final<10) {
                yFov_final = 10;
            }

            //限制最大值 值越大视野越大物体越小
            if (xFov_final>70) {
                xFov_final = 70;
            }
            if (yFov_final>70) {
                yFov_final = 70;
            }
            NSLog(@"x:%f->%f y:%f->%f scale:%f",self.xFov,xFov_final,self.yFov,yFov_final,pinchGestur.scale);

            [self.delegate pinchMoveXFov:xFov_final yFov:yFov_final];
        }
            break;
        default:
            self.xFov = 0;
            self.yFov = 0;
            break;
    }
}

-(CGFloat)validateScale:(CGFloat)scale{
    if (scale <sScaleMin) {
        scale = sScaleMin;
    }else if(scale>sScaleMax){
        scale = sScaleMax;
    }
    
    return scale;
}
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
