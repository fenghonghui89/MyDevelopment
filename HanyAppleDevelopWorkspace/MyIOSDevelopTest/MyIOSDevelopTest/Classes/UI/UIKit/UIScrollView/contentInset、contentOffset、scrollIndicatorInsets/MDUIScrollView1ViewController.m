//
//  MDUIScrollView1ViewController.m
//  MyDevelopmentTest
//
//  Created by hanyfeng on 15/2/28.
//  Copyright (c) 2015年 hanyfeng. All rights reserved.
//

#import "MDUIScrollView1ViewController.h"
#import "UIImage+Scale.h"
#define MaxScale 5.0
#define MinScale 0.5
@interface MDUIScrollView1ViewController ()<UIScrollViewDelegate>

@property (weak, nonatomic) IBOutlet UIButton *btn1;
@property (weak, nonatomic) IBOutlet UIButton *btn2;
@property (weak, nonatomic) IBOutlet UIButton *btn3;
@property (weak, nonatomic) IBOutlet UIButton *btn4;
@property (weak, nonatomic) IBOutlet UIButton *btn5;
@property (weak, nonatomic) IBOutlet UIButton *btn6;

@property(nonatomic,strong)UIScrollView *scrollView;
@property(nonatomic,strong)UIImageView *imageView;
@property(nonatomic,strong)NSTimer *addTimer;
@property(nonatomic,strong)NSTimer *minusTimer;
@property(nonatomic,strong)NSTimer *topTimer;
@property(nonatomic,strong)NSTimer *bottomTimer;
@property(nonatomic,strong)NSTimer *leftTimer;
@property(nonatomic,strong)NSTimer *rightTimer;

@end

@implementation MDUIScrollView1ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.btn1 setTitle:@"↑" forState:UIControlStateNormal];
    [self.btn2 setTitle:@"↓" forState:UIControlStateNormal];
    [self.btn3 setTitle:@"←" forState:UIControlStateNormal];
    [self.btn4 setTitle:@"→" forState:UIControlStateNormal];
    [self.btn5 setTitle:@"+" forState:UIControlStateNormal];
    [self.btn6 setTitle:@"-" forState:UIControlStateNormal];
    
    UIImageView *iv = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"big.jpg"]];
    CGSize ivSize = iv.frame.size;
    NSLog(@"img size ...%@",NSStringFromCGSize(ivSize));
    //    UIColor *color = [UIColor colorWithPatternImage:ImageFile(@"image/big")];
    
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, screenW, screenH)];
//    scrollView.userInteractionEnabled = NO;
    scrollView.contentSize = ivSize;
    //    scrollView.backgroundColor = color;
    scrollView.delegate = self;
    [scrollView addSubview:iv];
    self.imageView = iv;
    
    //设置最大最小缩放比例（计算scrollView与imageView1的宽高比，最小缩放比例取最小值，最大缩放比例取原图大小）
    //    float horizontalScale = scrollView.frame.size.width / imageView1.frame.size.width;//宽
    //    float verticalScale = scrollView.frame.size.height / imageView1.frame.size.height;//高
    //    scrollView.minimumZoomScale = MIN(horizontalScale, verticalScale);
    //    scrollView.maximumZoomScale = 1.0;
    scrollView.minimumZoomScale = 1;
    scrollView.maximumZoomScale = 5.0;
    
    //设置是否显示滚动条
    /*使用scrollView时，默认两个滚动条是开启的，如果通过拖动显示超出屏幕的内容，滚动条就会出现，这时scrollView的subViews.count就会+2（两个滚动条），而不是里面的内容个数，如果不需要用到滚动条，可以通过禁用滚动条解决*/
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.showsVerticalScrollIndicator = NO;
    scrollView.bounces = NO;
    
    //content与scrollview之间的距离（初始状态时不一定全部方向都有效果，拖动到边缘并停止后就会有效果）
    //    scrollView.contentInset = UIEdgeInsetsMake(10, 10, 10, 10);
    
    //"scroll"原点相对于content原点的偏移量，往右下滚为负（显示上面的内容），往左上滚为正（显示下面的内容）（初始状态下才有效果，可以用来判断scrollview滚动的位置）
    //    [scrollView setContentOffset:CGPointMake(50, 50) animated:YES];
    
    //滚动条与scrollview之间的距离
    //    scrollView.scrollIndicatorInsets = UIEdgeInsetsMake(10,10,10,10);
    
    [scrollView setZoomScale:1 animated:NO];
    [scrollView setContentOffset:CGPointMake(ivSize.width*0.5, ivSize.height*0.5) animated:NO];
    
    self.scrollView = scrollView;
    
//    [self.scrollView setZoomScale:1.5 animated:NO];
//    [self.scrollView setContentOffset:CGPointMake(0,self.imageView.frame.size.height-self.scrollView.height) animated:NO];
    
    
    
    [self.view addSubview:scrollView];
    [self.view sendSubviewToBack:scrollView];
}


#pragma mark - UIScrollViewDelegate 协议方法 以下方法缩放时调用-
- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return self.imageView;
}

//-(void)scrollViewDidZoom:(UIScrollView *)scrollView{
//
//}
//
//-(void)scrollViewDidEndZooming:(UIScrollView *)scrollView withView:(UIView *)view atScale:(CGFloat)scale
//{
//    UIImage *scaleImage = [self.imageView.image scaleToScale:scale];
//    UIColor *color = [UIColor colorWithPatternImage:scaleImage];
//    self.scrollView.backgroundColor = color;
//    NSLog(@"2.。%f",scale);
//}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    //  NSLog(@"inset:%f,offset:%f",scrollView.contentInset.top,scrollView.contentOffset.y);
    NSLog(@"contentOffset %f %f",scrollView.contentOffset.x,scrollView.contentOffset.y);
    //  NSLog(@"scrollview bound:%@",NSStringFromCGRect(scrollView.bounds));
}

#pragma mark - action

- (IBAction)tap1:(id)sender {
    NSLog(@"上...%@",NSStringFromCGPoint(self.scrollView.contentOffset));
    CGFloat x = self.scrollView.contentOffset.x;
    CGFloat y = self.scrollView.contentOffset.y+5;
    [self.scrollView setContentOffset:CGPointMake(x, y) animated:NO];
}
- (IBAction)tap2:(id)sender {
    NSLog(@"下...%@",NSStringFromCGPoint(self.scrollView.contentOffset));
    CGFloat x = self.scrollView.contentOffset.x;
    CGFloat y = self.scrollView.contentOffset.y-5;
    [self.scrollView setContentOffset:CGPointMake(x, y) animated:NO];
}
- (IBAction)tap3:(id)sender {
    NSLog(@"左...%@",NSStringFromCGPoint(self.scrollView.contentOffset));
    CGFloat x = self.scrollView.contentOffset.x+5;
    CGFloat y = self.scrollView.contentOffset.y;
    [self.scrollView setContentOffset:CGPointMake(x, y) animated:NO];
}
- (IBAction)tap4:(id)sender {
    NSLog(@"右...%@",NSStringFromCGPoint(self.scrollView.contentOffset));
    CGFloat x = self.scrollView.contentOffset.x-5;
    CGFloat y = self.scrollView.contentOffset.y;
    [self.scrollView setContentOffset:CGPointMake(x, y) animated:NO];
}
- (IBAction)tap5:(id)sender {
    self.scrollView.zoomScale += 0.05;
    NSLog(@"放大。。%f",self.scrollView.zoomScale);
}
- (IBAction)tap6:(id)sender {
    self.scrollView.zoomScale -= 0.05;
    NSLog(@"缩小。。%f",self.scrollView.zoomScale);
}

#pragma mark - 长按
-(void)longPressAdd:(UILongPressGestureRecognizer *)longPress{
    //    NSLog(@"放大。。%f",self.scrollView.zoomScale);
    //    self.scrollView.zoomScale = self.scrollView.zoomScale+0.01;
    //    if (longPress.state == UIGestureRecognizerStateBegan) {
    //        NSLog(@"放大long pressTap state :begin");
    //    }else {
    //        NSLog(@"放大long pressTap state :end");
    //    }
    
    switch (longPress.state) {
        case UIGestureRecognizerStateBegan:
            NSLog(@"放大long pressTap state :begin");
            [self startTimer:YES];
            break;
        case UIGestureRecognizerStateEnded:
            NSLog(@"放大long pressTap state :end");
            [self stopTimer:YES];
            break;
        default:
            break;
    }
}

-(void)longPressMinus:(UILongPressGestureRecognizer *)longPress{
    //    NSLog(@"缩小。。%f",self.scrollView.zoomScale);
    //    self.scrollView.zoomScale = self.scrollView.zoomScale-0.01;
    
    switch (longPress.state) {
        case UIGestureRecognizerStateBegan:
            NSLog(@"缩小long pressTap state :begin");
            [self startTimer:NO];
            break;
        case UIGestureRecognizerStateEnded:
            NSLog(@"缩小long pressTap state :end");
            [self stopTimer:NO];
            break;
        default:
            break;
    }
}

-(void)longPressAdd:(UILongPressGestureRecognizer *)longPress{
    //    NSLog(@"缩小。。%f",self.scrollView.zoomScale);
    //    self.scrollView.zoomScale = self.scrollView.zoomScale-0.01;
    
    switch (longPress.state) {
        case UIGestureRecognizerStateBegan:
            NSLog(@"缩小long pressTap state :begin");
            [self startTimer:NO];
            break;
        case UIGestureRecognizerStateEnded:
            NSLog(@"缩小long pressTap state :end");
            [self stopTimer:NO];
            break;
        default:
            break;
    }
}

-(void)longPressBottom:(UILongPressGestureRecognizer *)longPress{
    //    NSLog(@"缩小。。%f",self.scrollView.zoomScale);
    //    self.scrollView.zoomScale = self.scrollView.zoomScale-0.01;
    
    switch (longPress.state) {
        case UIGestureRecognizerStateBegan:
            NSLog(@"缩小long pressTap state :begin");
            [self startTimer:NO];
            break;
        case UIGestureRecognizerStateEnded:
            NSLog(@"缩小long pressTap state :end");
            [self stopTimer:NO];
            break;
        default:
            break;
    }
}

-(void)longPressLeft:(UILongPressGestureRecognizer *)longPress{
    //    NSLog(@"缩小。。%f",self.scrollView.zoomScale);
    //    self.scrollView.zoomScale = self.scrollView.zoomScale-0.01;
    
    switch (longPress.state) {
        case UIGestureRecognizerStateBegan:
            NSLog(@"缩小long pressTap state :begin");
            [self startTimer:NO];
            break;
        case UIGestureRecognizerStateEnded:
            NSLog(@"缩小long pressTap state :end");
            [self stopTimer:NO];
            break;
        default:
            break;
    }
}

-(void)longPressRight:(UILongPressGestureRecognizer *)longPress{
    //    NSLog(@"缩小。。%f",self.scrollView.zoomScale);
    //    self.scrollView.zoomScale = self.scrollView.zoomScale-0.01;
    
    switch (longPress.state) {
        case UIGestureRecognizerStateBegan:
            NSLog(@"缩小long pressTap state :begin");
            [self startTimer:NO];
            break;
        case UIGestureRecognizerStateEnded:
            NSLog(@"缩小long pressTap state :end");
            [self stopTimer:NO];
            break;
        default:
            break;
    }
}

-(void)startTimer:(NSInteger)isAdd{
    
    if (isAdd) {
        if (self.addTimer) {
            return;
        }
    }else{
        if (self.minusTimer) {
            return;
        }
    }
    
    __weak typeof(self) weak_self = self;
    NSTimer *timer = [NSTimer timerWithTimeInterval:0.1 repeats:YES block:^(NSTimer * _Nonnull timer) {
        if (isAdd) {
            [weak_self timerFired_add];
        }else{
            [weak_self timerFired_minus];
        }
    }];
    
    
    if (isAdd) {
        self.addTimer = timer;
    }else{
        self.minusTimer = timer;
    }
    
    [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
}

-(void)timerFired_add{
    NSLog(@"放大。。%f",self.scrollView.zoomScale);
    self.scrollView.zoomScale += 0.05;
}

-(void)timerFired_minus{
    NSLog(@"缩小。。%f",self.scrollView.zoomScale);
    self.scrollView.zoomScale -= 0.05;
}

-(void)timerFired_add{
    NSLog(@"缩小。。%f",self.scrollView.zoomScale);
    self.scrollView.zoomScale -= 0.05;
}

-(void)timerFired_bottom{
    NSLog(@"缩小。。%f",self.scrollView.zoomScale);
    self.scrollView.zoomScale -= 0.05;
}

-(void)timerFired_minus{
    NSLog(@"缩小。。%f",self.scrollView.zoomScale);
    self.scrollView.zoomScale -= 0.05;
}

-(void)timerFired_minus{
    NSLog(@"缩小。。%f",self.scrollView.zoomScale);
    self.scrollView.zoomScale -= 0.05;
}

-(void)stopTimer:(NSInteger)isAdd{
    
    if (isAdd) {
        if (self.addTimer) {
            NSLog(@"关闭add定时器。。");
            [self.addTimer invalidate];
            self.addTimer = nil;
        }
    }else{
        if (self.minusTimer) {
            NSLog(@"关闭minus定时器。。");
            [self.minusTimer invalidate];
            self.minusTimer = nil;
        }
    }
}


@end
