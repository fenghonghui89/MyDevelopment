//
//  AHAlertView.h
//  AHAlertViewSample
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

#import <UIKit/UIKit.h>

typedef enum {
    PPAlertViewStyleDefault = 0,
    PPAlertViewStyleSecureTextInput,
    PPAlertViewStylePlainTextInput,
    PPAlertViewStyleLoginAndPasswordInput,
} PPAlertViewStyle;

typedef enum {
	PPAlertViewPresentationStyleNone = 0,
	PPAlertViewPresentationStylePop,
	PPAlertViewPresentationStyleFade,
	
	PPAlertViewPresentationStyleDefault = PPAlertViewPresentationStylePop
} PPAlertViewPresentationStyle;

typedef enum {
	PPAlertViewDismissalStyleNone = 0,
	PPAlertViewDismissalStyleZoomDown,
	PPAlertViewDismissalStyleZoomOut,
	PPAlertViewDismissalStyleFade,
	PPAlertViewDismissalStyleTumble,
    PPAlertViewDismissalStyleTumble3D,

	PPAlertViewDismissalStyleDefault = PPAlertViewDismissalStyleFade
} PPAlertViewDismissalStyle;

typedef void (^PPAlertViewButtonBlock)();

@interface PPAlertView : UIView

@property(nonatomic, copy) NSString *title;
@property(nonatomic, copy) NSString *message;
@property(nonatomic, readonly, assign, getter = isVisible) BOOL visible;
@property(nonatomic, assign) PPAlertViewStyle alertViewStyle;
@property(nonatomic, assign) PPAlertViewPresentationStyle presentationStyle;
@property(nonatomic, assign) PPAlertViewDismissalStyle dismissalStyle;

+ (void)applySystemAlertAppearance;

- (id)initWithTitle:(NSString *)title message:(NSString *)message;

- (void)addButtonWithTitle:(NSString *)title block:(PPAlertViewButtonBlock)block;
- (void)setDestructiveButtonTitle:(NSString *)title block:(PPAlertViewButtonBlock)block;
- (void)setCancelButtonTitle:(NSString *)title block:(PPAlertViewButtonBlock)block;

- (void)show;
- (void)showWithStyle:(PPAlertViewPresentationStyle)presentationStyle;
- (void)dismiss;
//- (void)dismissWithStyle:(PPAlertViewDismissalStyle)dismissalStyle;

- (UITextField *)textFieldAtIndex:(NSInteger)textFieldIndex;

@property(nonatomic, strong) UIImage *backgroundImage UI_APPEARANCE_SELECTOR;
@property(nonatomic, assign) UIEdgeInsets contentInsets UI_APPEARANCE_SELECTOR;

@property(nonatomic, copy) NSDictionary *titleTextAttributes UI_APPEARANCE_SELECTOR;
@property(nonatomic, copy) NSDictionary *messageTextAttributes UI_APPEARANCE_SELECTOR;
@property(nonatomic, copy) NSDictionary *buttonTitleTextAttributes UI_APPEARANCE_SELECTOR;

- (void)setButtonBackgroundImage:(UIImage *)backgroundImage forState:(UIControlState)state UI_APPEARANCE_SELECTOR;
- (UIImage *)buttonBackgroundImageForState:(UIControlState)state UI_APPEARANCE_SELECTOR;

- (void)setCancelButtonBackgroundImage:(UIImage *)backgroundImage forState:(UIControlState)state UI_APPEARANCE_SELECTOR;
- (UIImage *)cancelButtonBackgroundImageForState:(UIControlState)state UI_APPEARANCE_SELECTOR;

- (void)setDestructiveButtonBackgroundImage:(UIImage *)backgroundImage forState:(UIControlState)state UI_APPEARANCE_SELECTOR;
- (UIImage *)destructiveButtonBackgroundImageForState:(UIControlState)state UI_APPEARANCE_SELECTOR;

@end
