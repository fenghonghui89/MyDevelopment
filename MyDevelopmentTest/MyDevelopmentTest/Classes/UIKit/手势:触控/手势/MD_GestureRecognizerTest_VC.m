//
//  MD_GestureRecognizerTest_VC.m
//  MyDevelopmentTest
//
//  Created by hanyfeng on 15/9/11.
//  Copyright (c) 2015年 hanyfeng. All rights reserved.
//

#import "MD_GestureRecognizerTest_VC.h"
@interface MD_GestureRecognizerTest_VC()<UIGestureRecognizerDelegate>
@property(nonatomic,strong)UIImageView* imageView;
@property(nonatomic,assign)CGFloat minimumZoomScale;//最小缩放比例，初始化和双击恢复时用到
@property(nonatomic,assign)CGFloat scale;//缩放比例
@end
@implementation MD_GestureRecognizerTest_VC
#pragma mark - < vc lifecycle > -
-(void)viewDidLoad
{
    [super viewDidLoad];
    [self customInitUI];
}

-(void)customInitUI
{
    /*
     创建图片
     */
    self.imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Sky.jpg"]];
    
    //开启userInteractionEnabled并把imageView移动到图片中间
    self.imageView.userInteractionEnabled = YES;
    self.imageView.center = self.view.center;
    
    //计数最小缩放比例（注意取值-bounds、image）
    float horizontalScale = self.view.bounds.size.width / self.imageView.image.size.width;
    float verticalScale = self.view.bounds.size.height / self.imageView.image.size.height;
    self.minimumZoomScale = MIN(horizontalScale, verticalScale);
    
    //通过transform缩放图片到屏幕刚好显示所有内容且宽高比不变
    self.imageView.transform = CGAffineTransformMakeScale(self.minimumZoomScale,self.minimumZoomScale);
    
    [self.view addSubview:self.imageView];
    
    /*
     添加手势
     */
    //旋转
    UIRotationGestureRecognizer* rotationGR = [[UIRotationGestureRecognizer alloc] initWithTarget:self action:@selector(rotation:)];
    [self.view addGestureRecognizer:rotationGR];
    rotationGR.delegate = self;
    
    //缩放
    UIPinchGestureRecognizer* pinchGR = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(pinch:)];
    [self.view addGestureRecognizer:pinchGR];
    pinchGR.delegate = self;
    
    //拖动
    UIPanGestureRecognizer* panGR = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(pan:)];
    [self.imageView addGestureRecognizer:panGR];
    panGR.delegate = self;
    
    //双击恢复原状
    UITapGestureRecognizer* tapGR = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
    tapGR.numberOfTapsRequired = 2;
    [self.imageView addGestureRecognizer:tapGR];
}
#pragma mark - < action > -
//旋转
-(void)rotation:(UIRotationGestureRecognizer*)rotationGR
{
    CGAffineTransform transform = self.imageView.transform;
    transform = CGAffineTransformRotate(transform, rotationGR.rotation);
    self.imageView.transform = transform;
    rotationGR.rotation = 0;
}

//缩放
-(void)pinch:(UIPinchGestureRecognizer*)pinchGR
{
    CGAffineTransform transform = self.imageView.transform;
    transform = CGAffineTransformScale(transform, pinchGR.scale, pinchGR.scale);
    self.imageView.transform = transform;
    pinchGR.scale = 1;
}

//拖动
-(void)pan:(UIPanGestureRecognizer*)panGR
{
    CGPoint delta = [panGR translationInView:self.view];
    CGPoint center = self.imageView.center;
    center.x += delta.x;
    center.y += delta.y;
    self.imageView.center = center;
    [panGR setTranslation:CGPointZero inView:self.view];
}

//双击恢复原状
-(void)tap:(UITapGestureRecognizer*)tanGR
{
    self.imageView.transform = CGAffineTransformMakeRotation(0);
    self.imageView.transform = CGAffineTransformMakeScale(self.minimumZoomScale,self.minimumZoomScale);

    [UIView animateWithDuration:0.5 animations:^{
        self.imageView.center = self.view.center;
    }];
}

#pragma mark - < callback > -
#pragma mark deleage
//同时响应多种手势
-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    return YES;
}

@end
