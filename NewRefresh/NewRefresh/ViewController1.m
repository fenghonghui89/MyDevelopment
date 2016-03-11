//
//  ViewController.m
//  NewRefresh
//
//  Created by 冯鸿辉 on 16/3/10.
//  Copyright © 2016年 DGC. All rights reserved.
//

#define ScreenW [[UIScreen mainScreen] bounds].size.width
#define ScreenH [[UIScreen mainScreen] bounds].size.height

static void * myContext = &myContext;

#import "ViewController1.h"
#import "NewRefreshView.h"
#import "NewWebView.h"
@interface ViewController1 ()<UIWebViewDelegate,UIScrollViewDelegate,UIGestureRecognizerDelegate>
@property(nonatomic,strong)NewRefreshView *rview;
@property(nonatomic,strong)NewWebView *webview;
@property(nonatomic,assign)CGFloat lastRefreshViewY;
@property(nonatomic,assign)CGFloat currentRefreshViewY;
@property(nonatomic,assign)BOOL canEdit;
@property(nonatomic,assign)BOOL isBeganScrollToTop;



@end

@implementation ViewController1

#pragma mark - < vc lifecycle> -

-(void)dealloc{
  [self removeObserver:self.rview forKeyPath:@"webview.scrollView.contentOffset"];
}

- (void)viewDidLoad {
  [super viewDidLoad];
  
  [self customInitData];
  [self customInitUI];
  
}

#pragma mark - < method > -
#pragma mark customInitUI
-(void)customInitData{
  self.lastRefreshViewY = 0;
  self.currentRefreshViewY = 0;
  self.canEdit = YES;
  self.isBeganScrollToTop = NO;
}

-(void)customInitUI{
  NewWebView *webview = [[NewWebView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, ScreenH)];
  [webview setDelegate:self];
  [webview.scrollView setDelegate:self];
  [webview.scrollView setBounces:NO];
  [webview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://dev.123go.net.cn"]]];
  [self.view addSubview:webview];
  self.webview = webview;
  
  UIPanGestureRecognizer *panGR = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(webviewPanGRAction:)];
  [panGR setDelegate:self];
  [webview addGestureRecognizer:panGR];
  
  NewRefreshView *rview = [[[NSBundle mainBundle] loadNibNamed:@"NewRefreshView" owner:self options:nil] lastObject];
  [rview setFrame:CGRectMake(0, 0, ScreenW, 44)];
  [self.view addSubview:rview];
  rview.webview = webview;
  self.rview = rview;
  
  [self addObserver:rview forKeyPath:@"webview.scrollView.contentOffset" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:myContext];
}

#pragma mark GestureRecognizer
-(void)webviewPanGRAction:(UIPanGestureRecognizer *)panGR{
  
  if (self.canEdit == YES && self.isBeganScrollToTop == YES) {
    CGFloat delta = [panGR translationInView:self.view].y;
    CGFloat deltax = [panGR translationInView:self.view].x;
    
    CGFloat currentRefreshViewY = self.lastRefreshViewY+delta;
    if (currentRefreshViewY<=0) {
      NSLog(@"~没有移动或往上移,delta:%f",deltax);
      [self.rview customInitUI];
      self.lastRefreshViewY = 0;
      self.currentRefreshViewY = 0;
    }else if (currentRefreshViewY>0 && currentRefreshViewY<150) {
      NSLog(@"~往下移动中,delta:%f",deltax);
      [self.rview setFrame:CGRectMake(0, self.lastRefreshViewY+delta, ScreenW, 44)];
      [self.rview customInitUI];
      self.lastRefreshViewY = currentRefreshViewY;
      self.currentRefreshViewY = currentRefreshViewY;
    }else{
      NSLog(@"~到达临界点,delta:%f",deltax);
      [self.rview readyUpload];
      self.lastRefreshViewY = 150;
      self.currentRefreshViewY = 150;
    }
    
  }
  
  [panGR setTranslation:CGPointZero inView:self.view];
}


#pragma mark rview
-(void)move:(CGPoint)location previous:(CGPoint)previousLocation{
  
  if (self.canEdit == YES && self.isBeganScrollToTop == YES) {
    CGFloat delta = location.y - previousLocation.y;
    CGFloat currentRefreshViewY = self.lastRefreshViewY+delta;
    
    if (currentRefreshViewY<=0) {
      NSLog(@"没有移动或往上移,%d",self.isBeganScrollToTop);
      [self.rview customInitUI];
      self.lastRefreshViewY = 0;
      self.currentRefreshViewY = 0;
    }else if (currentRefreshViewY>0 && currentRefreshViewY<150) {
      NSLog(@"往下移动中,%d",self.isBeganScrollToTop);
      [self.rview setFrame:CGRectMake(0, self.lastRefreshViewY+delta, ScreenW, 44)];
      [self.rview customInitUI];
      self.lastRefreshViewY = currentRefreshViewY;
      self.currentRefreshViewY = currentRefreshViewY;
    }else{
      NSLog(@"到达临界点,%d",self.isBeganScrollToTop);
      [self.rview readyUpload];
      self.lastRefreshViewY = 150;
      self.currentRefreshViewY = 150;
    }
  }else{
    return;
  }
  
}

-(void)end{
  
  if (self.canEdit == YES) {
    if (self.currentRefreshViewY <= 0) {
      NSLog(@"end - 没有移动或往上移");
      return;
    }
    if (self.currentRefreshViewY >0 && self.currentRefreshViewY<150) {
      NSLog(@"end - 往下移动中");
      [self endRefreshView1];
      return;
    }
    if (self.currentRefreshViewY >= 150) {
      NSLog(@"end - 到达临界点");
      [self endRefreshView2];
      return;
    }
  }
  
}

-(void)endRefreshView1{
  self.canEdit = NO;
  dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
    dispatch_async(dispatch_get_main_queue(), ^{
      [UIView animateWithDuration:1 animations:^{
        [self.rview setFrame:CGRectMake(0, 0, ScreenW, 44)];
        self.lastRefreshViewY = 0;
        self.currentRefreshViewY = 0;
      } completion:^(BOOL finished) {
        self.canEdit = YES;
      }];
      
    });
  });
}

-(void)endRefreshView2{
  self.canEdit = NO;
  [self.rview uploading:^{
    [self.webview reload];
  }];
}

#pragma mark - < callback > -
#pragma mark webview
-(void)webViewDidStartLoad:(UIWebView *)webView{
  
}

-(void)webViewDidFinishLoad:(UIWebView *)webView{
  dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
    dispatch_async(dispatch_get_main_queue(), ^{
      [UIView animateWithDuration:1 animations:^{
        [self.rview finish:nil];
        [self.rview setFrame:CGRectMake(0, 0, ScreenW, 44)];
        self.lastRefreshViewY = 0;
        self.currentRefreshViewY = 0;
      } completion:^(BOOL finished) {
        self.canEdit = YES;
        [self.rview customInitUI];
      }];
    });
  });

}

-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
  return YES;
}

-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
  dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
    dispatch_async(dispatch_get_main_queue(), ^{
      [UIView animateWithDuration:1 animations:^{
        [self.rview finish:nil];
        [self.rview setFrame:CGRectMake(0, 0, ScreenW, 44)];
        self.lastRefreshViewY = 0;
        self.currentRefreshViewY = 0;
      } completion:^(BOOL finished) {
        self.canEdit = YES;
        [self.rview customInitUI];
      }];
    });
  });

}

#pragma mark scrollview

-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
  NSLog(@"scrollViewWillBeginDragging %@",NSStringFromCGPoint(scrollView.contentOffset));
  if (scrollView.contentOffset.y == -64) {
    self.isBeganScrollToTop = YES;
  }else{
    self.isBeganScrollToTop = NO;
  }
}

-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
  NSLog(@"scrollViewDidEndDragging %@",NSStringFromCGPoint(scrollView.contentOffset));
  if (self.canEdit == YES && self.isBeganScrollToTop == YES) {
    if (self.currentRefreshViewY <= 0) {
      NSLog(@"end - 没有移动或往上移");
      self.lastRefreshViewY = 0;
      self.currentRefreshViewY = 0;
      return;
    }
    if (self.currentRefreshViewY >0 && self.currentRefreshViewY<150) {
      NSLog(@"end - 往下移动中");
      [self end];
      return;
    }
    if (self.currentRefreshViewY >= 150) {
      NSLog(@"end - 到达临界点");
      [self end];
      return;
    }
  }
  
}


#pragma mark 手势
-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer{
  return YES;
}

#pragma mark NewWebView
- (void)webView:(UIWebView*)sender zoomingEndedWithTouches:(NSSet*)touches event:(UIEvent*)event
{
  NSLog(@"finished zooming");
}

- (void)webView:(UIWebView*)sender tappedWithTouch:(UITouch*)touch event:(UIEvent*)event
{
  NSLog(@"tapped");
}

@end
