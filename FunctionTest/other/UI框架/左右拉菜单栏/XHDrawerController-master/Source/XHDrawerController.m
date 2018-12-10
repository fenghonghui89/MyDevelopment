//
//  XHDrawerController.m
//  XHDrawerController
//
//  Created by 曾 宪华 on 13-12-27.
//  Copyright (c) 2013年 曾宪华 开发团队(http://iyilunba.com ) 本人QQ:543413507. All rights reserved.
//

#import "XHDrawerController.h"
#import "XHZoomDrawerView.h"
#import "XHDrawerControllerHeader.h"

#import <objc/runtime.h>

static const CGFloat XHAnimateDuration = 0.3f;
static const CGFloat XHAnimationDampingDuration = 0.5f;
static const CGFloat XHAnimationVelocity = 22.0f;


const char *XHDrawerControllerKey = "XHDrawerControllerKey";

//typedef enum ScrollDirection {
//    ScrollDirectionNone,
//    ScrollDirectionRight,
//    ScrollDirectionLeft,
//    ScrollDirectionUp,
//    ScrollDirectionDown,
//    ScrollDirectionCrazy,
//} ScrollDirection;

#pragma mark - 分类
//重写分类所扩展属性的set/get
@implementation UIViewController (XHDrawerController)

//set
- (void)setDrawerController:(XHDrawerController *)drawerController {
    objc_setAssociatedObject(self, &XHDrawerControllerKey, drawerController, OBJC_ASSOCIATION_ASSIGN);
}

//get
- (XHDrawerController *)drawerController {
    XHDrawerController *panDrawerController = objc_getAssociatedObject(self, &XHDrawerControllerKey);
    
    if (!panDrawerController) {
        panDrawerController = self.parentViewController.drawerController;
    }
    
    return panDrawerController;
}

@end


#pragma mark - 子类
@interface XHDrawerController () <UIScrollViewDelegate>

@property (nonatomic, assign, readwrite) XHDrawerSide openSide;//读取.h的同名属性

@property (nonatomic, strong) XHZoomDrawerView *zoomDrawerView;
@property (nonatomic, readonly) UIScrollView *scrollView;//读取zoomDrawerView的scrollview属性
@property (nonatomic, assign) NSInteger cuurrentContentOffsetX;

@end

@implementation XHDrawerController

#pragma mark - UIViewController Overrides

- (void)setup {
    self.animateDuration = XHAnimateDuration;
    self.animationDampingDuration = XHAnimationDampingDuration;
    self.animationVelocity = XHAnimationVelocity;
    self.openSide = XHDrawerSideNone;
}

- (id)init {
    self = [super init];
    if (self) {
        [self setup];
    }
    return self;
}

//创建zoomDrawerView作为自己的view
- (void)loadView {
    _zoomDrawerView = [[XHZoomDrawerView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.zoomDrawerView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    self.zoomDrawerView.autoresizesSubviews = YES;
    self.view = self.zoomDrawerView;
}

- (void)viewDidLoad {
    self.zoomDrawerView.scrollView.delegate = self;
    self.zoomDrawerView.contentContainerButton.userInteractionEnabled = NO;
    [self.zoomDrawerView.contentContainerButton addTarget:self action:@selector(contentContainerButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -按钮方法-返回到中间
- (void)contentContainerButtonPressed:(id)sender {
    [self closeDrawerAnimated:YES completion:NULL];
}

#pragma mark - Open/Close methods
#pragma mark -open
- (void)toggleDrawerSide:(XHDrawerSide)drawerSide animated:(BOOL)animated completion:(void (^)(BOOL finished))completion {
    
    //断言-如果输入的参数为none则中断
    NSParameterAssert(drawerSide != XHDrawerSideNone);
    
    //如果属性openSide为none，则open，否则close
    if(self.openSide == XHDrawerSideNone){
        [self openDrawerSide:drawerSide animated:animated velocity:self.animationVelocity animationOptions:UIViewAnimationOptionCurveEaseInOut completion:completion];
    } else {
        if((drawerSide == XHDrawerSideLeft &&
            self.openSide == XHDrawerSideLeft) ||
           (drawerSide == XHDrawerSideRight &&
            self.openSide == XHDrawerSideRight)){
               [self closeDrawerAnimated:animated completion:completion];
           }
        else if(completion) {
            completion(NO);
        }
    }
}

- (void)openDrawerSide:(XHDrawerSide)drawerSide animated:(BOOL)animated velocity:(CGFloat)velocity animationOptions:(UIViewAnimationOptions)options completion:(void (^)(BOOL finished))completion {
    //断言-如果输入的参数为none则中断
    NSParameterAssert(drawerSide != XHDrawerSideNone);
    
    self.openSide = drawerSide;
    
    CGFloat damping = [self isSpringAnimationOn] ? 0.7f : 1.0f;
    
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 7.0) {
        //ios7.0
        [UIView animateWithDuration:0.5 delay:0.0 usingSpringWithDamping:damping initialSpringVelocity:velocity options:UIViewAnimationOptionAllowAnimatedContent animations:^{
            if (drawerSide == XHDrawerSideLeft) {
                [self.scrollView setContentOffset:CGPointMake(0.0f, 0.0f) animated:NO];
            } else if (drawerSide == XHDrawerSideRight) {
                [self.scrollView setContentOffset:CGPointMake(2 * XHContentContainerViewOriginX, 0.0f) animated:NO];
            }
        } completion:^(BOOL finished) {
            self.openSide = drawerSide;
            self.zoomDrawerView.contentContainerButton.userInteractionEnabled = YES;
            if (completion) {
                completion(finished);
            }
        }];
    } else {
        //ios 6.0
        [UIView animateWithDuration:0.3 delay:0 options:options animations:^{
            if (drawerSide == XHDrawerSideLeft) {
                [self.scrollView setContentOffset:CGPointMake(0.0f, 0.0f) animated:NO];
            } else if (drawerSide == XHDrawerSideRight) {
                [self.scrollView setContentOffset:CGPointMake(CGRectGetWidth(self.scrollView.frame) + XHContentContainerViewOriginX, 0.0f) animated:NO];
            }
            
        } completion:^(BOOL finished) {
            self.openSide = drawerSide;
            self.zoomDrawerView.contentContainerButton.userInteractionEnabled = YES;
            if (completion) {
                completion(finished);
            }
        }];
    }
}

#pragma mark -close
- (void)closeDrawerAnimated:(BOOL)animated completion:(void (^)(BOOL finished))completion {
    [self closeDrawerAnimated:animated velocity:self.animationVelocity animationOptions:UIViewAnimationOptionCurveEaseInOut completion:completion];
}

- (void)closeDrawerAnimated:(BOOL)animated velocity:(CGFloat)velocity animationOptions:(UIViewAnimationOptions)options completion:(void (^)(BOOL finished))completion {
    
    CGFloat damping = [self isSpringAnimationOn] ? 0.7f : 1.0f;
    
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 7.0) {
        [UIView animateWithDuration:0.5 delay:0.0 usingSpringWithDamping:damping initialSpringVelocity:velocity options:UIViewAnimationOptionAllowAnimatedContent animations:^{
            [self.scrollView setContentOffset:CGPointMake(XHContentContainerViewOriginX, 0.0f) animated:NO];
        } completion:^(BOOL finished) {
            self.openSide = XHDrawerSideNone;
            self.zoomDrawerView.contentContainerButton.userInteractionEnabled = NO;
            if (completion) {
                completion(finished);
            }
        }];
    } else {
        [UIView animateWithDuration:0.3 delay:0 options:options animations:^{
            [self.scrollView setContentOffset:CGPointMake(XHContentContainerViewOriginX, 0.0f) animated:NO];
        } completion:^(BOOL finished) {
            self.openSide = XHDrawerSideNone;
            self.zoomDrawerView.contentContainerButton.userInteractionEnabled = NO;
            if (completion) {
                completion(finished);
            }
        }];
    }
}

#pragma mark - Accessors
#pragma mark -设置zoomDrawerView的set/get
- (void)setBackgroundView:(UIView *)backgroundView {
    self.zoomDrawerView.backgroundView = backgroundView;
}

- (UIView *)backgroundView {
    return self.zoomDrawerView.backgroundView;
}

#pragma mark -zoomDrawerView的get
- (UIScrollView *)scrollView {
    return self.zoomDrawerView.scrollView;
}

#pragma mark -center/left/right
- (void)setCenterViewController:(UIViewController *)centerViewController {
    //如果view还没有生成，加载view
    if (![self isViewLoaded]) {
        [self view];
    }
    UIViewController *currentContentViewController =self.centerViewController;
    _centerViewController = centerViewController;
    
    //zoomDrawerView的中间内容 初始化其transform
    UIView *contentContainerView = self.zoomDrawerView.contentContainerView;
    CGAffineTransform currentTransform = [contentContainerView transform];
    [contentContainerView setTransform:CGAffineTransformIdentity];//初始化transform
    
    [self replaceController:currentContentViewController
              newController:_centerViewController
                  container:self.zoomDrawerView.contentContainerView];
    
    [contentContainerView setTransform:currentTransform];
    [self.zoomDrawerView setNeedsLayout];
}

- (void)setLeftViewController:(UIViewController *)leftViewController {
    if (![self isViewLoaded]) {
        [self view];
    }
    UIViewController *currentLeftViewController = self.leftViewController;
    _leftViewController = leftViewController;
    [self replaceController:currentLeftViewController
              newController:self.leftViewController
                  container:self.zoomDrawerView.leftContainerView];
}

- (void)setRightViewController:(UIViewController *)rightViewController {
    if (![self isViewLoaded]) {
        [self view];
    }
    UIViewController *currentLeftViewController = self.rightViewController;
    _rightViewController = rightViewController;
    [self replaceController:currentLeftViewController
              newController:self.rightViewController
                  container:self.zoomDrawerView.rightContainerView];
}


#pragma mark - Instance Methods
- (void)replaceController:(UIViewController *)oldController newController:(UIViewController *)newController container:(UIView *)container
{
    if (newController) {
        [self addChildViewController:newController];
        [[newController view] setFrame:[container bounds]];
        [newController setDrawerController:self];
        
        if (oldController) {
            [self transitionFromViewController:oldController toViewController:newController duration:0.0 options:0 animations:nil completion:^(BOOL finished) {
                
                [newController didMoveToParentViewController:self];
                
                [oldController willMoveToParentViewController:nil];
                [oldController removeFromParentViewController];
                [oldController setDrawerController:nil];
                
            }];
        } else {
            [container addSubview:[newController view]];
            [newController didMoveToParentViewController:self];
        }
    } else {
        [[oldController view] removeFromSuperview];
        [oldController willMoveToParentViewController:nil];
        [oldController removeFromParentViewController];
        [oldController setDrawerController:nil];
    }
}


#pragma mark - 可选方法
#pragma mark -UIScrollViewDelegate Methods
#pragma mark --缩放效果所需的协议方法
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGPoint contentOffset = [scrollView contentOffset];
    NSLog(@"--%@",NSStringFromCGPoint(scrollView.contentOffset));
    
    CGFloat currentContentOffsetX = contentOffset.x;
    if (currentContentOffsetX > 0 && currentContentOffsetX < XHContentContainerViewOriginX && self.cuurrentContentOffsetX > currentContentOffsetX) {
        self.openSide = XHDrawerSideLeft;
    } else if (currentContentOffsetX > XHContentContainerViewOriginX && currentContentOffsetX < (XHContentContainerViewOriginX * 2) && self.cuurrentContentOffsetX < currentContentOffsetX) {
        self.openSide = XHDrawerSideRight;
    }
    
    CGFloat contentOffsetX = 0.0;
    if (self.openSide == XHDrawerSideRight) {
        contentOffsetX = XHContentContainerViewOriginX * 2 - contentOffset.x;
    } else if (self.openSide == XHDrawerSideLeft) {
        contentOffsetX = contentOffset.x;
    }
    
    
    CGFloat contentContainerScale = powf((contentOffsetX + XHContentContainerViewOriginX) / (XHContentContainerViewOriginX * 2.0f), .5f);
    if (isnan(contentContainerScale)) {
        contentContainerScale = 0.0f;
    }
    
    CGAffineTransform contentContainerViewTransform = CGAffineTransformMakeScale(contentContainerScale, contentContainerScale);
    CGAffineTransform leftContainerViewTransform = CGAffineTransformMakeTranslation(contentOffsetX / 1.5f, 0.0f);
    CGAffineTransform rightContainerViewTransform = CGAffineTransformMakeTranslation(contentOffsetX / -1.5f, 0.0f);
    
    self.zoomDrawerView.contentContainerView.transform = contentContainerViewTransform;
    
    self.zoomDrawerView.leftContainerView.transform = leftContainerViewTransform;
    self.zoomDrawerView.leftContainerView.alpha = 1 - contentOffsetX / XHContentContainerViewOriginX;
    
    self.zoomDrawerView.rightContainerView.transform = rightContainerViewTransform;
    self.zoomDrawerView.rightContainerView.alpha = 1 - contentOffsetX / XHContentContainerViewOriginX;
    
    if (self.openSide == XHDrawerSideLeft) {
        static BOOL leftContentViewControllerVisible = NO;
        if (contentOffsetX >= XHContentContainerViewOriginX) {
            if (leftContentViewControllerVisible) {
                [self.leftViewController beginAppearanceTransition:NO animated:YES];
                [self.leftViewController endAppearanceTransition];
                leftContentViewControllerVisible = NO;
                if ([self respondsToSelector:@selector(setNeedsStatusBarAppearanceUpdate)])
                    [self setNeedsStatusBarAppearanceUpdate];
            }
        } else if (contentOffsetX < XHContentContainerViewOriginX && !leftContentViewControllerVisible) {
            [self.leftViewController beginAppearanceTransition:YES animated:YES];
            leftContentViewControllerVisible = YES;
            [self.leftViewController endAppearanceTransition];
            if ([self respondsToSelector:@selector(setNeedsStatusBarAppearanceUpdate)])
                [self setNeedsStatusBarAppearanceUpdate];
        }
    } else if (self.openSide == XHDrawerSideRight) {
        static BOOL rightContentViewControllerVisible = NO;
        if (contentOffsetX >= XHContentContainerViewOriginX) {
            if (rightContentViewControllerVisible) {
                [self.rightViewController beginAppearanceTransition:NO animated:YES];
                [self.rightViewController endAppearanceTransition];
                rightContentViewControllerVisible = NO;
                if ([self respondsToSelector:@selector(setNeedsStatusBarAppearanceUpdate)])
                    [self setNeedsStatusBarAppearanceUpdate];
            }
        } else if (contentOffsetX < XHContentContainerViewOriginX && !rightContentViewControllerVisible) {
            [self.rightViewController beginAppearanceTransition:YES animated:YES];
            rightContentViewControllerVisible = YES;
            [self.rightViewController endAppearanceTransition];
            if ([self respondsToSelector:@selector(setNeedsStatusBarAppearanceUpdate)])
                [self setNeedsStatusBarAppearanceUpdate];
        }
    }
}

#pragma mark --可选协议方法
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    self.cuurrentContentOffsetX = scrollView.contentOffset.x;
}

//减速停止的时候开始执行
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    [self updateContentContainerButton];
}

//停止拖拽的时候开始执行
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    if (!decelerate) {
        [self updateContentContainerButton];
    }
}

- (void)updateContentContainerButton {
    CGPoint contentOffset = self.scrollView.contentOffset;
    CGFloat contentOffsetX = contentOffset.x;
    if (contentOffsetX < XHContentContainerViewOriginX) {
        self.zoomDrawerView.contentContainerButton.userInteractionEnabled = YES;
    } else if (contentOffsetX > XHContentContainerViewOriginX) {
        self.zoomDrawerView.contentContainerButton.userInteractionEnabled = YES;
    } else {
        self.zoomDrawerView.contentContainerButton.userInteractionEnabled = NO;
    }
}

- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset {
    
    CGFloat targetContentOffsetX = targetContentOffset->x;
    CGFloat drawerPadding = XHContentContainerViewOriginX * 2 / 3.;
    if ((targetContentOffsetX >= drawerPadding && targetContentOffsetX < XHContentContainerViewOriginX && self.openSide == XHDrawerSideLeft) || (targetContentOffsetX > XHContentContainerViewOriginX && targetContentOffsetX <= (XHContentContainerViewOriginX * 2 - drawerPadding) && self.openSide == XHDrawerSideRight)) {
        targetContentOffset->x = XHContentContainerViewOriginX;
    } else if ((targetContentOffsetX >= 0 && targetContentOffsetX <= drawerPadding && self.openSide == XHDrawerSideLeft)) {
        targetContentOffset->x = 0.0f;
        self.openSide = XHDrawerSideLeft;
    } else if ((targetContentOffsetX > (XHContentContainerViewOriginX * 2 - drawerPadding) && targetContentOffsetX <= (XHContentContainerViewOriginX * 2) && self.openSide == XHDrawerSideRight)) {
        targetContentOffset->x = XHContentContainerViewOriginX * 2;
        self.openSide = XHDrawerSideRight;
    }
}

- (UIViewController *)childViewControllerForStatusBarStyle {
    UIViewController *viewController;
    if (self.scrollView.contentOffset.x < XHContentContainerViewOriginX) {
        viewController = self.leftViewController;
    } else if (self.scrollView.contentOffset.x > XHContentContainerViewOriginX) {
        viewController = self.rightViewController;
    } else {
        viewController = self.centerViewController;
    }
    return viewController;
}

- (UIViewController *)childViewControllerForStatusBarHidden {
    UIViewController *viewController;
    if (self.scrollView.contentOffset.x < XHContentContainerViewOriginX) {
        viewController = self.leftViewController;
    } else if (self.scrollView.contentOffset.x > XHContentContainerViewOriginX) {
        viewController = self.rightViewController;
    } else {
        viewController = self.centerViewController;
    }
    return viewController;
}

@end
