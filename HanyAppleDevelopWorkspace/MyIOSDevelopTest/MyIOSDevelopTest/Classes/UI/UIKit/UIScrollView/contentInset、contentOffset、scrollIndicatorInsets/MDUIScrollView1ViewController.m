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
@property(retain,nonatomic)UIImageView* imageView;
@property(nonatomic,strong)UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIButton *btn1;
@property (weak, nonatomic) IBOutlet UIButton *btn2;
@property (weak, nonatomic) IBOutlet UIButton *btn3;
@property (weak, nonatomic) IBOutlet UIButton *btn4;
@property (weak, nonatomic) IBOutlet UIButton *btn5;
@property (weak, nonatomic) IBOutlet UIButton *btn6;
@property(nonatomic,assign)CGFloat scale;
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
    
    self.scale = 1;
    UIImage *image = [UIImage imageNamed:@"timg.jpg"];
//    image = [image scaleToScale:self.scale];
    UIImageView* imageView1 = [[UIImageView alloc] initWithImage:image];
    UIColor *color = [UIColor colorWithPatternImage:image];
    UIScrollView* scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(10, 10, [[UIScreen mainScreen] bounds].size.width - 20, [[UIScreen mainScreen] bounds].size.height - 20)];
    NSLog(@"图片size:%@",NSStringFromCGSize(imageView1.frame.size));
//    scrollView.contentSize = imageView1.frame.size;
//    scrollView.contentSize = CGSizeMake(0, 0);
//    [scrollView setBackgroundColor:[UIColor redColor]];
    scrollView.backgroundColor = color;
    scrollView.delegate = self;
    [scrollView addSubview:imageView1];
    self.imageView = imageView1;
    
    //设置最大最小缩放比例（计算scrollView与imageView1的宽高比，最小缩放比例取最小值，最大缩放比例取原图大小）
    float horizontalScale = scrollView.frame.size.width / imageView1.frame.size.width;//宽
    float verticalScale = scrollView.frame.size.height / imageView1.frame.size.height;//高
    scrollView.minimumZoomScale = MIN(horizontalScale, verticalScale);
    scrollView.maximumZoomScale = 1.0;
    scrollView.minimumZoomScale = MinScale;
    scrollView.maximumZoomScale = MaxScale;
    NSLog(@"min:%f max:%f",scrollView.minimumZoomScale,scrollView.maximumZoomScale);
    
    //设置是否显示滚动条
    /*使用scrollView时，默认两个滚动条是开启的，如果通过拖动显示超出屏幕的内容，滚动条就会出现，这时scrollView的subViews.count就会+2（两个滚动条），而不是里面的内容个数，如果不需要用到滚动条，可以通过禁用滚动条解决*/
    scrollView.showsHorizontalScrollIndicator = YES;
    scrollView.showsVerticalScrollIndicator = YES;
    
    //content与scrollview之间的距离（初始状态时不一定全部方向都有效果，拖动到边缘并停止后就会有效果）
//    scrollView.contentInset = UIEdgeInsetsMake(10, 10, 10, 10);
    
    //"scroll"原点相对于content原点的偏移量，往右下滚为负（显示上面的内容），往左上滚为正（显示下面的内容）（初始状态下才有效果，可以用来判断scrollview滚动的位置）
    //    [scrollView setContentOffset:CGPointMake(50, 50) animated:YES];
    
    //滚动条与scrollview之间的距离
//    scrollView.scrollIndicatorInsets = UIEdgeInsetsMake(10,10,10,10);
    
    scrollView.bounces = NO;
    
    [self.view addSubview:scrollView];
    [self.view sendSubviewToBack:scrollView];
    
    self.scrollView = scrollView;
}

#pragma mark - UIScrollViewDelegate 协议方法 以下方法缩放时调用-
- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
//    NSLog(@"1...%f",self.scale);
//    UIImage *image = [UIImage imageNamed:@"timg.jpg"];
//    image = [image scaleToScale:self.scale];
//    UIImageView* imageView1 = [[UIImageView alloc] initWithImage:image];
//
//    return imageView1;
    
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
    NSLog(@"%f %f",scrollView.contentOffset.x,scrollView.contentOffset.y);
    //  NSLog(@"scrollview bound:%@",NSStringFromCGRect(scrollView.bounds));
}

#pragma mark - action

- (IBAction)tap1:(id)sender {
    NSLog(@"上...%@",NSStringFromCGPoint(self.scrollView.contentOffset));
    CGFloat x = self.scrollView.contentOffset.x;
    CGFloat y = self.scrollView.contentOffset.y+10;
    [self.scrollView setContentOffset:CGPointMake(x, y) animated:NO];
}
- (IBAction)tap2:(id)sender {
    NSLog(@"下...%@",NSStringFromCGPoint(self.scrollView.contentOffset));
    CGFloat x = self.scrollView.contentOffset.x;
    CGFloat y = self.scrollView.contentOffset.y-10;
    [self.scrollView setContentOffset:CGPointMake(x, y) animated:NO];
}
- (IBAction)tap3:(id)sender {
    NSLog(@"左...%@",NSStringFromCGPoint(self.scrollView.contentOffset));
    CGFloat x = self.scrollView.contentOffset.x+10;
    CGFloat y = self.scrollView.contentOffset.y;
    [self.scrollView setContentOffset:CGPointMake(x, y) animated:NO];
}
- (IBAction)tap4:(id)sender {
    NSLog(@"右...%@",NSStringFromCGPoint(self.scrollView.contentOffset));
    CGFloat x = self.scrollView.contentOffset.x-10;
    CGFloat y = self.scrollView.contentOffset.y;
    [self.scrollView setContentOffset:CGPointMake(x, y) animated:NO];
}
- (IBAction)tap5:(id)sender {
//    self.scrollView.zoomScale += 0.05;
//    CGFloat scale = self.scrollView.zoomScale+0.3;
    CGFloat scale = self.scale+0.3;
    if (scale>MaxScale) {
        scale = MaxScale;
    }
    self.scale = scale;
    [self.scrollView setZoomScale:scale animated:YES];
}
- (IBAction)tap6:(id)sender {
//    self.scrollView.zoomScale -= 0.05;
//    NSLog(@"contentOffset...%@",NSStringFromCGPoint(self.scrollView.contentOffset));
//    CGFloat scale = self.scrollView.zoomScale-0.3;
    CGFloat scale = self.scale-0.3;
    if (scale<MinScale) {
        scale = MinScale;
    }
    self.scale = scale;
    [self.scrollView setZoomScale:scale animated:YES];
}



@end
