//
//  MD_GestureRecognizer_VC.m
//  MyDevelopmentTest
//
//  Created by hanyfeng on 15/9/11.
//  Copyright (c) 2015年 hanyfeng. All rights reserved.
//

#import "MD_GestureRecognizer_VC.h"
@interface MD_GestureRecognizer_VC()
@property(nonatomic,strong)UILabel *label;
@end
@implementation MD_GestureRecognizer_VC
-(void)viewDidLoad
{
    [super viewDidLoad];
    [self gestureRecognizerTest];
}

#pragma mark - < test > -
#pragma mark tap 点击
-(void)gestureRecognizerTest
{
    UITapGestureRecognizer *tapGR = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
    tapGR.numberOfTapsRequired = 2;//点击多少次才响应
    tapGR.numberOfTouchesRequired = 1;//多少个点同时触控才响应
    [self.view addGestureRecognizer:tapGR];
}

-(void)tap:(UITapGestureRecognizer *)tapGR
{
    CGPoint point = [tapGR locationInView:self.view];
    NSLog(@"点击触发...%@",NSStringFromCGPoint(point));
}

#pragma mark pinch 缩放
-(void)gestureRecognizerTest1
{
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(viewW/2, viewH/2, 100, 20)];
    [label setText:@"label"];
    [label setBackgroundColor:[UIColor greenColor]];
    _label = label;
    [self.view addSubview:label];

    UIPinchGestureRecognizer *pinchGR = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(pinch:)];
    [self.view addGestureRecognizer:pinchGR];
}

-(void)pinch:(UIPinchGestureRecognizer*)pinchGR
{
    NSLog(@"%.2f",pinchGR.scale);//scale = 当次缩放后两点间连线长度:当次刚点击时两点间连线长度
    
    //例子1
//    if (pinchGR.scale < 0.5) {
//        self.label.hidden = YES;
//    }else if(pinchGR.scale > 2){
//        self.label.hidden = NO;
//    }
    
    //例子2
    CGAffineTransform transform = _label.transform;
    transform = CGAffineTransformScale(transform, pinchGR.scale, pinchGR.scale);
    _label.transform = transform;
    pinchGR.scale = 1;//清空变化量（因为默认是相对于最初始位置时的数值，会不断叠加）
}

#pragma mark rotation 旋转
-(void)gestureRecognizerTest2
{
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(viewW/2, viewH/2, 100, 20)];
    [label setText:@"label"];
    [label setBackgroundColor:[UIColor greenColor]];
    _label = label;
    [self.view addSubview:label];
    
    UIRotationGestureRecognizer *rotationGR = [[UIRotationGestureRecognizer alloc] initWithTarget:self action:@selector(rotate:)];
    [self.view addGestureRecognizer:rotationGR];
}

-(void)rotate:(UIRotationGestureRecognizer*)rotationGR
{
    NSLog(@"%.2f",rotationGR.rotation);//当次旋转的角度
    
    CGAffineTransform transform = _label.transform;
    transform = CGAffineTransformRotate(transform, rotationGR.rotation);
    _label.transform = transform;
    rotationGR.rotation = 0;//清空变化量（因为默认是相对于最初始位置时的数值，会不断叠加）
}

#pragma mark pan 拖动
-(void)gestureRecognizerTest3
{
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(viewW/2, viewH/2, 100, 20)];
    [label setText:@"label"];
    [label setBackgroundColor:[UIColor greenColor]];
    [label setUserInteractionEnabled:YES];//开启响应触控
    [label setMultipleTouchEnabled:YES];//开启多点触控
    _label = label;
    [self.view addSubview:label];
    
    UIPanGestureRecognizer *panGR = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(pan:)];
    [_label addGestureRecognizer:panGR];//如果加入到self.view就会全屏幕都会响应
}

-(void)pan:(UIPanGestureRecognizer*)panGR
{
    NSLog(@"pan state:%d",panGR.state);//1-began识别成功 2-changed变化中 3-ended撤销
    
    //根据状态改变大小
    if (panGR.state == UIGestureRecognizerStateBegan) {
        _label.transform = CGAffineTransformMakeScale(1.5, 1.5);
        
        //或者下面
//        CGAffineTransform transform = _label.transform;
//        transform = CGAffineTransformScale(transform, 2, 2);
//        _label.transform = transform;
    }else if(panGR.state == UIGestureRecognizerStateEnded){
        _label.transform = CGAffineTransformIdentity;//恢复
    }
    
    
    
    //拖动
    //1.相对于刚点击时的点的坐标
    CGPoint delta = [panGR translationInView:self.view];
    
    //2.通过中间变量修改拖动后图片中心点的坐标（叠加当次拖动的位移量）
    CGPoint center = _label.center;
    center.x += delta.x;
    center.y += delta.y;
    _label.center = center;
    
    //3.清空位移量（因为默认是相对于最初始位置时的数值，会不断叠加）
    [panGR setTranslation:CGPointZero inView:self.view];
}
@end
