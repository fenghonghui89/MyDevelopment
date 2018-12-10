//
//  HFButton.m
//  MyWeiboClient
//
//  Created by hanyfeng on 14-8-18.
//  Copyright (c) 2014年 hanyfeng. All rights reserved.
//

#import "HFButton.h"
#import "CoreDataSettingManager.h"

@interface HFButton()
@property(nonatomic,copy)NSString *imageName;
@property(nonatomic,copy)NSString *hImageName;
@end
@implementation HFButton

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

-(void)dealloc
{
    [_imageName release];
    _imageName = nil;
    [_hImageName release];
    _hImageName = nil;
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
    [super dealloc];
}

-(id)initWithFrame:(CGRect)frame andImageName:(NSString *)imageName andHImageName:(NSString *)hImageName
{
    self = [super initWithFrame:frame];
    if (self) {
        self.imageName = imageName;
        self.hImageName = hImageName;
        self.showsTouchWhenHighlighted = YES;
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeUI) name:@"changeUI" object:nil];
        [self changeUI];
    }
    return self;
}

-(void)changeUI
{
    NSString *skin = [[CoreDataSettingManager shareManager] findSettingWithOption:@"skin"];
    
    NSString *directoryName = [NSString stringWithFormat:@"skins/%@",skin];
    
    [self setImage:[HFCommon getImagePathWithDirectoryName:directoryName andImageName:self.imageName] forState:UIControlStateNormal];
    [self setImage:[HFCommon getImagePathWithDirectoryName:directoryName andImageName:self.hImageName] forState:UIControlStateHighlighted];
}
/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect
 {
 // Drawing code
 }
 */

@end
