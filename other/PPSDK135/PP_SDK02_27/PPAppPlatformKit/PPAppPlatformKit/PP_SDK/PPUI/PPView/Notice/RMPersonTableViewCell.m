//
//  RMPersonTableViewCell.m
//  RMSwipeTableView
//
//  Created by Rune Madsen on 2013-05-13.
//  Copyright (c) 2013 The App Boutique. All rights reserved.
//

#import "RMPersonTableViewCell.h"
#import <QuartzCore/QuartzCore.h>
#import "PPCommon.h"
#import "PPNoticeListView.h"

@interface RMPersonTableViewCell () {
}

@end

@implementation RMPersonTableViewCell


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setClipsToBounds:YES];
        
        [self.textLabel setHidden:YES];
        [self.detailLabel setHidden:YES];
        
		_profileImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 8, 8)];
		[_profileImageView setBackgroundColor:[UIColor whiteColor]];
		[_profileImageView setClipsToBounds:YES];
		[_profileImageView setContentMode:UIViewContentModeScaleAspectFill];
//		[self.profileImageView.layer setBorderColor:[UIColor colorWithWhite:0 alpha:0.3].CGColor];
//		[self.profileImageView.layer setBorderWidth:1];
//        [self.profileImageView.layer setCornerRadius:2];
        [self.contentView addSubview:_profileImageView];
        [_profileImageView release];
        
        _checkedMarkImageView = [[UIImageView alloc] initWithFrame:CGRectMake(-16, 32, 16, 16)];
		[_checkedMarkImageView setBackgroundColor:[UIColor whiteColor]];
        [_checkedMarkImageView setImage:[PPUIKit setLocaImage:@"PPMailUnchecked"]];
        [_checkedMarkImageView setAlpha:0];
        [self.contentView addSubview:_checkedMarkImageView];
        [_checkedMarkImageView release];
        
        
        _senderLabel = [[UILabel alloc] init];
        [_senderLabel setText:@"系统"];
        [_senderLabel setFont:[UIFont boldSystemFontOfSize:15]];
        [self.contentView addSubview:_senderLabel];
        [_senderLabel release];
        
        
        _titleLabel = [[UILabel alloc] init];
        [_titleLabel setText:@"_titleLabel"];
        [_titleLabel setFont:[UIFont systemFontOfSize:12]];
        [self.contentView addSubview:_titleLabel];
        [_titleLabel release];
        
        _detailLabel = [[UILabel alloc] init];
        [_detailLabel setText:@"_detailLabel"];
        [_detailLabel setFont:[UIFont systemFontOfSize:12]];
        [self.contentView addSubview:_detailLabel];
        [_detailLabel release];
        
        _dateLabel = [[UILabel alloc] init];
        [_dateLabel setText:@"1970-01-01"];
        [_dateLabel setFont:[UIFont systemFontOfSize:11]];
        [self.contentView addSubview:_dateLabel];
        [_dateLabel release];
        
        [_senderLabel setTextColor:[PPCommon getColor:@"007aff"]];
        [_titleLabel setTextColor:[PPCommon getColor:@"292e34"]];
        [_detailLabel setTextColor:[PPCommon getColor:@"8b8b8b"]];
        [_dateLabel setTextColor:[PPCommon getColor:@"909090"]];
        
        [self onDeviceOrientationChange1:NO];
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(onDeviceOrientationChange1:)
                                                     name:UIApplicationDidChangeStatusBarOrientationNotification
                                                   object:nil];
    }
    return self;
}

//竖
-(void)initVerticalFrame{
    
    float width = 0;
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        //iPad处理部分
        width = UI_IPHONE_SCREEN_WIDTH;
        
    }else{
        //iPhone处理部分
        width = UI_SCREEN_WIDTH;
    }

    
    if ([[PPNoticeListView sharedInstance] editStatus]) {
        if ([[PPNoticeListView sharedInstance] isCellAnimation]) {
            [_senderLabel setFrame:CGRectMake(16 , 12, 200, 20)];
            
            [_titleLabel setFrame:CGRectMake(16 , _senderLabel.frame.origin.y + _senderLabel.frame.size.height, width - 26, 18)];
            [_detailLabel setFrame:CGRectMake(16 , _titleLabel.frame.origin.y + _titleLabel.frame.size.height, width - 26, 18)];
            [_dateLabel setFrame:CGRectMake(width - 100, 12, 80, 20)];
            
            [_checkedMarkImageView setFrame: CGRectMake(-16, 32, 16, 16)];

            [UIView beginAnimations:@"edit" context:nil];
            [UIView setAnimationDuration:0.3];
        }
        
        [_senderLabel setFrame:CGRectMake(16 + 20, 12, 200, 20)];
        
        [_titleLabel setFrame:CGRectMake(16 + 20, _senderLabel.frame.origin.y + _senderLabel.frame.size.height, width - 46, 18)];
        [_detailLabel setFrame:CGRectMake(16 + 20, _titleLabel.frame.origin.y + _titleLabel.frame.size.height, width - 46, 18)];
        [_dateLabel setFrame:CGRectMake(width - 100 + 20, 12, 80, 20)];
        
        [_checkedMarkImageView setFrame: CGRectMake(10, 32, 16, 16)];
        [_checkedMarkImageView setAlpha:1];
        
        if ([[PPNoticeListView sharedInstance] isCellAnimation]) {
            [UIView commitAnimations];
        }
        
    }
    else
    {
        if ([[PPNoticeListView sharedInstance] isCellAnimation]) {
            [_senderLabel setFrame:CGRectMake(16 + 20, 12, 200, 20)];
            
            [_titleLabel setFrame:CGRectMake(16 + 20, _senderLabel.frame.origin.y + _senderLabel.frame.size.height, width - 46, 18)];
            [_detailLabel setFrame:CGRectMake(16 + 20, _titleLabel.frame.origin.y + _titleLabel.frame.size.height, width - 46, 18)];
            [_dateLabel setFrame:CGRectMake(width - 100 + 20, 12, 80, 20)];
            
            [_checkedMarkImageView setFrame: CGRectMake(10, 32, 16, 16)];
            [_checkedMarkImageView setAlpha:1];
            
            [UIView beginAnimations:@"edit" context:nil];
            [UIView setAnimationDuration:0.3];
        }
        
        [_senderLabel setFrame:CGRectMake(16 , 12, 200, 20)];
        
        [_titleLabel setFrame:CGRectMake(16 , _senderLabel.frame.origin.y + _senderLabel.frame.size.height, width - 26, 18)];
        [_detailLabel setFrame:CGRectMake(16 , _titleLabel.frame.origin.y + _titleLabel.frame.size.height, width - 26, 18)];
        [_dateLabel setFrame:CGRectMake(width - 100, 12, 80, 20)];
        
        [_checkedMarkImageView setFrame: CGRectMake(-16, 32, 16, 16)];
        [_checkedMarkImageView setAlpha:0];
        
        if ([[PPNoticeListView sharedInstance] isCellAnimation]) {
            [UIView commitAnimations];
        }
    }
}

//横
-(void)initHorizontalFrame{
    
    //    [super initHorizontalFrame];
    
    float width = 0;
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        //iPad处理部分
        width = UI_IPHONE_SCREEN_HEIGHT;
        
    }else{
        //iPhone处理部分
        width = UI_SCREEN_HEIGHT;
    }
    
    if ([[PPNoticeListView sharedInstance] editStatus]) {
        if ([[PPNoticeListView sharedInstance] isCellAnimation]) {
            
            [_senderLabel setFrame:CGRectMake(16 , 12, width - 116, 20)];
            
            [_titleLabel setFrame:CGRectMake(16 , _senderLabel.frame.origin.y + _senderLabel.frame.size.height, width - 26, 18)];
            [_detailLabel setFrame:CGRectMake(16 , _titleLabel.frame.origin.y + _titleLabel.frame.size.height, width - 26, 18)];
            [_dateLabel setFrame:CGRectMake(width - 100, 12, 80, 20)];
            
            [_checkedMarkImageView setFrame: CGRectMake(-16, 32, 16, 16)];
            
            [UIView beginAnimations:@"edit" context:nil];
            [UIView setAnimationDuration:0.3];
        }
        
        [_senderLabel setFrame:CGRectMake(16 + 20, 12, width - 116, 20)];
        
        [_titleLabel setFrame:CGRectMake(16 + 20, _senderLabel.frame.origin.y + _senderLabel.frame.size.height, width - 46, 18)];
        [_detailLabel setFrame:CGRectMake(16 + 20, _titleLabel.frame.origin.y + _titleLabel.frame.size.height, width - 46, 18)];
        [_dateLabel setFrame:CGRectMake(width - 100 + 20, 12, 80, 20)];
        
        [_checkedMarkImageView setFrame: CGRectMake(10, 32, 16, 16)];
        [_checkedMarkImageView setAlpha:1];
        
        if ([[PPNoticeListView sharedInstance] isCellAnimation]) {
            [UIView commitAnimations];
        }
        
    }
    else
    {
        if ([[PPNoticeListView sharedInstance] isCellAnimation]) {
            [_senderLabel setFrame:CGRectMake(16 + 20, 12, width - 116, 20)];
            
            [_titleLabel setFrame:CGRectMake(16 + 20, _senderLabel.frame.origin.y + _senderLabel.frame.size.height, width - 46, 18)];
            [_detailLabel setFrame:CGRectMake(16 + 20, _titleLabel.frame.origin.y + _titleLabel.frame.size.height, width - 46, 18)];
            [_dateLabel setFrame:CGRectMake(width - 100 + 20, 12, 80, 20)];
            
            [_checkedMarkImageView setFrame: CGRectMake(10, 32, 16, 16)];
            [_checkedMarkImageView setAlpha:1];
            
            [UIView beginAnimations:@"edit" context:nil];
            [UIView setAnimationDuration:0.3];
        }
        
        [_senderLabel setFrame:CGRectMake(16 , 12, width - 116, 20)];
        
        [_titleLabel setFrame:CGRectMake(16 , _senderLabel.frame.origin.y + _senderLabel.frame.size.height, width - 26, 18)];
        [_detailLabel setFrame:CGRectMake(16 , _titleLabel.frame.origin.y + _titleLabel.frame.size.height, width - 26, 18)];
        [_dateLabel setFrame:CGRectMake(width - 100, 12, 80, 20)];
        
        [_checkedMarkImageView setFrame: CGRectMake(-16, 32, 16, 16)];
        [_checkedMarkImageView setAlpha:0];
        
        if ([[PPNoticeListView sharedInstance] isCellAnimation]) {
            [UIView commitAnimations];
        }
    }

}

//按照当前屏幕方向设置ui坐标
-(void)onDeviceOrientationChange1:(BOOL)paramAnimated {
    
    /**
     *页面旋屏通知回调
     *首先判断是否开启允许旋屏
     *判断旋转后当前状态栏方向。根据方向旋转View，并加载坐标
     */
    UIInterfaceOrientation interfaceOrientation = (UIInterfaceOrientation)[[UIApplication sharedApplication] statusBarOrientation];
    
    if(interfaceOrientation == UIDeviceOrientationPortrait)
    {
        if ([PPUIKit getIsDeviceOrientationPortrait]) {
            //            [self setTransform:CGAffineTransformMakeRotation(0)];
            [self initVerticalFrame];
        }
    }
    else if(interfaceOrientation == UIDeviceOrientationPortraitUpsideDown)
    {
        if ([PPUIKit getIsDeviceOrientationPortraitUpsideDown]) {
            //            [self setTransform:CGAffineTransformMakeRotation(M_PI)];
            [self initVerticalFrame];
        }
    }
    else if(interfaceOrientation == UIDeviceOrientationLandscapeLeft)
    {
        if ([PPUIKit getIsDeviceOrientationLandscapeLeft]) {
            //            [self setTransform:CGAffineTransformMakeRotation(M_PI_2)];
            [self initHorizontalFrame];
        }
    }
    else if(interfaceOrientation == UIDeviceOrientationLandscapeRight)
    {
        if ([PPUIKit getIsDeviceOrientationLandscapeRight]) {
            //            [self setTransform:CGAffineTransformMakeRotation(- M_PI_2)];
            [self initHorizontalFrame];
        }
    }
    
    if (paramAnimated) {
        [UIView commitAnimations];
    }
}



- (void)mm{
    NSLog(@"aaa");
}

//- (void)initFrame
//{
// 
//    if ([[PPNoticeListView sharedInstance] editStatus]) {
//        if ([[PPNoticeListView sharedInstance] isCellAnimation]) {
//            [_senderLabel setFrame:CGRectMake(16 , 12, 200, 20)];
//            
//            [_titleLabel setFrame:CGRectMake(16 , _senderLabel.frame.origin.y + _senderLabel.frame.size.height, self.frame.size.width - 26, 18)];
//            [_detailLabel setFrame:CGRectMake(16 , _titleLabel.frame.origin.y + _titleLabel.frame.size.height, self.frame.size.width - 40, 18)];
//            [_dateLabel setFrame:CGRectMake(self.frame.size.width - 99, 12, 90, 20)];
//            
//            [_checkedMarkImageView setFrame: CGRectMake(-16, 32, 16, 16)];
//            [UIView beginAnimations:@"edit" context:nil];
//            [UIView setAnimationDuration:0.3];
//        }
//      
//        [_senderLabel setFrame:CGRectMake(16 + 20, 12, 200, 20)];
//        
//        [_titleLabel setFrame:CGRectMake(16 + 20, _senderLabel.frame.origin.y + _senderLabel.frame.size.height, self.frame.size.width - 26, 18)];
//        [_detailLabel setFrame:CGRectMake(16 + 20, _titleLabel.frame.origin.y + _titleLabel.frame.size.height, self.frame.size.width - 40, 18)];
//        [_dateLabel setFrame:CGRectMake(self.frame.size.width - 99 + 20, 12, 90, 20)];
//        
//        [_checkedMarkImageView setFrame: CGRectMake(10, 32, 16, 16)];
//        
//        if ([[PPNoticeListView sharedInstance] isCellAnimation]) {
//            [UIView commitAnimations];
//        }
//        
//    }
//    else
//    {
//        if ([[PPNoticeListView sharedInstance] isCellAnimation]) {
//            [_senderLabel setFrame:CGRectMake(16 + 20, 12, 200, 20)];
//            
//            [_titleLabel setFrame:CGRectMake(16 + 20, _senderLabel.frame.origin.y + _senderLabel.frame.size.height, self.frame.size.width - 26, 18)];
//            [_detailLabel setFrame:CGRectMake(16 + 20, _titleLabel.frame.origin.y + _titleLabel.frame.size.height, self.frame.size.width - 40, 18)];
//            [_dateLabel setFrame:CGRectMake(self.frame.size.width - 99 + 20, 12, 90, 20)];
//            
//            [_checkedMarkImageView setFrame: CGRectMake(10, 32, 16, 16)];
//            
//            [UIView beginAnimations:@"edit" context:nil];
//            [UIView setAnimationDuration:0.3];
//        }
//        
//        [_senderLabel setFrame:CGRectMake(16, 12, 200, 20)];
//        
//        [_titleLabel setFrame:CGRectMake(16, _senderLabel.frame.origin.y + _senderLabel.frame.size.height, self.frame.size.width - 26, 18)];
//        [_detailLabel setFrame:CGRectMake(16, _titleLabel.frame.origin.y + _titleLabel.frame.size.height, self.frame.size.width - 40, 18)];
//        [_dateLabel setFrame:CGRectMake(self.frame.size.width - 99, 12, 90, 20)];
//        
//        [_checkedMarkImageView setFrame: CGRectMake(-16, 32, 16, 16)];
//        
//        if ([[PPNoticeListView sharedInstance] isCellAnimation]) {
//            [UIView commitAnimations];
//        }
//    }
//}

- (void) setChecked:(BOOL)checked
{
    if (checked)
    {
        [_checkedMarkImageView setImage:[PPUIKit setLocaImage:@"PPMailChecked"]];
    }
    else
    {
        [_checkedMarkImageView setImage:[PPUIKit setLocaImage:@"PPMailUnchecked"]];
    }
    _checked = checked;
}

-(UIImageView*)checkmarkGreyImageView {
    if (!_checkmarkGreyImageView) {
        _checkmarkGreyImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetHeight(self.frame), CGRectGetHeight(self.frame))];
        [_checkmarkGreyImageView setImage:[PPUIKit setLocaImage:@"CheckmarkGrey"]];
        [_checkmarkGreyImageView setContentMode:UIViewContentModeCenter];
        [self.backView addSubview:_checkmarkGreyImageView];
    }
    return _checkmarkGreyImageView;
}

-(UIImageView*)checkmarkGreenImageView {
    if (!_checkmarkGreenImageView) {
        _checkmarkGreenImageView = [[UIImageView alloc] initWithFrame:self.checkmarkGreyImageView.bounds];
        [_checkmarkGreenImageView setImage:[PPUIKit setLocaImage:@"CheckmarkGreen"]];
        [_checkmarkGreenImageView setContentMode:UIViewContentModeCenter];
        [self.checkmarkGreyImageView addSubview:_checkmarkGreenImageView];
    }
    return _checkmarkGreenImageView;
}



-(UIImageView*)deleteGreyImageView {
    if (!_deleteGreyImageView) {
        _deleteGreyImageView = [[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.contentView.frame), 0, CGRectGetHeight(self.frame), CGRectGetHeight(self.frame))];
        [_deleteGreyImageView setImage:[PPUIKit setLocaImage:@"DeleteGrey"]];
        [_deleteGreyImageView setContentMode:UIViewContentModeCenter];
        [self.backView addSubview:_deleteGreyImageView];
    }
    return _deleteGreyImageView;
}

-(UIImageView*)deleteRedImageView {
    if (!_deleteRedImageView) {
        _deleteRedImageView = [[UIImageView alloc] initWithFrame:self.deleteGreyImageView.bounds];
        [_deleteRedImageView setImage:[PPUIKit setLocaImage:@"DeleteRed"]];
        [_deleteRedImageView setContentMode:UIViewContentModeCenter];
        [self.deleteGreyImageView addSubview:_deleteRedImageView];
    }
    return _deleteRedImageView;
}

-(void)prepareForReuse {
	[super prepareForReuse];

	[self setUserInteractionEnabled:YES];
	self.imageView.alpha = 1;
	self.accessoryView = nil;
	self.accessoryType = UITableViewCellAccessoryNone;
    [self.contentView setHidden:NO];
    [self cleanupBackView];
}

-(void)layoutSubviews {
    [super layoutSubviews];
}

-(void)setThumbnail:(UIImage*)image {
	[self.profileImageView setImage:image];
}


//NO为未读,对钩颜色添加
-(void)setFavourite:(BOOL)favourite animated:(BOOL)animated {
    self.isFavourite = favourite;
    if (animated) {
        if (favourite) {
            CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"borderColor"];
            animation.toValue = (id)[UIColor colorWithRed:0.149 green:0.784 blue:0.424 alpha:0.750].CGColor;
            animation.fromValue = (id)[UIColor colorWithWhite:0 alpha:0.3].CGColor;
            animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
            animation.duration = 0.25;

        } else {
            CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"borderColor"];
            animation.toValue = (id)[UIColor colorWithWhite:0 alpha:0.3].CGColor;
            animation.fromValue = (id)[UIColor colorWithRed:0.149 green:0.784 blue:0.424 alpha:0.750].CGColor;
            animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
            animation.duration = 0.25;

        }
    } else {
        if (favourite) {
//            [self.checkmarkProfileImageView setAlpha:1];
        } else {
//            [self.checkmarkProfileImageView setAlpha:0];
        }
    }
}

-(void)animateContentViewForPoint:(CGPoint)point velocity:(CGPoint)velocity {
    [super animateContentViewForPoint:point velocity:velocity];
    if (point.x > 0) {
        // set the checkmark's frame to match the contentView
        [self.checkmarkGreyImageView setFrame:CGRectMake(MIN(CGRectGetMinX(self.contentView.frame) - CGRectGetWidth(self.checkmarkGreyImageView.frame), 0), CGRectGetMinY(self.checkmarkGreyImageView.frame), CGRectGetWidth(self.checkmarkGreyImageView.frame), CGRectGetHeight(self.checkmarkGreyImageView.frame))];
        if (point.x >= CGRectGetHeight(self.frame) && self.isFavourite == NO) {
            [self.checkmarkGreenImageView setAlpha:1];
        } else if (self.isFavourite == NO) {
            [self.checkmarkGreenImageView setAlpha:0];
        } else if (point.x >= CGRectGetHeight(self.frame) && self.isFavourite == YES) {
            // already a favourite; animate the green checkmark drop when swiped far enough for the action to kick in when user lets go
            if (self.checkmarkGreyImageView.alpha == 1) {
                [UIView animateWithDuration:0.25
                                 animations:^{
                                     CATransform3D rotate = CATransform3DMakeRotation(-0.4, 0, 0, 1);
                                     [self.checkmarkGreenImageView.layer setTransform:CATransform3DTranslate(rotate, -10, 20, 0)];
                                     [self.checkmarkGreenImageView setAlpha:0];
                                 }];
            }
        } else if (self.isFavourite == YES) {
            // already a favourite; but user panned back to a lower value than the action point
            CATransform3D rotate = CATransform3DMakeRotation(0, 0, 0, 1);
            [self.checkmarkGreenImageView.layer setTransform:CATransform3DTranslate(rotate, 0, 0, 0)];
            [self.checkmarkGreenImageView setAlpha:1];
        }
    } else if (point.x < 0) {
        // set the X's frame to match the contentView
        [self.deleteGreyImageView setFrame:CGRectMake(MAX(CGRectGetMaxX(self.frame) - CGRectGetWidth(self.deleteGreyImageView.frame), CGRectGetMaxX(self.contentView.frame)), CGRectGetMinY(self.deleteGreyImageView.frame), CGRectGetWidth(self.deleteGreyImageView.frame), CGRectGetHeight(self.deleteGreyImageView.frame))];
        if (-point.x >= CGRectGetHeight(self.frame)) {
            [self.deleteRedImageView setAlpha:1];
        } else {
            [self.deleteRedImageView setAlpha:0];
        }
    }
}

-(void)resetCellFromPoint:(CGPoint)point velocity:(CGPoint)velocity {

    if (point.x > 0 && point.x <= CGRectGetHeight(self.frame)) {
        // user did not swipe far enough, animate the checkmark back with the contentView animation
        [UIView animateWithDuration:self.animationDuration
                         animations:^{
                             [self.checkmarkGreyImageView setFrame:CGRectMake(-CGRectGetWidth(self.checkmarkGreyImageView.frame), CGRectGetMinY(self.checkmarkGreyImageView.frame), CGRectGetWidth(self.checkmarkGreyImageView.frame), CGRectGetHeight(self.checkmarkGreyImageView.frame))];
                         }];
    } else if (point.x < 0) {
        if (-point.x <= CGRectGetHeight(self.frame)) {
            // user did not swipe far enough, animate the grey X back with the contentView animation
            [UIView animateWithDuration:self.animationDuration
                             animations:^{
                                 [self.deleteGreyImageView setFrame:CGRectMake(CGRectGetMaxX(self.frame), CGRectGetMinY(self.deleteGreyImageView.frame), CGRectGetWidth(self.deleteGreyImageView.frame), CGRectGetHeight(self.deleteGreyImageView.frame))];
                             }];
        } else {
            // user did swipe far enough to meet the delete action requirement, animate the Xs to show selection
            PPAlertView *alert = [[PPAlertView alloc] initWithTitle:@"提示" message:@"确定删除"];
            [alert setCancelButtonTitle:@"确定" block:^{
                [UIView animateWithDuration:self.animationDuration
                                 animations:^{
                                     [self.deleteGreyImageView.layer setTransform:CATransform3DMakeScale(2, 2, 2)];
                                     [self.deleteGreyImageView setAlpha:0];
                                     [self.deleteRedImageView.layer setTransform:CATransform3DMakeScale(2, 2, 2)];
                                     [self.deleteRedImageView setAlpha:0];
                                 
                                 } completion:^(BOOL finished) {
                                     [super resetCellFromPoint:point velocity:velocity];
                                 }];
                
            }];
            
            [alert addButtonWithTitle:@"取消" block:^{
//                [super resetCellFromPoint:point velocity:velocity];
//                [UIView animateWithDuration:self.animationDuration
//                                 animations:^{
//                                     [self.deleteGreyImageView.layer setTransform:CATransform3DMakeScale(2, 2, 2)];
//                                     [self.deleteGreyImageView setAlpha:0];
//                                     [self.deleteRedImageView.layer setTransform:CATransform3DMakeScale(2, 2, 2)];
//                                     [self.deleteRedImageView setAlpha:0];
//                                 }];
                [UIView animateWithDuration:self.animationDuration
                                      delay:0
                                    options:(UIViewAnimationOptions)self.animationType
                                 animations:^{
                                     self.contentView.frame = CGRectOffset(self.contentView.bounds, 0, 0);
                                 }
                                 completion:^(BOOL finished) {
                                     [self cleanupBackView];
                                     if ([self.delegate respondsToSelector:@selector(swipeTableViewCellDidResetState:fromPoint:animation:velocity:)]) {
                                         [self.delegate swipeTableViewCellDidResetState:self fromPoint:point animation:self.animationType velocity:velocity];
                                     }
                                 }
                 ];
                
                
            }];
            [alert show];
            [alert release];
            return;
        }
    }
    [super resetCellFromPoint:point velocity:velocity];
}



-(void)cleanupBackView {
    [super cleanupBackView];
    [_checkmarkGreyImageView removeFromSuperview];
    _checkmarkGreyImageView = nil;
    [_checkmarkGreenImageView removeFromSuperview];
    _checkmarkGreenImageView = nil;
    [_deleteGreyImageView removeFromSuperview];
    _deleteGreyImageView = nil;
    [_deleteRedImageView removeFromSuperview];
    _deleteRedImageView = nil;
}

-(void)dealloc
{
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIApplicationDidChangeStatusBarOrientationNotification object:nil];
    [super dealloc];
}

@end
