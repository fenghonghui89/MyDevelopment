//
//  HFNavigationController.m
//  MyWeiboClient
//
//  Created by hanyfeng on 14-8-21.
//  Copyright (c) 2014年 hanyfeng. All rights reserved.
//

#import "HFNavigationController.h"
#import "CoreDataSettingManager.h"

@interface HFNavigationController ()
@end

@implementation HFNavigationController

-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
    [super dealloc];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeUI) name:@"changeUI" object:nil];
    
    [self.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],NSForegroundColorAttributeName,[UIFont systemFontOfSize:20],NSFontAttributeName, nil]];
    
    [self changeUI];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

-(void)changeUI
{
    NSString *skin = [[CoreDataSettingManager shareManager] findSettingWithOption:@"skin"];
    NSString *directoryName = [NSString stringWithFormat:@"skins/%@",skin];
    [self.navigationBar setBackgroundImage:[HFCommon getImagePathWithDirectoryName:directoryName andImageName:@"navigationbar_background.png"] forBarMetrics:UIBarMetricsDefault];
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
