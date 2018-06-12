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

typedef NS_ENUM(NSInteger,XTJMoveType) {
    XTJMoveTypeTop,
    XTJMoveTypeBottom,
    XTJMoveTypeLeft,
    XTJMoveTypeRight,
    XTJMoveTypeAdd,
    XTJMoveTypeMinus
};

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
    
    UILongPressGestureRecognizer *grTop = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressTop:)];
    grTop.minimumPressDuration = 0.3;
    grTop.allowableMovement = 1;
    [self.btn1 addGestureRecognizer:grTop];
    
    UILongPressGestureRecognizer *grBottom = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressBottom:)];
    grBottom.minimumPressDuration = 0.3;
    grBottom.allowableMovement = 1;
    [self.btn2 addGestureRecognizer:grBottom];
    
    UILongPressGestureRecognizer *grLeft = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressLeft:)];
    grLeft.minimumPressDuration = 0.3;
    grLeft.allowableMovement = 1;
    [self.btn3 addGestureRecognizer:grLeft];
    
    UILongPressGestureRecognizer *grRight = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressRight:)];
    grRight.minimumPressDuration = 0.3;
    grRight.allowableMovement = 1;
    [self.btn4 addGestureRecognizer:grRight];
    
    UILongPressGestureRecognizer *grAdd = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressAdd:)];
    grAdd.minimumPressDuration = 0.3;
    grAdd.allowableMovement = 1;
    [self.btn5 addGestureRecognizer:grAdd];
    
    UILongPressGestureRecognizer *grMinus = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressMinus:)];
    grMinus.minimumPressDuration = 0.3;
    grMinus.allowableMovement = 1;
    [self.btn6 addGestureRecognizer:grMinus];
    
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
    
    [scrollView setZoomScale:1.5 animated:NO];
//    [scrollView setContentOffset:CGPointMake(ivSize.width*0.5, ivSize.height*0.5) animated:NO];
    
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
//    NSLog(@"contentOffset %f %f",scrollView.contentOffset.x,scrollView.contentOffset.y);
    //  NSLog(@"scrollview bound:%@",NSStringFromCGRect(scrollView.bounds));
}

#pragma mark - action

- (IBAction)tap1:(id)sender {
    [self scrollViewTop];
}
- (IBAction)tap2:(id)sender {
    [self scrollViewBottom];
}
- (IBAction)tap3:(id)sender {
    [self scrollViewLeft];
}
- (IBAction)tap4:(id)sender {
    [self scrollViewRight];
}
- (IBAction)tap5:(id)sender {
    [self scrollViewAdd];
}
- (IBAction)tap6:(id)sender {
    [self scrollViewMinus];
}

#pragma mark 定时器
-(void)startTimer:(XTJMoveType)type{
    
    switch (type) {
        case XTJMoveTypeTop:
            if (self.topTimer) {
                return;
            }
            break;
        case XTJMoveTypeBottom:
            if (self.bottomTimer) {
                return;
            }
            break;
        case XTJMoveTypeLeft:
            if (self.leftTimer) {
                return;
            }
            break;
        case XTJMoveTypeRight:
            if (self.rightTimer) {
                return;
            }
            break;
        case XTJMoveTypeAdd:
            if (self.addTimer) {
                return;
            }
            break;
        case XTJMoveTypeMinus:
            if (self.minusTimer) {
                return;
            }
            break;
        default:
            break;
    }
    
    __weak typeof(self) weak_self = self;
    NSTimer *timer = [NSTimer timerWithTimeInterval:0.1 repeats:YES block:^(NSTimer * _Nonnull timer) {
        switch (type) {
            case XTJMoveTypeTop:
                [weak_self timerFired_top];
                break;
            case XTJMoveTypeBottom:
                [weak_self timerFired_bottom];
                break;
            case XTJMoveTypeLeft:
                [weak_self timerFired_left];
                break;
            case XTJMoveTypeRight:
                [weak_self timerFired_right];
                break;
            case XTJMoveTypeAdd:
                [weak_self timerFired_add];
                break;
            case XTJMoveTypeMinus:
                [weak_self timerFired_minus];
                break;
            default:
                break;
        }
    }];
    
    
    switch (type) {
        case XTJMoveTypeTop:
            self.topTimer = timer;
            break;
        case XTJMoveTypeBottom:
            self.bottomTimer = timer;
            break;
        case XTJMoveTypeLeft:
            self.leftTimer = timer;
            break;
        case XTJMoveTypeRight:
            self.rightTimer = timer;
            break;
        case XTJMoveTypeAdd:
            self.addTimer = timer;
            break;
        case XTJMoveTypeMinus:
            self.minusTimer = timer;
            break;
        default:
            break;
    }
    
    [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
}

-(void)stopTimer:(XTJMoveType)type{
    
    switch (type) {
        case XTJMoveTypeTop:
            if (self.topTimer) {
                NSLog(@"关闭top定时器。。");
                [self.topTimer invalidate];
                self.topTimer = nil;
            }
            break;
        case XTJMoveTypeBottom:
            if (self.bottomTimer) {
                NSLog(@"关闭bottom定时器。。");
                [self.bottomTimer invalidate];
                self.bottomTimer = nil;
            }
            break;
        case XTJMoveTypeLeft:
            if (self.leftTimer) {
                NSLog(@"关闭left定时器。。");
                [self.leftTimer invalidate];
                self.leftTimer = nil;
            }
            break;
        case XTJMoveTypeRight:
            if (self.rightTimer) {
                NSLog(@"关闭right定时器。。");
                [self.rightTimer invalidate];
                self.rightTimer = nil;
            }
            break;
        case XTJMoveTypeAdd:
            if (self.addTimer) {
                NSLog(@"关闭add定时器。。");
                [self.addTimer invalidate];
                self.addTimer = nil;
            }
            break;
        case XTJMoveTypeMinus:
            if (self.minusTimer) {
                NSLog(@"关闭minus定时器。。");
                [self.minusTimer invalidate];
                self.minusTimer = nil;
            }
            break;
        default:
            break;
    }
}

-(void)timerFired_top{
    [self scrollViewTop];
}

-(void)timerFired_bottom{
    [self scrollViewBottom];
}

-(void)timerFired_left{
    [self scrollViewLeft];
}

-(void)timerFired_right{
    [self scrollViewRight];
}

-(void)timerFired_add{
    [self scrollViewAdd];
}

-(void)timerFired_minus{
    [self scrollViewMinus];
}

#pragma mark - 长按
-(void)longPressAdd:(UILongPressGestureRecognizer *)longPress{
    
    switch (longPress.state) {
        case UIGestureRecognizerStateBegan:
            [self startTimer:XTJMoveTypeAdd];
            break;
        case UIGestureRecognizerStateEnded:
            [self stopTimer:XTJMoveTypeAdd];
            break;
        default:
            break;
    }
}

-(void)longPressMinus:(UILongPressGestureRecognizer *)longPress{
    
    switch (longPress.state) {
        case UIGestureRecognizerStateBegan:
            [self startTimer:XTJMoveTypeMinus];
            break;
        case UIGestureRecognizerStateEnded:
            [self stopTimer:XTJMoveTypeMinus];
            break;
        default:
            break;
    }
}

-(void)longPressTop:(UILongPressGestureRecognizer *)longPress{
    switch (longPress.state) {
        case UIGestureRecognizerStateBegan:
            [self startTimer:XTJMoveTypeTop];
            break;
        case UIGestureRecognizerStateEnded:
            [self stopTimer:XTJMoveTypeTop];
            break;
        default:
            break;
    }
}

-(void)longPressBottom:(UILongPressGestureRecognizer *)longPress{
    switch (longPress.state) {
        case UIGestureRecognizerStateBegan:
            [self startTimer:XTJMoveTypeBottom];
            break;
        case UIGestureRecognizerStateEnded:
            [self stopTimer:XTJMoveTypeBottom];
            break;
        default:
            break;
    }
}

-(void)longPressLeft:(UILongPressGestureRecognizer *)longPress{
    switch (longPress.state) {
        case UIGestureRecognizerStateBegan:
            [self startTimer:XTJMoveTypeLeft];
            break;
        case UIGestureRecognizerStateEnded:
            [self stopTimer:XTJMoveTypeLeft];
            break;
        default:
            break;
    }
}

-(void)longPressRight:(UILongPressGestureRecognizer *)longPress{
    switch (longPress.state) {
        case UIGestureRecognizerStateBegan:
            [self startTimer:XTJMoveTypeRight];
            break;
        case UIGestureRecognizerStateEnded:
            [self stopTimer:XTJMoveTypeRight];
            break;
        default:
            break;
    }
}

#pragma mark - move
-(void)scrollViewAdd{
    self.scrollView.zoomScale += 0.05;
    NSLog(@"放大。。%f",self.scrollView.zoomScale);
}

-(void)scrollViewMinus{
    self.scrollView.zoomScale -= 0.05;
    NSLog(@"缩小。。%f",self.scrollView.zoomScale);
}

-(void)scrollViewTop{
    
    CGFloat limit = self.imageView.height - self.scrollView.height;
    CGFloat x = self.scrollView.contentOffset.x;
    CGFloat y = self.scrollView.contentOffset.y+5;
    if (y >= limit) {
        y = limit;
    }
    
    [self.scrollView setContentOffset:CGPointMake(x, y) animated:NO];
    NSLog(@"上...%@",NSStringFromCGPoint(self.scrollView.contentOffset));
}

-(void)scrollViewBottom{
    
    CGFloat limit = 0;
    CGFloat x = self.scrollView.contentOffset.x;
    CGFloat y = self.scrollView.contentOffset.y-5;
    if (y <= limit) {
        y = 0;
    }
    
    [self.scrollView setContentOffset:CGPointMake(x, y) animated:NO];
    NSLog(@"下...%@",NSStringFromCGPoint(self.scrollView.contentOffset));
}

-(void)scrollViewLeft{
    
    CGFloat limit = self.imageView.width - self.scrollView.width;
    CGFloat x = self.scrollView.contentOffset.x+5;
    CGFloat y = self.scrollView.contentOffset.y;
    if (x >= limit) {
        x = limit;
    }
    
    [self.scrollView setContentOffset:CGPointMake(x, y) animated:NO];
    NSLog(@"左...%@",NSStringFromCGPoint(self.scrollView.contentOffset));
}

-(void)scrollViewRight{
    
    CGFloat limit = 0;
    CGFloat x = self.scrollView.contentOffset.x-5;
    CGFloat y = self.scrollView.contentOffset.y;
    if (x <= limit) {
        x = 0;
    }
    
    [self.scrollView setContentOffset:CGPointMake(x, y) animated:NO];
    NSLog(@"右...%@",NSStringFromCGPoint(self.scrollView.contentOffset));
}



@end
