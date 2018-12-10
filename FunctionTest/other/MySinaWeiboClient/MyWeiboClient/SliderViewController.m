//
//  SliderViewController.m
//  test1
//
//  Created by hanyfeng on 14-8-30.
//  Copyright (c) 2014年 hanyfeng. All rights reserved.
//

#import "SliderViewController.h"

typedef NS_ENUM(NSInteger, RMoveDirection) {
    RMoveDirectionLeft = 0,//往左拉
    RMoveDirectionRight = 1//往右拉
};

@interface SliderViewController ()<UIGestureRecognizerDelegate>

@property(nonatomic,retain)UIView *mainContentView;
@property(nonatomic,retain)UIView *leftSideView;
@property(nonatomic,retain)UIView *rightSideView;

@property(nonatomic,retain)NSMutableDictionary *controllersDict;

@property(nonatomic,retain)UITapGestureRecognizer *tapGestureRec;
@property(nonatomic,retain)UIPanGestureRecognizer *panGestureRec;

@end







@implementation SliderViewController

#pragma mark - dealloc/init/shareInstance
-(void)dealloc{
#if __has_feature(objc_arc)
    _mainContentView = nil;
    _leftSideView = nil;
    _rightSideView = nil;
    _controllersDict = nil;
    _tapGestureRec = nil;
    _panGestureRec = nil;
    _LeftVC = nil;
    _RightVC = nil;
    _MainVC = nil;
#else
    [_mainContentView release];
    [_leftSideView release];
    [_rightSideView release];
    [_controllersDict release];
    [_tapGestureRec release];
    [_panGestureRec release];
    [_LeftVC release];
    [_RightVC release];
    [_MainVC release];
    [super dealloc];
#endif
    
}

+(SliderViewController *)sharedSliderController
{
    static SliderViewController *shareInstance = nil;
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        shareInstance = [[self alloc] init];
    });
    return shareInstance;
}

- (id)init{
    if (self = [super init])
    {
        _LeftSContentOffset=220;
        _RightSContentOffset=220;
        _LeftSContentScale=1;
        _RightSContentScale=1;
        _LeftSJudgeOffset=160;
        _RightSJudgeOffset=160;
        _LeftSOpenDuration=0.4;
        _RightSOpenDuration=0.4;
        _LeftSCloseDuration=0.3;
        _RightSCloseDuration=0.3;
    }
    
    return self;
}

-(BOOL)prefersStatusBarHidden{
    NSLog(@"*%@-状态栏隐藏设置",NSStringFromClass([self class]));
    return YES;
}

#pragma mark - vc生命周期
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //隐藏navigationBar
    self.navigationController.navigationBar.hidden = YES;
    
    //    //初始化容器
    //    _controllersDict = [NSMutableDictionary dictionary];
    
    //添加subview和ChildViewController
    [self initSubviews];
    [self initChildControllers:self.LeftVC rightVC:self.RightVC];
    
    //设置MainVC和中间视图
    [self showContentControllerWithModel:_MainVC];
    
    //添加手势
    _tapGestureRec = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(closeSideBar)];
    _tapGestureRec.delegate=self;
    [self.view addGestureRecognizer:_tapGestureRec];
    _tapGestureRec.enabled = NO;
    
    _panGestureRec = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(moveViewWithGesture:)];
    [_mainContentView addGestureRecognizer:_panGestureRec];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - init
- (void)initSubviews
{
//    _rightSideView = [[UIView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
//    [self.view addSubview:_rightSideView];
    
    _leftSideView = [[UIView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    [self.view addSubview:_leftSideView];
    
    //最先显示的放最后
    _mainContentView = [[UIView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    [self.view addSubview:_mainContentView];
}

- (void)initChildControllers:(UIViewController*)leftVC rightVC:(UIViewController*)rightVC
{
    leftVC.view.frame = [[UIScreen mainScreen] bounds];
    //    [self addChildViewController:leftVC];
    [_leftSideView addSubview:leftVC.view];
    
//    rightVC.view.frame = [[UIScreen mainScreen] bounds];
//    //    [self addChildViewController:rightVC];
//    [_rightSideView addSubview:rightVC.view];
}

#pragma mark -把指定VC的view显示到mainContentView
-(void)showContentControllerWithModel:(UIViewController *)mainVC
{
    //替换MainVC时_mainContentView复位
    [self closeSideBar];
    
    //移除_mainContentView中的旧MainVC.view
    if (_mainContentView.subviews.count > 0) {
        UIView *view = [[_mainContentView subviews] lastObject];
        [view removeFromSuperview];
    }
    
    //把新实例的view添加到_mainContentView
    mainVC.view.frame = _mainContentView.frame;
    [_mainContentView addSubview:mainVC.view];
}

-(void)setMainVC:(UIViewController *)MainVC
{
    if (_MainVC != MainVC) {
        [_MainVC release];
        _MainVC = [MainVC retain];
        
        [self showContentControllerWithModel:_MainVC];
    }
}

#pragma mark - action
#pragma mark -点击：恢复到原始位置
-(void)closeSideBar
{
    CGAffineTransform oriT = CGAffineTransformIdentity;
    
    //如果mainVC的x轴偏移量等于LeftSContentOffset，则代表展开了左边，否则代表展开了右边
    [UIView animateWithDuration:_mainContentView.transform.tx == _LeftSContentOffset ? _LeftSCloseDuration : _RightSCloseDuration animations:^{
        _mainContentView.transform = oriT;//_mainContentView复位
    } completion:^(BOOL finished) {
        _tapGestureRec.enabled = NO;//取消手势响应
    }];
}

#pragma mark -拖动：设置中间视图在拖动不同状态中的变换
-(void)moveViewWithGesture:(UIPanGestureRecognizer *)panGes
{
    static CGFloat currentTranslateX;
    
    //1.开始时，视图的当前位置相对于(0,0)的横向偏移量，往左拉为负，往右拉为正
    if (panGes.state == UIGestureRecognizerStateBegan) {
        currentTranslateX = _mainContentView.transform.tx;
    }
    
    //2.拖动时，中间视图的变换
    if (panGes.state == UIGestureRecognizerStateChanged) {
        
        //2.1.拖动时，视图的当前位置相对于起始位置（非(0,0)）的横向偏移量
        //会随拖动而不断变化，往左拉为负，往右拉为正
        //CGFloat transX = _mainContentView.transform.tx;//不能用这个
        //CGFloat transX = _mainContentView.frame.origin.x;//不能用这个
        CGFloat tranX = [panGes translationInView:_mainContentView].x;
        
        //2.2.计算出拖动时相对于(0,0)的横向偏移量
        tranX = tranX + currentTranslateX;
        
        //2.3.按照拖动方向计算缩放比例
        CGFloat sca = 1;
        if (tranX > 0) {//往右拉
            [self.view sendSubviewToBack:_rightSideView];//隐藏右边的视图
            [self configureViewShadowWithDirection:RMoveDirectionRight];//设置中间视图的阴影
            
            //设置缩放比例
            if (_mainContentView.frame.origin.x <_LeftSContentOffset) {
                sca = 1 - (_mainContentView.frame.origin.x / _LeftSContentOffset) * (1 - _LeftSContentScale);
            }else{
                sca = _LeftSContentScale;
            }
        }else{//往左拉
            [self.view sendSubviewToBack:_leftSideView];
            [self configureViewShadowWithDirection:RMoveDirectionLeft];
            if (_mainContentView.frame.origin.x < _RightSContentOffset) {
                sca = 1 - (- _mainContentView.frame.origin.x / _RightSContentOffset) * (1 - _RightSContentScale);
            }else{
                sca = _RightSContentScale;
            }
        }
        
        //2.4.组合变化、应用变换
        CGAffineTransform transS = CGAffineTransformMakeScale(sca, sca);
        CGAffineTransform transT = CGAffineTransformMakeTranslation(tranX, 0);
        CGAffineTransform conT = CGAffineTransformConcat(transS, transT);//组合两种变换
        _mainContentView.transform = conT;
    }
    
    //3.结束时，中间视图的变换
    if (panGes.state == UIGestureRecognizerStateEnded) {
        //3.1.结束时，视图的当前位置相对于起始位置（非(0,0)）的横向偏移量
        CGFloat panX = [panGes translationInView:_mainContentView].x;
        
        //3.2.计算出结束时相对于(0,0)的横向偏移量
        CGFloat finalX = panX + currentTranslateX;
        
        //3.3.获取结束时的变换参数，应用变换并用动画显示，并开启点击手势
        if (finalX > _LeftSJudgeOffset) {//往右拉，且超过判定位置
            CGAffineTransform conT = [self transformWithDirection:RMoveDirectionRight];
            [UIView beginAnimations:nil context:nil];
            _mainContentView.transform = conT;
            [UIView commitAnimations];
            _tapGestureRec.enabled = YES;
            return;
        }else if (finalX < - _RightSJudgeOffset) {//往左拉，且超过判定位置
            CGAffineTransform conT = [self transformWithDirection:RMoveDirectionLeft];
            [UIView beginAnimations:nil context:nil];
            _mainContentView.transform = conT;
            [UIView commitAnimations];
            _tapGestureRec.enabled = YES;
            return;
        }else{//往左或者往右拉，没超过判定位置
            CGAffineTransform conT = CGAffineTransformIdentity;
            [UIView beginAnimations:nil context:nil];
            _mainContentView.transform = conT;
            [UIView commitAnimations];
            _tapGestureRec.enabled = YES;
            return;
        }
    }
}

#pragma mark -根据拖动方向 设置mainContentView的阴影
- (void)configureViewShadowWithDirection:(RMoveDirection)direction
{
    CGFloat shadowW;
    switch (direction)
    {
        case RMoveDirectionLeft:
            shadowW = 2.0f;
            break;
        case RMoveDirectionRight:
            shadowW = -2.0f;
            break;
        default:
            break;
    }
    
    _mainContentView.layer.shadowOffset = CGSizeMake(shadowW, 1.0);//阴影偏移量
    _mainContentView.layer.shadowColor = [UIColor blackColor].CGColor;//阴影颜色
    _mainContentView.layer.shadowOpacity = 0.8f;//阴影透明度
}

#pragma mark -根据拖动方向和属性 获取最终变换效果的参数
- (CGAffineTransform)transformWithDirection:(RMoveDirection)direction
{
    CGFloat translateX = 0;
    CGFloat transcale = 0;
    switch (direction) {
        case RMoveDirectionLeft:
            translateX = -_RightSContentOffset;
            transcale = _RightSContentScale;
            break;
        case RMoveDirectionRight:
            translateX = _LeftSContentOffset;
            transcale = _LeftSContentScale;
            break;
        default:
            break;
    }
    
    CGAffineTransform transT = CGAffineTransformMakeTranslation(translateX, 0);
    CGAffineTransform scaleT = CGAffineTransformMakeScale(transcale, transcale);
    CGAffineTransform conT = CGAffineTransformConcat(transT, scaleT);
    
    return conT;
}

- (void)showLeftViewController
{
    CGAffineTransform conT = [self transformWithDirection:RMoveDirectionRight];
    [self.view sendSubviewToBack:_rightSideView];
    [self configureViewShadowWithDirection:RMoveDirectionRight];
    [UIView animateWithDuration:_LeftSOpenDuration animations:^{
        _mainContentView.transform = conT;
    } completion:^(BOOL finished) {
        _tapGestureRec.enabled = YES;
    }];
}

- (void)showRightViewController
{
    CGAffineTransform conT = [self transformWithDirection:RMoveDirectionLeft];
    [self.view sendSubviewToBack:_leftSideView];
    [self configureViewShadowWithDirection:RMoveDirectionLeft];
    [UIView animateWithDuration:_RightSOpenDuration animations:^{
        _mainContentView.transform = conT;
    } completion:^(BOOL finished) {
        _tapGestureRec.enabled = YES;
    }];
}

#pragma mark - UIGestureRecognizerDelegate
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
    //如果点击的是cell则不响应手势
    if ([NSStringFromClass([touch.view class]) isEqualToString:@"UITableViewCellContentView"]) {
        return NO;
    }
    return  YES;
}

@end
