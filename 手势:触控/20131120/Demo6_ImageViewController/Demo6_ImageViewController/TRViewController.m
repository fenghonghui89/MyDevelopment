//
//  TRViewController.m
//  Demo6_ImageViewController
//
//  Created by Tarena on 13-11-20.
//  Copyright (c) 2013年 Tarena. All rights reserved.
//

#import "TRViewController.h"

@interface TRViewController () <UIGestureRecognizerDelegate>

@property (strong, nonatomic) UIImageView * imageView;
@property (strong, nonatomic) UILabel * label1;
@property (strong, nonatomic) UILabel * label2;

@end

@implementation TRViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //创建imageView并加入图片
    UIImage * image = [UIImage imageNamed:@"Elephant.jpg"];
    UIImageView * imageView = [[UIImageView alloc] initWithImage:image];
    [self.view addSubview:imageView];
    
    //开启交互、缩放并居中
    imageView.userInteractionEnabled = YES;
    self.imageView = imageView;
    [self relocate:nil];//初始化时调用缩放居中方法

    UIRotationGestureRecognizer * rotationGR =
    [[UIRotationGestureRecognizer alloc] initWithTarget:self action:@selector(rotate:)];
    [imageView addGestureRecognizer:rotationGR];
    rotationGR.delegate = self;
    
    UIPinchGestureRecognizer * pinchGR =
    [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(pinch:)];
    [imageView addGestureRecognizer:pinchGR];
    pinchGR.delegate = self;
    
    UIPanGestureRecognizer * panGR =
    [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(move:)];
    [imageView addGestureRecognizer:panGR];
    panGR.delegate = self;
    
    UITapGestureRecognizer * doubleTapGR =
    [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(relocate:)];
    doubleTapGR.numberOfTapsRequired = 2;
    [self.view addGestureRecognizer:doubleTapGR];
    
    UITapGestureRecognizer * checkGR =
    [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(check:)];
    checkGR.numberOfTapsRequired = 1;
    [self.view addGestureRecognizer:checkGR];
    
    self.label1 = [[UILabel alloc] init];
    self.label1.text = @"label 1";
    self.label1.font = [UIFont boldSystemFontOfSize:20];
    self.label1.frame = CGRectMake(10, 40, 300, 20);
    self.label1.textColor = [UIColor whiteColor];
    self.label1.backgroundColor = [UIColor clearColor];
    self.label1.shadowColor = [UIColor blackColor];
    self.label1.shadowOffset = CGSizeMake(0, 0.5);
    [self.view addSubview:self.label1];
    
    self.label2 = [[UILabel alloc] init];
    self.label2.text = @"label 2";
    self.label2.font = [UIFont boldSystemFontOfSize:20];
    self.label2.frame = CGRectMake(10, 70, 300, 20);
    self.label2.textColor = [UIColor whiteColor];
    self.label2.backgroundColor = [UIColor clearColor];
    self.label2.shadowColor = [UIColor blackColor];
    self.label2.shadowOffset = CGSizeMake(0, 0.5);
    [self.view addSubview:self.label2];
    
}

//触控时输出数值
- (void)trace
{
    self.label1.text =
    [NSString stringWithFormat:@"%.2f, %.2f, %.2f, %.2f",
     self.imageView.frame.origin.x,
     self.imageView.frame.origin.y,
     self.imageView.frame.size.width,
     self.imageView.frame.size.height
     ];
    
    self.label2.text =
    [NSString stringWithFormat:@"%.2f, %.2f, %.2f, %.2f",
     self.imageView.bounds.origin.x,
     self.imageView.bounds.origin.y,
     self.imageView.bounds.size.width,
     self.imageView.bounds.size.height
     ];
}

//点击一次
- (void)check:(UITapGestureRecognizer *)tapGR
{
    //读取点击时相对于当前视图的位置
    CGPoint p1 = [tapGR locationInView:self.view];
    CGPoint p2 = [tapGR locationInView:self.imageView];
    
    self.label1.text =
    [NSString stringWithFormat:@"%.2f, %.2f", p1.x, p1.y];
    self.label2.text =
    [NSString stringWithFormat:@"%.2f, %.2f", p2.x, p2.y];

    //点击时创建label并输入*
    UILabel * label = [[UILabel alloc] init];
    label.text = @"*";
    label.font = [UIFont systemFontOfSize:500];
    CGRect frame = CGRectZero;
    frame.size = CGSizeMake(1000, 1000);
    frame.origin = p2;
    label.frame = frame;
    [self.imageView addSubview:label];
}

- (void)rotate:(UIRotationGestureRecognizer *)rotationGR
{
    CGAffineTransform transform = self.imageView.transform;
    transform = CGAffineTransformRotate(transform, rotationGR.rotation);
    self.imageView.transform = transform;
    rotationGR.rotation = 0;
    [self trace];
}

- (void)pinch:(UIPinchGestureRecognizer *)pinchGR
{
    CGAffineTransform transform = self.imageView.transform;
    transform = CGAffineTransformScale(transform, pinchGR.scale, pinchGR.scale);
    self.imageView.transform = transform;
    pinchGR.scale = 1;
    [self trace];
}

- (void)move:(UIPanGestureRecognizer *)panGR
{
    CGPoint delta = [panGR translationInView:self.view];
    CGPoint center = self.imageView.center;
    center.x += delta.x;
    center.y += delta.y;
    self.imageView.center = center;
    [panGR setTranslation:CGPointZero inView:self.view];
    [self trace];
}

//初始化并居中（注意取值-bounds/image）
- (void)relocate:(id)sender
{
    float horizontalScale =
    self.view.bounds.size.width / self.imageView.image.size.width;
    float verticalScale =
    self.view.bounds.size.height / self.imageView.image.size.height;
    float scale = MIN(horizontalScale, verticalScale);
    
    [UIView animateWithDuration:0.5 animations:^{
        self.imageView.transform = CGAffineTransformMakeScale(scale, scale);
        self.imageView.center = self.view.center;
        [self trace];
    }];
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer
shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    return YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
