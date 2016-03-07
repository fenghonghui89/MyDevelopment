//
//  KICropImageView.m
//  Kitalker
//
//  Created by 杨 烽 on 12-8-9.
//
//

#import "KICropImageView.h"

@implementation KICropImageView

#pragma mark  set
- (void)setFrame:(CGRect)frame {
  [super setFrame:frame];
  [[self scrollView] setFrame:self.bounds];
  [[self maskView] setFrame:self.bounds];
  
  [[self imageView] setFrame:CGRectMake(0, 0, 0, 0)];
  [[self scrollView] setMinimumZoomScale:0.5];
  [[self scrollView] setMaximumZoomScale:5.5];
  [[self scrollView] setZoomScale:0.5 animated:YES];
  
  //    if (CGSizeEqualToSize(_cropSize, CGSizeZero)) {
  //        [self setCropSize:CGSizeMake(100, 100)];
  //    }
}

- (void)setImage:(UIImage *)image {
  if (image != _image) {
    [_image release];
    _image = nil;
    _image = [image retain];
  }
  [[self imageView] setImage:_image];
  
  [self updateZoomScale];
  
}

- (void)setCropSize:(CGSize)size {
  _cropSize = size;
  [[self maskView] setCropSize:_cropSize];
  
  //  [self updateZoomScale];
  
  CGFloat width = _cropSize.width;//200
  CGFloat height = _cropSize.height;//200
  
  CGFloat x = (CGRectGetWidth(self.bounds) - size.width) / 2;//320-200 = 60
  CGFloat y = (CGRectGetHeight(self.bounds) - size.height) / 2;//568-200 = 368 /2
  
  
  
  CGFloat top = y;//184
  CGFloat left = x;//60
//  CGFloat right = CGRectGetWidth(self.bounds)- size.width - x;//320-200-60 = 60
//  CGFloat bottom = CGRectGetHeight(self.bounds)- size.height - y;//568-200-184 = 184
  CGFloat right = x;//320-200-60 = 60
  CGFloat bottom = y;//568-200-184 = 184
  _imageInset = UIEdgeInsetsMake(top, left, bottom, right);
  NSLog(@"%f %f %f %f",top,left,bottom,right);
  [[self scrollView] setContentInset:_imageInset];

  [[self scrollView] setContentOffset:CGPointMake(0, 0)];
  
  
}

#pragma mark get
- (UIScrollView *)scrollView {
  if (_scrollView == nil) {
    _scrollView = [[UIScrollView alloc] init];
    [_scrollView setBackgroundColor:[UIColor redColor]];
    [_scrollView setDelegate:self];
    [_scrollView setBounces:NO];
    [_scrollView setShowsHorizontalScrollIndicator:NO];
    [_scrollView setShowsVerticalScrollIndicator:NO];
    [self addSubview:_scrollView];
  }
  return _scrollView;
}

- (KICropImageMaskView *)maskView {
  if (_maskView == nil) {
    _maskView = [[KICropImageMaskView alloc] init];
    [_maskView setBackgroundColor:[UIColor clearColor]];
    [_maskView setUserInteractionEnabled:NO];
    [self addSubview:_maskView];
    [self bringSubviewToFront:_maskView];
  }
  return _maskView;
}

- (UIImageView *)imageView {
  if (_imageView == nil) {
    _imageView = [[UIImageView alloc] init];
    [[self scrollView] addSubview:_imageView];
  }
  return _imageView;
}




- (UIImage *)cropImage {
  
  CGFloat zoomScale = [self scrollView].zoomScale;
  CGFloat offsetX = [self scrollView].contentOffset.x;
  CGFloat offsetY = [self scrollView].contentOffset.y;
  CGFloat aX = offsetX>=0 ? offsetX+_imageInset.left : (_imageInset.left - ABS(offsetX));
  CGFloat aY = offsetY>=0 ? offsetY+_imageInset.top : (_imageInset.top - ABS(offsetY));
  
  aX = aX / zoomScale;
  aY = aY / zoomScale;
  
  CGFloat aWidth =  MAX(_cropSize.width / zoomScale, _cropSize.width);
  CGFloat aHeight = MAX(_cropSize.height / zoomScale, _cropSize.height);
  
  NSLog(@"~~~~%f %f %f",zoomScale,offsetX,offsetY);
  NSLog(@"%f--%f--%f--%f", aX, aY, aWidth, aHeight);
  
  
  UIImage *image = [_image cropImageWithX:aX y:aY width:aWidth height:aHeight];
  
  image = [image resizeToWidth:_cropSize.width height:_cropSize.height];
  
  return image;
}


#pragma mark other
- (void)updateZoomScale {
  CGFloat width = _image.size.width;
  CGFloat height = _image.size.height;
  
  [[self imageView] setFrame:CGRectMake(0, 0, width, height)];
  
  CGFloat xScale = _cropSize.width / width;
  CGFloat yScale = _cropSize.height / height;
  
  CGFloat min = MAX(xScale, yScale);
  CGFloat max = 1.0;
  if ([[UIScreen mainScreen] respondsToSelector:@selector(scale)]) {
    max = 1.0 / [[UIScreen mainScreen] scale];
  }
  
  if (min > max) {
    min = max;
  }
  
  [[self scrollView] setMinimumZoomScale:min];
  [[self scrollView] setMaximumZoomScale:max + 5.0f];
  
  [[self scrollView] setZoomScale:max animated:YES];
}




#pragma UIScrollViewDelegate
- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
  return [self imageView];
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
  //  NSLog(@"inset:%f,offset:%f",scrollView.contentInset.top,scrollView.contentOffset.y);
  NSLog(@"%f %f",scrollView.contentOffset.x,scrollView.contentOffset.y);
  //  NSLog(@"scrollview bound:%@",NSStringFromCGRect(scrollView.bounds));
}

- (void)dealloc {
  [_scrollView release];
  _scrollView = nil;
  [_imageView release];
  _imageView = nil;
  [_maskView release];
  _maskView = nil;
  [_image release];
  _image = nil;
  [super dealloc];
}
@end

#pragma mark -------------- KISnipImageMaskView --------------

#define kMaskViewBorderWidth 2.0f

@implementation KICropImageMaskView

- (void)setCropSize:(CGSize)size {
  CGFloat x = (CGRectGetWidth(self.bounds) - size.width) / 2;
  CGFloat y = (CGRectGetHeight(self.bounds) - size.height) / 2;
  _cropRect = CGRectMake(x, y, size.width, size.height);
  
  [self setNeedsDisplay];
}

- (CGSize)cropSize {
  return _cropRect.size;
}

- (void)drawRect:(CGRect)rect {
  [super drawRect:rect];
  CGContextRef  ctx = UIGraphicsGetCurrentContext();
//  CGContextSetRGBFillColor(ctx, 1, 1, 1, 0.6);
  CGContextSetFillColorWithColor(ctx, [UIColor colorWithRed:1 green:1 blue:1 alpha:0.6].CGColor);
  CGContextFillRect(ctx, self.bounds);
  
  CGContextSetStrokeColorWithColor(ctx, [UIColor redColor].CGColor);
  CGContextStrokeRectWithWidth(ctx, _cropRect, kMaskViewBorderWidth);
  
  CGContextClearRect(ctx, _cropRect);
}
@end
