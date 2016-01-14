//
//  PPAlertView.m
//  PPAlertViewSample
//
//	Copyright (C) 2012 Auerhaus Development, LLC
//
//	Permission is hereby granted, free of charge, to any person obtaining a copy of
//	this software and associated documentation files (the "Software"), to deal in
//	the Software without restriction, including without limitation the rights to
//	use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of
//	the Software, and to permit persons to whom the Software is furnished to do so,
//	subject to the following conditions:
//
//	The above copyright notice and this permission notice shall be included in all
//	copies or substantial portions of the Software.
//
//	THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//	IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS
//	FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR
//	COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER
//	IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
//	CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
//

#import "PPWebView.h"

#import "PPAlertView.h"
#import "PPUIKit.h"
#import <QuartzCore/QuartzCore.h>
#import <objc/runtime.h>
#import "PPCommon.h"



#define kPresentationAnimationDuration .4
#define degToRadians(x) (x * M_PI / 180.0f)

//#define KEYWINDOW           [[UIApplication sharedApplication] keyWindow]

//static UIWindow *alertViewWindow = nil;

static const char * const kPPAlertViewButtonBlockKey = "PPAlertViewButtonBlock";

static const CGFloat PPAlertViewDefaultWidth = 276;
static const CGFloat PPAlertViewMinimumHeight = 132;
static const CGFloat PPAlertViewDefaultButtonHeight = 40;

CGFloat CGAffineTransformGetAbsoluteRotationAngleDifference(CGAffineTransform t1, CGAffineTransform t2)
{
	CGFloat dot = t1.a * t2.a + t1.c * t2.c;
	CGFloat n1 = sqrtf(t1.a * t1.a + t1.c * t1.c);
	CGFloat n2 = sqrtf(t2.a * t2.a + t2.c * t2.c);
	return acosf(dot / (n1 * n2));
}

#pragma mark - Internal interface

typedef void (^PPAnimationCompletionBlock)(BOOL); // Internal.

@interface PPAlertView () {
	BOOL hasLayedOut;
    
}

@property (nonatomic, strong) UIImageView *backgroundImageView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *messageLabel;
@property (nonatomic, strong) UITextField *plainTextField;
@property (nonatomic, strong) UITextField *secureTextField;
@property (nonatomic, strong) UIButton *cancelButton;
@property (nonatomic, strong) UIButton *destructiveButton;
@property (nonatomic, strong) NSMutableArray *otherButtons;
@property (nonatomic, strong) NSMutableDictionary *buttonBackgroundImagesForControlStates;
@property (nonatomic, strong) NSMutableDictionary *cancelButtonBackgroundImagesForControlStates;
@property (nonatomic, strong) NSMutableDictionary *destructiveButtonBackgroundImagesForControlStates;
@property (nonatomic, strong) UIWindow *alertViewWindow;
@property (nonatomic, strong) UIView *linView;
@end

#pragma mark - Implementation

@implementation PPAlertView

static bool isWhat = NO;

@synthesize alertViewWindow = _alertViewWindow;
@synthesize title = _title;
@synthesize message = _message;
@synthesize otherButtons = _otherButtons;
@synthesize backgroundImage = _backgroundImage;
@synthesize destructiveButton = _destructiveButton;
@synthesize titleLabel;
@synthesize dismissalStyle = _dismissalStyle;
@synthesize backgroundImageView;
@synthesize cancelButtonBackgroundImagesForControlStates;
@synthesize buttonBackgroundImagesForControlStates;
@synthesize contentInsets;
@synthesize destructiveButtonBackgroundImagesForControlStates;
@synthesize presentationStyle = _presentationStyle;
@synthesize plainTextField;
@synthesize titleTextAttributes;
@synthesize messageLabel;
@synthesize alertViewStyle;
@synthesize messageTextAttributes;
@synthesize cancelButton = _cancelButton;
@synthesize visible;
@synthesize buttonTitleTextAttributes;
@synthesize secureTextField;

#pragma mark - Class life cycle methods

+ (void)initialize
{
	[self applySystemAlertAppearance];
}


- (BOOL)prefersStatusBarHidden{
    return YES;
}

+ (void)applySystemAlertAppearance {
	// Set up default values for all UIAppearance-compatible selectors
	
	[[self appearance] setBackgroundImage:[self alertBackgroundImage]];
//    [[self appearance] setBackgroundImage:[PPUIKit setLocaImage:@"AlertViewBG"]];

	[[self appearance] setContentInsets:UIEdgeInsetsMake(16, 8, 8, 8)];
	[[self appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
											   [UIFont boldSystemFontOfSize:17], UITextAttributeFont,
											   [PPCommon getColor:@"232323"], UITextAttributeTextColor,
											   [PPCommon getColor:@"232323"], UITextAttributeTextShadowColor,
											   [NSValue valueWithCGSize:CGSizeMake(0, 0)], UITextAttributeTextShadowOffset,
											   nil]];
	
	[[self appearance] setMessageTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
												 [UIFont systemFontOfSize:15], UITextAttributeFont,
												 [PPCommon getColor:@"6C6C6C"], UITextAttributeTextColor,
												 [PPCommon getColor:@"6C6C6C"], UITextAttributeTextShadowColor,
												 [NSValue valueWithCGSize:CGSizeMake(0, 0)], UITextAttributeTextShadowOffset,
												 nil]];

	[[self appearance] setButtonTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
													 [UIFont boldSystemFontOfSize:17], UITextAttributeFont,
													 [PPCommon getColor:@"157efb"], UITextAttributeTextColor,
													 [UIColor blackColor], UITextAttributeTextShadowColor,
													 [NSValue valueWithCGSize:CGSizeMake(0, 0)], UITextAttributeTextShadowOffset,
													 nil]];
	
//	[[self appearance] setButtonBackgroundImage:[self cancelButtonBackgroundImage] forState:UIControlStateNormal];
//    [[self appearance] setCancelButtonBackgroundImage:[self normalButtonBackgroundImage] forState:UIControlStateNormal];
    UIEdgeInsets buttonEdgeInsets = UIEdgeInsetsMake(0, 8, 0, 8);
    [[self appearance] setCancelButtonBackgroundImage:[[PPUIKit setLocaImage:@"PPAlertView-Button-normal"] resizableImageWithCapInsets:buttonEdgeInsets]
                                             forState:UIControlStateNormal];

    [[self appearance] setCancelButtonBackgroundImage:[[PPUIKit setLocaImage:@"PPAlertView-Button-pressed"] resizableImageWithCapInsets:buttonEdgeInsets]
                                             forState:UIControlStateHighlighted];

    [[self appearance] setButtonBackgroundImage:[[PPUIKit setLocaImage:@"PPAlertView-Cancel-normal"] resizableImageWithCapInsets:buttonEdgeInsets]
                                       forState:UIControlStateNormal];
    
    [[self appearance] setButtonBackgroundImage:[[PPUIKit setLocaImage:@"PPAlertView-Cancel-pressed"] resizableImageWithCapInsets:buttonEdgeInsets]
                                           forState:UIControlStateHighlighted];

//    }


  

    
    
//    [[self appearance] setTextColor:[UIColor yellowColor]];
	
    //	[[self appearance] setCancelButtonBackgroundImage:[self cancelButtonBackgroundImage] forState:UIControlStateNormal];
}

#pragma mark - Instance life cycle methods

- (id)initWithTitle:(NSString *)title message:(NSString *)message
{
	CGRect frame = CGRectMake(0, 0, PPAlertViewDefaultWidth, PPAlertViewMinimumHeight);
	
	if((self = [super initWithFrame:frame]))
	{
		[super setBackgroundColor:[UIColor clearColor]];
        
		_title = title;
		_message = message;
		
		_presentationStyle = PPAlertViewPresentationStyleDefault;
		_dismissalStyle = PPAlertViewDismissalStyleDefault;
        
		_otherButtons = [NSMutableArray array];
        
		[[UIDevice currentDevice] beginGeneratingDeviceOrientationNotifications];
		
		[[NSNotificationCenter defaultCenter] addObserver:self
												 selector:@selector(deviceOrientationChanged:)
													 name:UIDeviceOrientationDidChangeNotification
												   object:nil];
	}
	return self;
}

- (void)dealloc
{
	for(id button in _otherButtons)
		objc_setAssociatedObject(button, kPPAlertViewButtonBlockKey, nil, OBJC_ASSOCIATION_RETAIN);
    
	if(_cancelButton)
		objc_setAssociatedObject(_cancelButton, kPPAlertViewButtonBlockKey, nil, OBJC_ASSOCIATION_RETAIN);
	
	if(_destructiveButton)
		objc_setAssociatedObject(_destructiveButton, kPPAlertViewButtonBlockKey, nil, OBJC_ASSOCIATION_RETAIN);
    
	[[NSNotificationCenter defaultCenter] removeObserver:self
													name:UIDeviceOrientationDidChangeNotification
												  object:nil];
    
	[[UIDevice currentDevice] endGeneratingDeviceOrientationNotifications];
}

- (UIButton *)buttonWithTitle:(NSString *)aTitle associatedBlock:(PPAlertViewButtonBlock)block {
	UIButton *button = [[UIButton alloc] initWithFrame:CGRectZero];
    
	[button setTitle:aTitle forState:UIControlStateNormal];
	[button addTarget:self action:@selector(buttonWasPressed:) forControlEvents:UIControlEventTouchUpInside];
	objc_setAssociatedObject(button, kPPAlertViewButtonBlockKey, block, OBJC_ASSOCIATION_RETAIN);
   
	return button;
}

- (void)addButtonWithTitle:(NSString *)aTitle block:(PPAlertViewButtonBlock)block {
    if (aTitle == nil) {
        
    }else{
        if(!self.otherButtons)
            self.otherButtons = [NSMutableArray array];

        UIButton *otherButton = [self buttonWithTitle:aTitle associatedBlock:block];
        [otherButton setTag:101];
        CGRect cgre = otherButton.frame;
        [otherButton setFrame:CGRectMake(cgre.origin.x, cgre.origin.y, cgre.size.width/2, cgre.size.height/2)];
        
        [self.otherButtons addObject:otherButton];
        [self addSubview:otherButton];
    }
	
}

- (void)setDestructiveButtonTitle:(NSString *)aTitle block:(PPAlertViewButtonBlock)block {
	self.destructiveButton = [self buttonWithTitle:aTitle associatedBlock:block];
	[self addSubview:self.destructiveButton];
}

- (void)setCancelButtonTitle:(NSString *)aTitle block:(PPAlertViewButtonBlock)block {
    self.cancelButton = [self buttonWithTitle:aTitle associatedBlock:block];
    [self addSubview:self.cancelButton];
}

#pragma mark - Text field accessor

- (UITextField *)textFieldAtIndex:(NSInteger)textFieldIndex
{
	return nil;
}

#pragma mark - Appearance selectors

- (void)setButtonBackgroundImage:(UIImage *)backgroundImage forState:(UIControlState)state
{
	if(!self.buttonBackgroundImagesForControlStates)
		self.buttonBackgroundImagesForControlStates = [NSMutableDictionary dictionary];
	
	[self.buttonBackgroundImagesForControlStates setObject:backgroundImage
													forKey:[NSNumber numberWithInteger:state]];
}

- (UIImage *)buttonBackgroundImageForState:(UIControlState)state
{
	return [self.buttonBackgroundImagesForControlStates objectForKey:[NSNumber numberWithInteger:state]];
}

- (void)setCancelButtonBackgroundImage:(UIImage *)backgroundImage forState:(UIControlState)state
{
	if(!self.cancelButtonBackgroundImagesForControlStates)
		self.cancelButtonBackgroundImagesForControlStates = [NSMutableDictionary dictionary];
    
	[self.cancelButtonBackgroundImagesForControlStates setObject:backgroundImage
														  forKey:[NSNumber numberWithInteger:state]];
}

- (UIImage *)cancelButtonBackgroundImageForState:(UIControlState)state
{
	return [self.cancelButtonBackgroundImagesForControlStates objectForKey:[NSNumber numberWithInteger:state]];
}

- (void)setDestructiveButtonBackgroundImage:(UIImage *)backgroundImage forState:(UIControlState)state
{
	if(!self.destructiveButtonBackgroundImagesForControlStates)
		self.destructiveButtonBackgroundImagesForControlStates = [NSMutableDictionary dictionary];
	
	[self.destructiveButtonBackgroundImagesForControlStates setObject:backgroundImage
															   forKey:[NSNumber numberWithInteger:state]];
}

- (UIImage *)destructiveButtonBackgroundImageForState:(UIControlState)state
{
	return [self.destructiveButtonBackgroundImagesForControlStates objectForKey:[NSNumber numberWithInteger:state]];
}

#pragma mark - Presentation and dismissal methods

- (void)show {
	[self showWithStyle:self.presentationStyle];
}



//*********
- (void)dismiss {
//	[self dismissWithStyle:self.dismissalStyle];
}

- (void)dismissWithStyle:(PPAlertViewDismissalStyle)style button:(UIButton *)sender{

	[self performDismissalAnimation:sender style:style];
}

- (void)buttonWasPressed:(UIButton *)sender {
    if (sender.tag == 101) {
        self.dismissalStyle = PPAlertViewDismissalStyleTumble;
    }else{
        self.dismissalStyle = PPAlertViewDismissalStyleTumble3D;
    }
	
	[self dismissWithStyle:self.dismissalStyle button:sender];
}

#pragma mark - Presentation and dismissal animation utilities

- (void)performPresentationAnimation
{
	if(self.presentationStyle == PPAlertViewPresentationStylePop)
	{
		CAKeyframeAnimation *bounceAnimation = [CAKeyframeAnimation animation];
		bounceAnimation.duration = 0.3;
		bounceAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
		bounceAnimation.values = [NSArray arrayWithObjects:
								  [NSNumber numberWithFloat:0.01],
								  [NSNumber numberWithFloat:1.1],
								  [NSNumber numberWithFloat:0.9],
								  [NSNumber numberWithFloat:1.0],
								  nil];
		
		[self.layer addAnimation:bounceAnimation forKey:@"transform.scale"];
		
		CABasicAnimation *fadeInAnimation = [CABasicAnimation animation];
		fadeInAnimation.duration = 0.3;
		fadeInAnimation.fromValue = [NSNumber numberWithFloat:0];
		fadeInAnimation.toValue = [NSNumber numberWithFloat:1];
		[self.superview.layer addAnimation:fadeInAnimation forKey:@"opacity"];
	}
	else if(self.presentationStyle == PPAlertViewPresentationStyleFade)
	{
		self.superview.alpha = 0;
		
		[UIView animateWithDuration:0.3
							  delay:0.0
							options:UIViewAnimationOptionCurveEaseInOut
						 animations:^
		 {
			 self.superview.alpha = 1;
		 }
						 completion:nil];
	}
	else
	{
		// Views appear immediately when added
	}
}


- (void)showWithStyle:(PPAlertViewPresentationStyle)style
{
	self.presentationStyle = style;
	[self setNeedsLayout];
    
    


//    if ([[[UIDevice currentDevice] systemVersion] floatValue] < 6.0) {
//        UIWindow *keyWindow = [[UIApplication sharedApplication] keyWindow];
//        [keyWindow setWindowLevel:UIWindowLevelAlert];
//        [keyWindow makeKeyAndVisible];
//        UIImageView *dimView = [[UIImageView alloc] initWithFrame:keyWindow.bounds];
//        dimView.image = [self backgroundGradientImageWithSize:keyWindow.bounds.size];
//        dimView.userInteractionEnabled = YES;
//        [keyWindow addSubview:dimView];
//        [dimView addSubview:self];
//        [keyWindow setWindowLevel:UIWindowLevelAlert + 1];
//    }else{
//        UIImageView *dimView = [[UIImageView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
//        dimView.image = [self backgroundGradientImageWithSize:[[UIScreen mainScreen] bounds].size];
//        dimView.userInteractionEnabled = YES;
//        _alertViewWindow = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
//        [_alertViewWindow makeKeyAndVisible];
//        [_alertViewWindow addSubview:dimView];
//        [dimView addSubview:self];
//        [_alertViewWindow setWindowLevel:UIWindowLevelAlert + 1];
//    }
    

//    FLASH AIR AND IOS 
    UIImageView *dimView = [[UIImageView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    dimView.image = [self backgroundGradientImageWithSize:[[UIScreen mainScreen] bounds].size];
    dimView.userInteractionEnabled = YES;
    _alertViewWindow = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    [_alertViewWindow makeKeyAndVisible];
//    if ([self respondsToSelector:@selector(setNeedsStatusBarAppearanceUpdate)]) {
//        // iOS 7
//        [self prefersStatusBarHidden];
//        [self performSelector:@selector(setNeedsStatusBarAppearanceUpdate)];
//    }
    [_alertViewWindow addSubview:dimView];
    [dimView addSubview:self];
    [_alertViewWindow setWindowLevel:UIWindowLevelAlert + 1];
    
    
	[self performPresentationAnimation];

    
}


- (void)performDismissalAnimation:(UIButton *)sender style:(PPAlertViewDismissalStyle)style{
	PPAnimationCompletionBlock completionBlock = ^(BOOL finished)
	{
		[self.superview removeFromSuperview];
		[self removeFromSuperview];
        [_alertViewWindow resignKeyWindow];
        _alertViewWindow = nil;
        
        if ([self respondsToSelector:@selector(setNeedsStatusBarAppearanceUpdate)]) {
            // iOS 7
            [self prefersStatusBarHidden];
            [self performSelector:@selector(setNeedsStatusBarAppearanceUpdate)];
        }


//       flash air
//        [[[[UIApplication sharedApplication] delegate] window] makeKeyAndVisible];
        
        
        
        
//      u3d
        NSArray *windows = [[UIApplication sharedApplication] windows];
        [[windows objectAtIndex:0] makeKeyAndVisible];
        
        PPAlertViewButtonBlock block = objc_getAssociatedObject(sender, kPPAlertViewButtonBlockKey);
        if(block)
            block();
	};

	if(self.dismissalStyle == PPAlertViewDismissalStyleTumble)
	{
		[UIView animateWithDuration:0.7
							  delay:0.0
							options:UIViewAnimationOptionCurveEaseIn
						 animations:^
		 {
			 CGPoint offset = CGPointMake(0, self.superview.bounds.size.height * 1.5);
			 offset = CGPointApplyAffineTransform(offset, self.transform);
			 self.transform = CGAffineTransformConcat(self.transform, CGAffineTransformMakeRotation(-M_PI_4));
			 self.center = CGPointMake(self.center.x + offset.x, self.center.y + offset.y);
			 self.superview.alpha = 0;
		 }
						 completion:completionBlock];
	}
	else if(self.dismissalStyle == PPAlertViewDismissalStyleFade)
	{
		[UIView animateWithDuration:0.25
							  delay:0.0
							options:UIViewAnimationOptionCurveEaseInOut
						 animations:^
		 {
			 self.superview.alpha = 0;
		 }
						 completion:completionBlock];
	}
	else if(self.dismissalStyle == PPAlertViewDismissalStyleZoomDown)
	{
		[UIView animateWithDuration:0.3
							  delay:0.0
							options:UIViewAnimationOptionCurveEaseIn
						 animations:^
		 {
			 self.transform = CGAffineTransformConcat(self.transform, CGAffineTransformMakeScale(0.01, 0.01));
			 self.superview.alpha = 0;
		 }
						 completion:completionBlock];
	}
	else if(self.dismissalStyle == PPAlertViewDismissalStyleZoomOut)
	{
		[UIView animateWithDuration:0.2
							  delay:0.0
							options:UIViewAnimationOptionCurveLinear
						 animations:^
		 {
			 self.transform = CGAffineTransformConcat(self.transform, CGAffineTransformMakeScale(10, 10));
			 self.superview.alpha = 0;
		 }
						 completion:completionBlock];
	}
	else if (self.dismissalStyle == PPAlertViewDismissalStyleTumble3D){
        {
            CGFloat degree = 180.0;
            
            CATransform3D transformation = CATransform3DIdentity;
            CATransform3D xRotation = CATransform3DMakeRotation(degToRadians(degree), 1.0, 0, 0);
            CATransform3D yRotation = CATransform3DMakeRotation(degToRadians(0), 0.0, 1.0, 0);
            CATransform3D zRotation = CATransform3DMakeRotation(degToRadians(-130), 0.0, 0, 1.0);
            CATransform3D xYRotation = CATransform3DConcat(xRotation, yRotation);
            CATransform3D xyZRotation = CATransform3DConcat(xYRotation, zRotation);
            
            CATransform3D translation;
            UIInterfaceOrientation interfaceOrientation = [[UIApplication sharedApplication] statusBarOrientation];
            
            int index = 0;
            float duration = 0.45;
            if ([[UIDevice currentDevice] userInterfaceIdiom]) {
                index = 2.2;
                duration = duration * 1.2;
            }else{
                index = 1.1;
            }
            
            if (interfaceOrientation == UIInterfaceOrientationPortrait) {
                translation = CATransform3DMakeTranslation(1.0, CGRectGetMaxY(self.bounds) * 2.5 * index, 1.0) ;
            }else if (interfaceOrientation == UIInterfaceOrientationPortraitUpsideDown) {
                translation = CATransform3DMakeTranslation(1.0, -CGRectGetMaxY(self.bounds) * 2.5 * index, 1.0);
            }else if (interfaceOrientation == UIInterfaceOrientationLandscapeLeft) {
                translation = CATransform3DMakeTranslation(CGRectGetMaxX(self.bounds) * index, 1.0, 1.0);
            }else if (interfaceOrientation == UIInterfaceOrientationLandscapeRight) {
                translation = CATransform3DMakeTranslation(-CGRectGetMaxX(self.bounds) * index, 1.0, 1.0);
            }else{
                translation = CATransform3DMakeTranslation(1.0, CGRectGetMaxY(self.bounds) * 2.5 * index, 1.0) ;
            }
            
            
            
            CATransform3D concatenatedTransformation = CATransform3DConcat(xyZRotation, translation);
            
            
            CATransform3D final = CATransform3DConcat(concatenatedTransformation, transformation);
            final.m34 = -.0045;
            
            [UIView animateWithDuration:duration
                                  delay:0
                                options:UIViewAnimationOptionCurveEaseIn
                             animations:^{
                                 self.layer.transform = final;
                                 self.superview.alpha = 0;
                             }                completion:completionBlock];
        }
    }
    else
	{
		completionBlock(YES);
	}
}



#pragma mark - Layout calculation methods

- (void)layoutSubviews {
	[super layoutSubviews];
	
	CGAffineTransform baseTransform = [self transformForCurrentOrientation];
	
	CGFloat delta = CGAffineTransformGetAbsoluteRotationAngleDifference(self.transform, baseTransform);
	BOOL isDoubleRotation = (delta > M_PI);
	
	if(hasLayedOut)
	{
		CGFloat duration = [[UIApplication sharedApplication] statusBarOrientationAnimationDuration];
		if(isDoubleRotation)
			duration *= 2;
		
		[UIView animateWithDuration:duration animations:^{
			self.transform = baseTransform;
		}];
	}
	else
		self.transform = baseTransform;
	
	hasLayedOut = YES;
	
	CGRect boundingRect = self.bounds;
	boundingRect.size.height = FLT_MAX;
	boundingRect = UIEdgeInsetsInsetRect(boundingRect, self.contentInsets);
	
	if(!self.titleLabel)
		self.titleLabel = [self addLabelAsSubview];
	
	[self applyTextAttributes:self.titleTextAttributes toLabel:self.titleLabel];
	self.titleLabel.text = self.title;
	CGSize titleSize = [self.titleLabel.text sizeWithFont:self.titleLabel.font constrainedToSize:boundingRect.size lineBreakMode:NSLineBreakByWordWrapping];
	self.titleLabel.frame = CGRectMake(boundingRect.origin.x, boundingRect.origin.y - 5, boundingRect.size.width, titleSize.height);
	
    

    
	const CGFloat titleLabelBottomMargin = 8;
	CGFloat messageLabelOriginY = boundingRect.origin.y + titleSize.height + titleLabelBottomMargin;
	
    if (!self.linView) {
        self.linView = [self addLineAsSubview];
    }
    self.linView.frame = CGRectMake(0, titleLabel.frame.size.height + messageLabelOriginY / 2 -  5, PPAlertViewDefaultWidth, 0.5);
    [self.linView setBackgroundColor:[PPCommon getColor:@"F8B551"]];
    
	if(!self.messageLabel)
		self.messageLabel = [self addLabelAsSubview];
	
	[self applyTextAttributes:self.messageTextAttributes toLabel:self.messageLabel];
	self.messageLabel.text = self.message;
	CGSize messageSize = [self.messageLabel.text sizeWithFont:self.messageLabel.font constrainedToSize:boundingRect.size
                                                lineBreakMode:NSLineBreakByWordWrapping];
	self.messageLabel.frame = CGRectMake(boundingRect.origin.x, messageLabelOriginY + 10, boundingRect.size.width, messageSize.height);

	const CGFloat messageLabelBottomMargin = 20;
	CGFloat buttonOriginY = messageLabelOriginY + messageSize.height + messageLabelBottomMargin;
	
	[self applyBackgroundImages:self.cancelButtonBackgroundImagesForControlStates toButton:self.cancelButton];
	[self applyTextAttributes:self.buttonTitleTextAttributes toButton:self.cancelButton];
	CGRect cancelButtonRect = CGRectMake(0, buttonOriginY + 10,
                                         276 / 2 , PPAlertViewDefaultButtonHeight);
    CGRect otherButtonRect = CGRectMake(cancelButtonRect.size.width , buttonOriginY + 10,
                                        276 / 2, PPAlertViewDefaultButtonHeight);
    


	if([self.otherButtons count] > 0)
	{
        isWhat = NO;
		UIButton *otherButton = [self.otherButtons objectAtIndex:0];
		[self applyBackgroundImages:self.buttonBackgroundImagesForControlStates toButton:otherButton];
		[self applyTextAttributes:self.buttonTitleTextAttributes toButton:otherButton];

		otherButton.frame = otherButtonRect;
        self.cancelButton.frame = cancelButtonRect;
        
	}else{
        isWhat = YES;
        //cancel为确定
        [self.cancelButton setFrame:CGRectMake(0, buttonOriginY + 10, 276, PPAlertViewDefaultButtonHeight)];
        UIEdgeInsets buttonEdgeInsets = UIEdgeInsetsMake(0, 8, 0, 8);

        
        [self.cancelButton setBackgroundImage:[[PPUIKit setLocaImage:@"PPAlertView-CancelAll-normal"] resizableImageWithCapInsets:buttonEdgeInsets]
                           forState:UIControlStateNormal];

        [self.cancelButton setBackgroundImage:[[PPUIKit setLocaImage:@"PPAlertView-CancelAll-pressed"] resizableImageWithCapInsets:buttonEdgeInsets]
                           forState:UIControlStateHighlighted];
        
        
    }
	
	CGFloat calculatedHeight = buttonOriginY + cancelButtonRect.size.height + self.contentInsets.bottom;
	
	CGRect newBounds = CGRectMake(0, 0, self.bounds.size.width, calculatedHeight);
	CGPoint newCenter = CGPointMake(self.superview.bounds.size.width * 0.5, self.superview.bounds.size.height * 0.5);
	self.bounds = newBounds;
	self.center = newCenter;
	
	if(!self.backgroundImageView)
	{
		self.backgroundImageView = [[UIImageView alloc] initWithFrame:self.bounds];
		self.backgroundImageView.autoresizingMask = ~UIViewAutoresizingNone;
		self.backgroundImageView.contentMode = UIViewContentModeScaleToFill;
		[self insertSubview:self.backgroundImageView atIndex:0];
	}
	
	self.backgroundImageView.image = self.backgroundImage;
}

- (UILabel *)addLabelAsSubview
{
	UILabel *label = [[UILabel alloc] initWithFrame:CGRectZero];
	label.backgroundColor = [UIColor clearColor];
    [label setTextAlignment:NSTextAlignmentCenter];
	label.numberOfLines = 0;
	[self addSubview:label];
	
	return label;
}

- (UIView *)addLineAsSubview
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectZero];
	view.backgroundColor = [UIColor clearColor];
	[self addSubview:view];
	
	return view;
}

- (void)applyTextAttributes:(NSDictionary *)attributes toLabel:(UILabel *)label {
	label.font = [attributes objectForKey:UITextAttributeFont];
	label.textColor = [attributes objectForKey:UITextAttributeTextColor];
	label.shadowColor = [attributes objectForKey:UITextAttributeTextShadowColor];
	label.shadowOffset = [[attributes objectForKey:UITextAttributeTextShadowOffset] CGSizeValue];
}

- (void)applyTextAttributes:(NSDictionary *)attributes toButton:(UIButton *)button {
	button.titleLabel.font = [attributes objectForKey:UITextAttributeFont];
	[button setTitleColor:[attributes objectForKey:UITextAttributeTextColor] forState:UIControlStateNormal];
	[button setTitleShadowColor:[attributes objectForKey:UITextAttributeTextShadowColor] forState:UIControlStateNormal];
	button.titleLabel.shadowOffset = [[attributes objectForKey:UITextAttributeTextShadowOffset] CGSizeValue];
}

- (void)applyBackgroundImages:(NSDictionary *)imagesForStates toButton:(UIButton *)button {
	[imagesForStates enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
		[button setBackgroundImage:obj forState:[key integerValue]];
	}];
}

#pragma mark - Orientation helpers

- (CGAffineTransform)transformForCurrentOrientation
{
	CGAffineTransform transform = CGAffineTransformIdentity;
	UIInterfaceOrientation orientation = [[UIApplication sharedApplication] statusBarOrientation];
	if(orientation == UIInterfaceOrientationPortraitUpsideDown)
		transform = CGAffineTransformMakeRotation(M_PI);
	else if(orientation == UIInterfaceOrientationLandscapeLeft)
		transform = CGAffineTransformMakeRotation(-M_PI_2);
	else if(orientation == UIInterfaceOrientationLandscapeRight)
		transform = CGAffineTransformMakeRotation(M_PI_2);
	
	return transform;
}

- (void)deviceOrientationChanged:(NSNotification *)notification
{
	[self setNeedsLayout];
}

#pragma mark - Drawing utilities for implementing system control styles

- (UIImage *)backgroundGradientImageWithSize:(CGSize)size
{
	CGPoint center = CGPointMake(size.width * 0.5, size.height * 0.5);
	CGFloat innerRadius = 0;
    CGFloat outerRadius = sqrtf(size.width * size.width + size.height * size.height) * 0.5;
    
	BOOL opaque = NO;
    UIGraphicsBeginImageContextWithOptions(size, opaque, [[UIScreen mainScreen] scale]);
	CGContextRef context = UIGraphicsGetCurrentContext();
    
    const size_t locationCount = 2;
    CGFloat locations[locationCount] = { 0.0, 1.0 };
    CGFloat components[locationCount * 4] = {
		0.0, 0.0, 0.0, 0.1, // More transparent black
		0.0, 0.0, 0.0, 0.7  // More opaque black
	};
	
    CGColorSpaceRef colorspace = CGColorSpaceCreateDeviceRGB();
    CGGradientRef gradient = CGGradientCreateWithColorComponents(colorspace, components, locations, locationCount);
	
    CGContextDrawRadialGradient(context, gradient, center, innerRadius, center, outerRadius, 0);
	
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    CGColorSpaceRelease(colorspace);
    CGGradientRelease(gradient);
	
    return image;
}

#pragma mark - Class drawing utilities for implementing system control styles

+ (UIImage *)alertBackgroundImage
{

	CGRect rect = CGRectMake(0, 0, PPAlertViewDefaultWidth, PPAlertViewMinimumHeight);
	const CGFloat lineWidth = 0;
	const CGFloat cornerRadius = 4;
    
	CGFloat shineWidth = rect.size.width * 1.33;
	CGFloat shineHeight = rect.size.width * 0.2;
	CGFloat shineOriginX = rect.size.width * 0.5 - shineWidth * 0.5;
	CGFloat shineOriginY = -shineHeight * 0.45;
	CGRect shineRect = CGRectMake(shineOriginX, shineOriginY, shineWidth, shineHeight);
    
    UIColor *fillColor = [UIColor whiteColor];
	UIColor *strokeColor = [UIColor whiteColor];
	
	BOOL opaque = NO;
    UIGraphicsBeginImageContextWithOptions(rect.size, opaque, [[UIScreen mainScreen] scale]);
    
	CGRect fillRect = CGRectInset(rect, lineWidth, lineWidth);
	UIBezierPath *fillPath = [UIBezierPath bezierPathWithRoundedRect:fillRect cornerRadius:cornerRadius];
	[fillColor setFill];
	[fillPath fill];
	
	CGRect strokeRect = CGRectInset(rect, lineWidth * 0.5, lineWidth * 0.5);
	UIBezierPath *strokePath = [UIBezierPath bezierPathWithRoundedRect:strokeRect cornerRadius:cornerRadius];
	strokePath.lineWidth = lineWidth;
	[strokeColor setStroke];
	[strokePath stroke];

	
	UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
	
	CGFloat capHeight = CGRectGetMaxY(shineRect);
	CGFloat capWidth = rect.size.width * 0.5;
	return [image resizableImageWithCapInsets:UIEdgeInsetsMake(capHeight, capWidth, rect.size.height - capHeight, capWidth)];
}


@end
