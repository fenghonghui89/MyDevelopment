//
//  HFTabBarController.m
//  MyWeiboClient
//
//  Created by hanyfeng on 14-8-15.
//  Copyright (c) 2014年 hanyfeng. All rights reserved.
//

#import "HFTabBarController.h"
#import "HFNavigationController.h"

#import "SliderViewController.h"
#import "HFHomeViewController.h"
#import "HFMessageCenterViewController.h"
#import "HFDiscoverViewController.h"
#import "HFMoreViewController.h"
#import "HFProfileViewController.h"
#import "HFMenuViewController.h"

#import "HFButton.h"
#import "CoreDataSettingManager.h"

@interface HFTabBarController ()
@property(nonatomic,retain)UIImageView *tabbarBgView;
@end

@implementation HFTabBarController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)dealloc
{
    [_tabbarBgView release];
    _tabbarBgView = nil;
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
    [super dealloc];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.tabBar setHidden:YES];
    
    [self.view setBackgroundColor:[UIColor redColor]];
    
    //创建vc加入到tabbar
    NSArray *VCClassNames = @[@"HFHomeViewController",@"HFMessageCenterViewController",@"HFProfileViewController",@"HFDiscoverViewController",@"HFMoreViewController"];
    NSMutableArray *vcs = [NSMutableArray array];
    for (int i = 0; i < [VCClassNames count]; i++) {
        Class VCClass = NSClassFromString(VCClassNames[i]);
        id vc = [[VCClass alloc] init];
        HFNavigationController *navi = [[HFNavigationController alloc] initWithRootViewController:vc];
        [navi.navigationBar setTranslucent:NO];
        [vcs addObject:navi];
        [vc release];
        [navi release];
    }
    self.viewControllers = vcs;
    [self setSelectedIndex:0];
    
    
    //自定义tabbar及按钮
    UIImageView *tabbarBgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, UIScreen_Height - 49, UIScreen_Width, 49)];
    [tabbarBgView setUserInteractionEnabled:YES];
    [self.view addSubview:tabbarBgView];
    self.tabbarBgView = tabbarBgView;
    [tabbarBgView release];
    
    NSArray *btnImageNames = @[@"tabbar_home.png",@"tabbar_message_center.png",@"tabbar_profile.png",@"tabbar_discover.png",@"tabbar_more.png"];
    NSArray *btnHImageNames = @[@"tabbar_home_highlighted.png",@"tabbar_message_center_highlighted.png",@"tabbar_profile_highlighted.png",@"tabbar_discover_highlighted.png",@"tabbar_more_highlighted.png"];
    
    for (int i = 0; i < 5; i++) {
        CGRect btnFrame = CGRectMake(i* 64, 0, 64, 49);
        HFButton *btn = [[HFButton alloc] initWithFrame:btnFrame andImageName:btnImageNames[i] andHImageName:btnHImageNames[i]];
        btn.tag = i;
        [btn addTarget:self action:@selector(buttonPress:) forControlEvents:UIControlEventTouchUpInside];
        [tabbarBgView addSubview:btn];
        [btn release];
    }
        
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeUI) name:@"changeUI" object:nil];
    
    [self changeUI];
}

-(void)buttonPress:(UIButton *)button
{
    self.selectedIndex = button.tag;
}

-(void)changeUI
{
    NSString *skin = [[CoreDataSettingManager shareManager] findSettingWithOption:@"skin"];
    NSString *directoryName = [NSString stringWithFormat:@"skins/%@",skin];
    [self.tabbarBgView setImage:[HFCommon getImagePathWithDirectoryName:directoryName andImageName:@"tabbar_background.png"]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
