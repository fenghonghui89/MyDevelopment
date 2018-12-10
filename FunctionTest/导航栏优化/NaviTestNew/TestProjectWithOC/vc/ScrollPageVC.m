//
//  ScrollPaegVC.m
//  NaviTest2
//
//  Created by hanyfeng on 2018/11/9.
//  Copyright © 2018 JiepengZhengDevExtend. All rights reserved.
//

#import "ScrollPageVC.h"
#import "Masonry.h"
#import "XTJNavigationItem_Main.h"
#import "ChildViewController.h"
#import "Masonry.h"
@interface ScrollPageVC ()
<
UIScrollViewDelegate,UIGestureRecognizerDelegate
>

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@property (weak, nonatomic) IBOutlet UIView *topBgView;
@property (weak, nonatomic) IBOutlet UIView *lineView;
@property (strong, nonatomic) IBOutletCollection(UILabel) NSArray *selectBtnTitleLabels;
@property(nonatomic,strong)ChildViewController *vc_unReview;
@property(nonatomic,strong)ChildViewController *vc_hasReviewed;
@end

@implementation ScrollPageVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self customInit];
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
}

-(void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    
    [self customInitScrollView];
    [self configTabView:0 duration:0 needScroll:YES];
}

#pragma mark - init
-(void)customInit{
    
    [self customInitNavigationBar];
    [self customInitView];
    
}

-(void)customInitNavigationBar{
    
    //navi
    XTJNavigationItem_Main *homeBar = [XTJNavigationItem_Main loadNibWithOwner:self];
    homeBar.backgroundColor = [UIColor clearColor];
    self.navigationItem.titleView = homeBar;
    homeBar.title = @"scrollview";
    XTJBlockWeak(self);
    homeBar.leftBarButton0Handler = ^{
        [weak_self.navigationController popViewControllerAnimated:YES];
    };
    
    self.xa_navBarAlpha = 1;
}

-(void)customInitView{
    
    //self
    self.view.backgroundColor = [UIColor redColor];
    
    //select line
    CGFloat w_lineView = screenW/2.0;
    CGFloat w_centerLine = 40;
    CGFloat x_centerLine = (w_lineView-w_centerLine)*0.5;
    UIView *centerLine = [[UIView alloc] initWithFrame:CGRectMake(x_centerLine, 0, w_centerLine, 2)];
    centerLine.backgroundColor = HexColor(XTJ_COLOR_MAIN);
    [self.lineView addSubview:centerLine];
    self.lineView.backgroundColor = [UIColor clearColor];
    [self.lineView setFrame:CGRectMake(0, 40-2, screenW/2.0, 2)];
    
    //select label
    [self.selectBtnTitleLabels enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        UILabel *label = (UILabel *)obj;
        if (idx == 0) {
            label.textColor = [UIColor redColor];
        }else{
            label.textColor = [UIColor blueColor];
        }
    }];
    
    
}

-(void)customInitScrollView{
    
    CGFloat stateBarH = 0;
    CGFloat y = 0;
    if ([UIDevice isCalling]) {
        y = naviH+20+40;
        stateBarH = 40;
    }else{
        y = naviH+stateH+40;
        stateBarH = stateH;
    }
    CGFloat viewWidth = screenW;
    CGFloat viewHeight = screenH-naviH-stateBarH-40;
    if (@available(iOS 11.0,*)) {
        NSLog(@"~~%.2f",self.view.safeAreaInsets.bottom);
        viewHeight -= self.view.safeAreaInsets.bottom;
    }

    //scrollview
    self.scrollView.delegate = self;
    self.scrollView.showsVerticalScrollIndicator = NO;
    self.scrollView.showsHorizontalScrollIndicator = NO;
    self.scrollView.bounces = NO;
    self.scrollView.pagingEnabled = YES;
    self.scrollView.contentSize = CGSizeMake(viewWidth*2, viewHeight);
    
    //MARK:解决scrollview右滑手势与navi右滑返回手势冲突导致的右滑返回失效
    [self.scrollView.panGestureRecognizer requireGestureRecognizerToFail:self.navigationController.interactivePopGestureRecognizer];
    self.navigationController.interactivePopGestureRecognizer.delegate = self;
    
    //child vc view
    if (!self.vc_unReview) {
        ChildViewController *vc_unReview = [[ChildViewController alloc] init];
        [self addChildViewController:vc_unReview];
        [self.scrollView addSubview:vc_unReview.view];
        [vc_unReview didMoveToParentViewController:self];

        self.vc_unReview = vc_unReview;
    }
    [self.vc_unReview.view setFrame:CGRectMake(0, 0, viewWidth, viewHeight)];

    if (!self.vc_hasReviewed) {
        ChildViewController *vc_hasReviewed = [[ChildViewController alloc] init];
        [self addChildViewController:vc_hasReviewed];
        [self.scrollView addSubview:vc_hasReviewed.view];
        [vc_hasReviewed didMoveToParentViewController:self];
        self.vc_hasReviewed = vc_hasReviewed;
    }
    [self.vc_hasReviewed.view setFrame:CGRectMake(viewWidth, 0, viewWidth, viewHeight)];

}

#pragma mark - action
- (IBAction)selectBtnTap:(UIButton *)sender{
    
    [self configTabView:sender.tag duration:0.5 needScroll:YES];
    
}

#pragma mark - UIScrollViewDelegate
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    
    CGPoint offset = scrollView.contentOffset;
    NSInteger index = (NSInteger)(round(offset.x/screenW)) % 2;
    
    NSInteger type = 0;
    switch (index) {
        case 0:
            type = 0;
            break;
        case 1:
            type = 1;
            break;
        default:
            break;
    }
    
    [self configTabView:type duration:0.5 needScroll:NO];
}

#pragma mark - 改变切换栏UI

/**
 改变切换栏UI
 
 @param type 未评价类型
 @param duration scroll时间
 @param isNeed 是否需要scroll
 */
-(void)configTabView:(NSInteger)type
            duration:(CGFloat)duration
          needScroll:(BOOL)isNeed{
    
    CGPoint origin = CGPointZero;
    NSInteger targetTag = 0;
    CGPoint offset = CGPointZero;
    switch (type) {
        case 0:
            origin = CGPointMake(0, 40-2);
            targetTag = 0;
            offset = CGPointMake(0, 0);
            break;
        case 1:
            origin = CGPointMake(screenW/2.0, 40-2);
            targetTag = 1;
            offset = CGPointMake(screenW, 0);
            break;
        default:
            break;
    }
    
    //tab label
    XTJBlockWeak(self);
    [UIView animateWithDuration:0 animations:^{
        [weak_self.lineView setOrigin_:origin];
        
        [weak_self.selectBtnTitleLabels enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            UILabel *label = (UILabel *)obj;
            if (idx == targetTag) {
                label.textColor = [UIColor redColor];
            }else{
                label.textColor = [UIColor blueColor];
            }
        }];
    }];
    
    //scroll滚动
    if (isNeed) {
        [UIView animateWithDuration:duration animations:^{
            weak_self.scrollView.contentOffset = offset;
        }];
    }
}

@end
