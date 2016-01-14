//
// DemoTableFooterView.m
//
// @author Shiki
//

#import "PPRefreshFootMoreView.h"

@implementation PPRefreshFootMoreView

#pragma mark -
#pragma mark Dealloc
- (UIColor *)getColor:(NSString *)hexColor {
    unsigned int red, green, blue;
    NSRange range;
    range.length = 2;
    range.location = 0;
    [[NSScanner scannerWithString:[hexColor substringWithRange:range]] scanHexInt:&red];
    range.location = 2;
    [[NSScanner scannerWithString:[hexColor substringWithRange:range]] scanHexInt:&green];
    range.location = 4;
    [[NSScanner scannerWithString:[hexColor substringWithRange:range]] scanHexInt:&blue];
    return [UIColor colorWithRed:(float)(red/255.0f) green:(float)(green/255.0f) blue:(float)(blue/255.0f) alpha:1.0f];
}

- (id)init
{
    self = [super init];
    if (self) {
        // 内容的高度
       
        
        // 挪动标签的位置
//        CGPoint center = _statusLabel.center;
//        center.y = _arrowImage.center.y;
//        _statusLabel.center = center;
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame: frame];
    if (self) {
        
        self.backgroundColor = [UIColor clearColor];
		self.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        
        CGFloat color = 230/255.0;
        self.backgroundColor = [UIColor colorWithRed:color green:color blue:color alpha:1];
//        [self setBackgroundColor:[self getColor:@"eeeeee"]];
        
        CGFloat contentHeight = _scrollView.contentSize.height;
        // 表格的高度
        CGFloat scrollHeight = _scrollView.frame.size.height;
        CGFloat y = MAX(contentHeight, scrollHeight);
        // 设置边框
        self.frame = CGRectMake(0, y, _scrollView.frame.size.width, 60);
        
		_infoLabel = [[UILabel alloc] initWithFrame:CGRectMake(0.0f, 14.0f, self.frame.size.width, 21.0f)];
		_infoLabel.autoresizingMask = UIViewAutoresizingFlexibleWidth;
		_infoLabel.font = [UIFont systemFontOfSize:15.0f];
        [_infoLabel setText:@"上拉即可更新..."];
        _infoLabel.textColor = [self getColor:@"999999"];
		_infoLabel.shadowColor = [UIColor colorWithWhite:0.9f alpha:1.0f];
		_infoLabel.shadowOffset = CGSizeMake(0.0f, 1.0f);
		_infoLabel.backgroundColor = [UIColor clearColor];
		_infoLabel.textAlignment = NSTextAlignmentCenter;
		[self addSubview:_infoLabel];
        [_infoLabel release];
		
		_activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
		_activityIndicator.frame = CGRectMake(25.0f, 15.0f, 20.0f, 20.0f);
		[self addSubview:_activityIndicator];
        [_activityIndicator release];
    }
    return self;
}



- (void) dealloc
{
    [super dealloc];
}

@end
