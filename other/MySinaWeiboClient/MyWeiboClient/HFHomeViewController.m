//
//  HFHomeViewController.m
//  MyWeiboClient
//
//  Created by hanyfeng on 14-9-2.
//  Copyright (c) 2014年 hanyfeng. All rights reserved.
//

#import "HFHomeViewController.h"
#import "HFSendWeiboViewController.h"
#import "HFMenuViewController.h"
#import "HFNavigationController.h"
#import "SliderViewController.h"
#import "WeiBoTableViewCell.h"
#import "WeiboSDK.h"
#import "HFButton.h"

@interface HFHomeViewController ()<WBHttpRequestDelegate,UITableViewDataSource,UITabBarDelegate>
@property(nonatomic,retain)NSMutableArray *weibos;
@property(nonatomic,retain)UILabel *nameLabel;
@end

@implementation HFHomeViewController



#pragma mark -vc生命周期
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.weibos = [NSMutableArray array];
    
#pragma mark --navi设置
    self.navigationItem.title = @"全部微博";
    
    UILabel *nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(30, 5, 55, 34)];
    [nameLabel setTextColor:[UIColor whiteColor]];
    [nameLabel setBackgroundColor:[UIColor redColor]];
    [nameLabel setFont:[UIFont systemFontOfSize:13]];
    [self.navigationController.navigationBar addSubview:nameLabel];
    self.nameLabel = nameLabel;
    [nameLabel release];
    
    HFButton *toMenuVCBtn = [[HFButton alloc] initWithFrame:CGRectMake(5, 5, 20, 34) andImageName:@"tabbar_more.png" andHImageName:@"tabbar_more_highlighted.png"];
    [toMenuVCBtn addTarget:self action:@selector(toMenuVCBtnPress) forControlEvents:UIControlEventTouchUpInside];
    [self.navigationController.navigationBar addSubview:toMenuVCBtn];
    [toMenuVCBtn release];
    
    HFButton *toSendWeiboVCBtn = [[HFButton alloc] initWithFrame:CGRectMake(UIScreen_Width - 20 - 5, 5, 20, 34) andImageName:@"tabbar_more.png" andHImageName:@"tabbar_more_highlighted.png"];
    [toSendWeiboVCBtn addTarget:self action:@selector(toSendWeiboVCBtnPress) forControlEvents:UIControlEventTouchUpInside];
    [self.navigationController.navigationBar addSubview:toSendWeiboVCBtn];
    
#pragma mark --网络请求
    
    UserInfo *userInfo = [[CoreDataSettingManager shareManager] findSettingWithOption:@"userInfo"];
    
    //全部微博
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setValue:userInfo.access_token forKey:@"access_token"];
    [dic setValue:[NSString stringWithFormat:@"%d",1] forKey:@"count"];
    
    WBHttpRequest *hr = [WBHttpRequest requestWithURL:@"https://api.weibo.com/2/statuses/home_timeline.json" httpMethod:@"GET" params:dic delegate:self withTag:@"timeline"];
    
    //个人信息
    NSMutableDictionary *dic1 = [NSMutableDictionary dictionary];
    [dic1 setValue:userInfo.access_token forKey:@"access_token"];
    [dic1 setValue:userInfo.uid forKey:@"uid"];
    
    WBHttpRequest *hr1 = [WBHttpRequest requestWithURL:@"https://api.weibo.com/2/users/show.json" httpMethod:@"GET" params:dic1 delegate:self withTag:@"show"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - actions
-(void)toMenuVCBtnPress
{
    [[SliderViewController sharedSliderController] showLeftViewController];
}

-(void)toSendWeiboVCBtnPress
{
    HFSendWeiboViewController *sendWeiboVC = [[HFSendWeiboViewController alloc] init];
    HFNavigationController *navi = [[HFNavigationController alloc] initWithRootViewController:sendWeiboVC];
    [self presentViewController:navi animated:YES completion:nil];
    [sendWeiboVC release];
//    HFSendWeiboViewController *sendWeiboVC = [[HFSendWeiboViewController alloc] init];
//    [self.navigationController pushViewController:sendWeiboVC animated:YES];
//    self.navigationController.hidesBottomBarWhenPushed = YES;
}

#pragma mark - Table view data source

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    Weibo *weibo = [self.weibos objectAtIndex:indexPath.row];
    return [weibo getWeiboCellHeight];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.weibos.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"cell";
    WeiBoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[WeiBoTableViewCell alloc] init];
    }
    
    Weibo *weibo = self.weibos[indexPath.row];
    cell.weibo = weibo;
    
    return cell;
}

#pragma mark - WBHttpRequest Delegate
-(void)request:(WBHttpRequest *)request didFailWithError:(NSError *)error
{
    
}

-(void)request:(WBHttpRequest *)request didFinishLoadingWithDataResult:(NSData *)data
{
    
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
    
    /*
     解析json数据到model
     构建数据源
     reloadData
     */
    if ([request.tag isEqualToString:@"timeline"]) {
        NSArray *weiboDics = [dic objectForKey:@"statuses"];
        for (NSDictionary *weiboDic in weiboDics) {
            Weibo *weibo = [WeiBoParser getWeiboByParserWithData:weiboDic];
            [self.weibos addObject:weibo];
        }
        
        [self.tableView reloadData];
    }
    
    if ([request.tag isEqualToString:@"show"]) {
        NSString *userName = [dic objectForKey:@"screen_name"];
        userName = [userName stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        [self.nameLabel setText:userName];
    }
    
}

-(void)request:(WBHttpRequest *)request didFinishLoadingWithResult:(NSString *)result
{
    
}

-(void)request:(WBHttpRequest *)request didReceiveResponse:(NSURLResponse *)response
{

}


/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

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
