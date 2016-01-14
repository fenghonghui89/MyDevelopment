//
//  HFLoginViewController.m
//  MyWeiboClient
//
//  Created by hanyfeng on 14-8-20.
//  Copyright (c) 2014年 hanyfeng. All rights reserved.
//

#import "HFLoginViewController.h"
#import "HFAppDelegate.h"
#import "UserInfo.h"
@interface HFLoginViewController ()
@property (retain, nonatomic) IBOutlet UILabel *userNameLabel;

@end

@implementation HFLoginViewController

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
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    UserInfo *userInfo = [[CoreDataSettingManager shareManager] findSettingWithOption:@"userInfo"];
    
    if (userInfo == nil) {
        [_userNameLabel setText:@"无用户登录"];
    }else{
        NSString *access_token = userInfo.access_token;
        NSString *uid = userInfo.uid;
        [dic setObject:access_token forKey:@"access_token"];
        [dic setObject:uid forKey:@"uid"];
        
        WBHttpRequest *hr = [WBHttpRequest requestWithURL:@"https://api.weibo.com/2/users/show.json" httpMethod:@"GET" params:dic delegate:self withTag:0];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)loginBtnPress:(id)sender
{
    HFAppDelegate *appDelegate = (HFAppDelegate *)[[UIApplication sharedApplication] delegate];
    appDelegate.loginVC = self;
    
    WBAuthorizeRequest *request = [WBAuthorizeRequest request];
    request.redirectURI = kRedirectURL;
    [WeiboSDK sendRequest:request];
}

#pragma mark - WBHttpRequest Delegate
-(void)request:(WBHttpRequest *)request didFailWithError:(NSError *)error
{

}

-(void)request:(WBHttpRequest *)request didFinishLoadingWithDataResult:(NSData *)data
{
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
    NSString *userName = [dic objectForKey:@"screen_name"];
    userName = [userName stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    _userNameLabel.text = userName;
}

-(void)request:(WBHttpRequest *)request didFinishLoadingWithResult:(NSString *)result
{

}

-(void)request:(WBHttpRequest *)request didReceiveResponse:(NSURLResponse *)response
{

}

- (void)dealloc {
    [_userNameLabel release];
    [super dealloc];
}
@end
