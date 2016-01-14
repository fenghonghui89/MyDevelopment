//
//  WelcomeViewController.m
//  MyWeiboClient
//
//  Created by hanyfeng on 14-8-14.
//  Copyright (c) 2014年 hanyfeng. All rights reserved.
//

#import "HFWelcomeViewController.h"
#import "HFTabBarController.h"
#import "SliderViewController.h"
#import "HFMenuViewController.h"
#import "CoreDataSettingManager.h"
#import "HFLoginViewController.h"
#import "UserInfo.h"
@interface HFWelcomeViewController ()
@property(nonatomic,retain)UIPageControl *pageControl;
@end

@implementation HFWelcomeViewController

-(void)dealloc
{
    [_pageControl release];
    _pageControl = nil;
    
    [super dealloc];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UIScrollView *sv = [[UIScrollView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    [sv setPagingEnabled:YES];
    [sv setDelegate:self];
    [sv setBounces:NO];
    [sv setShowsHorizontalScrollIndicator:NO];
    [self.view addSubview:sv];
    [sv release];
    
    //获取文件夹中不带@2x的图片名字
    NSFileManager *fm = [NSFileManager defaultManager];
    NSString *imagesDirPath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"MyWeiboClient.bundle/welcome"];
    NSArray *imagePaths = [fm contentsOfDirectoryAtPath:imagesDirPath error:nil];
    NSMutableArray *arr = [NSMutableArray array];
    for (NSString *imagePath in imagePaths) {
        if (![imagePath hasSuffix:@"@2x.jpg"]) {
            [arr addObject:imagePath];
        }
    }
    
    //pageControl
    UIPageControl *pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, UIScreen_Height - 50, UIScreen_Width, 50)];
    [pageControl setNumberOfPages:[arr count]];
    [pageControl setUserInteractionEnabled:NO];
    [self.view addSubview:pageControl];
    self.pageControl = pageControl;
    [pageControl release];
    
    //添加图片
    for (int i = 0; i < arr.count; i++) {
        UIImage *image = [HFCommon getImagePathWithDirectoryName:@"welcome" andImageName:[arr objectAtIndex:i]];
        UIImageView *iv = [[UIImageView alloc] initWithImage:image];
        [iv setFrame:CGRectMake(UIScreen_Width * i, 0, UIScreen_Width, UIScreen_Height)];
        [sv addSubview:iv];
        [iv release];
        [sv setContentSize:CGSizeMake(UIScreen_Width * arr.count, UIScreen_Height)];
        
        if (i == arr.count - 1) {
            UIButton *buttonToNext = [[UIButton alloc] init];
            [buttonToNext setFrame:iv.frame];
            [buttonToNext setBackgroundColor:[UIColor clearColor]];
            [buttonToNext addTarget:self action:@selector(buttonToNextPress) forControlEvents:UIControlEventTouchUpInside];
            [sv addSubview:buttonToNext];
            [buttonToNext release];
        }
    }
}

-(void)buttonToNextPress
{
    UserInfo *userInfo = [[CoreDataSettingManager shareManager] findSettingWithOption:@"userInfo"];
    if (userInfo == nil) {
        HFLoginViewController *loginVC = [[HFLoginViewController alloc] initWithNibName:@"HFLoginViewController" bundle:nil];
        [self presentViewController:loginVC animated:YES completion:nil];
        [loginVC release];
    }else{
        HFTabBarController *tabBarC = [[HFTabBarController alloc] init];
        [[SliderViewController sharedSliderController] setMainVC:tabBarC];
        [tabBarC release];
        
        HFMenuViewController *menuVC = [[HFMenuViewController alloc] init];
        [[SliderViewController sharedSliderController] setLeftVC:menuVC];
        [SliderViewController sharedSliderController].LeftSCloseDuration = 0.4;
        [SliderViewController sharedSliderController].LeftSOpenDuration = 0.4;
        [SliderViewController sharedSliderController].LeftSContentScale = 1.0;
        [SliderViewController sharedSliderController].LeftSContentOffset = 220.0;
        [SliderViewController sharedSliderController].LeftSJudgeOffset = 160.0;
        [menuVC release];

        [self presentViewController:[SliderViewController sharedSliderController] animated:YES completion:nil];
        [tabBarC release];
    }
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    NSInteger index = round(scrollView.contentOffset.x/320);
    self.pageControl.currentPage = index;
}


@end
