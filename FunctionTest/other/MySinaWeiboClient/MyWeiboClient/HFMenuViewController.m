//
//  HFLeftViewController.m
//  MyWeiboClient
//
//  Created by hanyfeng on 14-8-20.
//  Copyright (c) 2014年 hanyfeng. All rights reserved.
//

#import "HFMenuViewController.h"
@interface HFMenuViewController ()<NSURLConnectionDataDelegate>
@property (retain, nonatomic) IBOutlet UIImageView *headerImageView;
@property (retain, nonatomic) IBOutlet UITableView *groupTableView;

@property(nonatomic,retain)NSMutableData *headerData;
@end

@implementation HFMenuViewController

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
    
    NSString *access_token = userInfo.access_token;
    NSString *uid = userInfo.uid;
    [dic setObject:access_token forKey:@"access_token"];
    [dic setObject:uid forKey:@"uid"];
    
    WBHttpRequest *hr0 = [WBHttpRequest requestWithURL:@"https://api.weibo.com/2/users/show.json" httpMethod:@"GET" params:dic delegate:self withTag:@"show"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)skinBtnPress:(id)sender {
}

#pragma mark - WBHttpRequest Delegate
-(void)request:(WBHttpRequest *)request didFailWithError:(NSError *)error
{
    
}

-(void)request:(WBHttpRequest *)request didFinishLoadingWithDataResult:(NSData *)data
{
    
    if ([request.tag isEqualToString:@"show"]) {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        NSString *headerURL = [dic objectForKey:@"avatar_hd"];
        NSURL *url = [NSURL URLWithString:headerURL];
        NSURLRequest *urlRequest = [NSURLRequest requestWithURL:url];
        NSURLConnection *connetion = [NSURLConnection connectionWithRequest:urlRequest delegate:self];
    }
}

-(void)request:(WBHttpRequest *)request didFinishLoadingWithResult:(NSString *)result
{
    
}

-(void)request:(WBHttpRequest *)request didReceiveResponse:(NSURLResponse *)response
{
    
}

#pragma mark - NSURLConnectionDelegate
-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    self.headerData = [NSMutableData data];
}

-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [self.headerData appendData:data];
}

-(void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    _headerImageView.image = [UIImage imageWithData:self.headerData];
}

-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    NSLog(@"didFailWithError！！%@",[error localizedDescription]);
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

- (void)dealloc {
    [_headerImageView release];
    [_groupTableView release];
    [super dealloc];
}
@end
