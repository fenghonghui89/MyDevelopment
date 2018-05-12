//
//  XTJTouchView
//  Test_SceneKit_18_Camera
//
//  Created by hanyfeng on 2018/5/4.
//  Copyright © 2018年 hanyfeng. All rights reserved.
//

#import "XTJTouchView.h"
#import "XTJRootDefine.h"

#define ScaleMax 80
#define ScaleMin 10

@interface XTJTouchView()

//保存缩放时的初始视场值
@property(nonatomic,assign)CGFloat xFov;
@property(nonatomic,assign)CGFloat yFov;
@end
@implementation XTJTouchView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
        UIPinchGestureRecognizer *pinch = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(pinch:)];
        [self addGestureRecognizer:pinch];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
        tap.numberOfTapsRequired = 2;
        [self addGestureRecognizer:tap];
        
//        UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(pan:)];
//        [self addGestureRecognizer:pan];
    }
    return self;
}

#pragma mark - 平移
-(void)pan:(UIPanGestureRecognizer *)panGestur{
    
}

#pragma mark - 双击恢复
-(void)tap:(UITapGestureRecognizer *)tapGestur{
    [self.delegate touchViewHasDoubleTap:self];
}

#pragma mark - 缩放
-(void)pinch:(UIPinchGestureRecognizer *)pinchGestur{
    
    switch (pinchGestur.state) {
        case UIGestureRecognizerStateBegan://开始
        {
            XTJBlockWeak(self);
            [self.delegate touchView:self
                  pinchStartWithXFov:^(CGFloat xFov) {
                      weak_self.xFov = xFov;
                  } yFov:^(CGFloat yFov) {
                      weak_self.yFov = yFov;
                  }];
        }
            break;
        case UIGestureRecognizerStateChanged://改变
        {
            if (pinchGestur.scale<0) {
                return;
            }

            //调整比例
            CGFloat scale = pinchGestur.scale;
            if (scale<1)//缩小
            {
                scale = (1-scale)+1;//值越来越大，(1,2)
            }
            else if (scale>1)//放大
            {
                //值越来越小 放大速度比缩小速度快，因此要乘以0.2 防止下降太快
                scale = 1-(scale-1)*0.2;
            }

            //计算视场
            CGFloat xFov_final = self.xFov*scale;
            CGFloat yFov_final = self.yFov*scale;

            //限制视野最小值 值越小视野越小物体越大
            if (xFov_final<ScaleMin) {
                xFov_final = ScaleMin;
            }
            if (yFov_final<ScaleMin) {
                yFov_final = ScaleMin;
            }

            //限制视野最大值 值越大视野越大物体越小
            if (xFov_final>ScaleMax) {
                xFov_final = ScaleMax;
            }
            if (yFov_final>ScaleMax) {
                yFov_final = ScaleMax;
            }
            NSLog(@"x:%.2f->%.2f y:%.2f->%.2f scale:%.2f %.2f",self.xFov,xFov_final,self.yFov,yFov_final,pinchGestur.scale,scale);

            [self.delegate touchView:self pinchMoveXFov:xFov_final yFov:yFov_final];
        }
            break;
        default:
            self.xFov = 0;
            self.yFov = 0;
            break;
    }
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
        [self.delegate touchViewHasPan:self direction:displacement];
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
