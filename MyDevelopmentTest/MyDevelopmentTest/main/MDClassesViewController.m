//
//  MDClassesViewController.m
//  MyDevelopmentTest
//
//  Created by hanyfeng on 15/2/16.
//  Copyright (c) 2015年 hanyfeng. All rights reserved.
//

#import "MDClassesViewController.h"
#import "MDRootDefine.h"
#import "MDClassesTableViewCell.h"
@interface MDClassesViewController ()<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,strong)UIView *bgView;
@property(nonatomic,strong)UITableView *tv;
@end

@implementation MDClassesViewController

#pragma mark - < vc lifecycle > -
- (void)viewDidLoad
{
  [super viewDidLoad];
}

-(void)viewDidAppear:(BOOL)animated
{
  [super viewDidAppear:animated];
  
  [self customInitUI];
  DLog(@"默认screen%@",NSStringFromCGSize([[UIScreen mainScreen] bounds].size));
  DLog(@"默认navi%@",NSStringFromCGSize(self.navigationController.navigationBar.bounds.size));
  DLog(@"默认view%@",NSStringFromCGRect(self.view.frame));
  DLog(@"默认bgview%@",NSStringFromCGRect(self.bgView.frame));
  
  NSLog(@"1%d",1);
}

#pragma mark - < method > -
#pragma mark 旋屏
-(BOOL)shouldAutorotate
{
  return YES;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations
{
  return UIInterfaceOrientationMaskPortrait;
}
#pragma mark customInit
-(void)customInitUI
{
  //navi
  self.navigationController.navigationBar.translucent = YES;
  self.navigationController.navigationBar.backgroundColor = [UIColor yellowColor];
  self.navigationController.navigationBar.barTintColor = nil;
  
  //tabbar
  self.tabBarController.tabBar.translucent = NO;
  
  //self.view
  self.view.backgroundColor = [UIColor blueColor];

  
  //bgView
  UIView *bgView = [[UIView alloc] init];
  [bgView setBackgroundColor:[UIColor redColor]];
  CGFloat bgViewY = 0;
  CGFloat bgViewW = viewW;
  CGFloat bgViewH = 0;
  CGFloat systemVersion = [[[UIDevice currentDevice] systemVersion] floatValue];
  if (systemVersion < 7.0) {
    bgViewY = naviH;
    bgViewH = viewH - naviH;
  }else{
    bgViewY = stateH + naviH;
    bgViewH = viewH - stateH - naviH;
  }
  [bgView setFrame:[MDTool setRectX:0 y:bgViewY w:bgViewW h:bgViewH]];
  [self.view addSubview:bgView];
  self.bgView = bgView;
  
  //tv
  UITableView *tv = [[UITableView alloc] initWithFrame:[MDTool setRectX:0 y:0 w:bgViewW h:bgViewH] style:UITableViewStyleGrouped];
  [tv setBackgroundColor:[UIColor greenColor]];
  tv.delegate = self;
  tv.dataSource = self;
  [tv registerNib:[UINib nibWithNibName:@"MDClassesTableViewCell" bundle:nil]forCellReuseIdentifier:@"cell"];
  [bgView addSubview:tv];
}

#pragma mark - call back
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
  /*
   判断数据源所有元素是否有className
   如果其中一个有className，代表是最下层
   都没有classname则代表不是最下层
   */
  
  BOOL b = NO;
  for (NSDictionary *dic in self.data) {
    NSString *className = [dic objectForKey:@"className"];
    if (![className isEqualToString:@""]) {
      b = YES;
      break;
    }
  }
  
  if (b == NO) {
    return self.data.count;
  }else{
    return 1;
  }
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
  BOOL b = NO;
  for (NSDictionary *dic in self.data) {
    NSString *className = [dic objectForKey:@"className"];
    if (![className isEqualToString:@""]) {
      b = YES;
      break;
    }
  }
  
  if(b == NO){
    NSDictionary *firstDic = [self.data objectAtIndex:section];
    NSArray *firstSub = [firstDic objectForKey:@"sub"];
    return firstSub.count;
  }else{
    return self.data.count;
  }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
  static NSString *identifier = @"cell";
  MDClassesTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
  
  BOOL b = NO;//yes最下层 no不是最下层
  for (NSDictionary *dic in self.data) {
    NSString *className = [dic objectForKey:@"className"];
    if (![className isEqualToString:@""]) {
      b = YES;
      break;
    }
  }
  
  if (b == NO) {
    NSDictionary *firstDic = [self.data objectAtIndex:indexPath.section];
    NSArray *firstSub = [firstDic objectForKey:@"sub"];
    NSDictionary *secondDic = [firstSub objectAtIndex:indexPath.row];
    cell.dic = secondDic;
  }else{
    NSDictionary *firstDic = [self.data objectAtIndex:indexPath.row];
    cell.dic = firstDic;
  }
  
  return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
  return 50;
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
  BOOL b = NO;//yes最下层 no不是最下层
  for (NSDictionary *dic in self.data) {
    NSString *className = [dic objectForKey:@"className"];
    if (![className isEqualToString:@""]) {
      b = YES;
      break;
    }
  }
  
  if(b == NO){
    NSDictionary *firstDic = [self.data objectAtIndex:section];
    NSString *firstDesc = [firstDic objectForKey:@"desc"];
    return firstDesc;
  }else{
    return @"最下层";
  }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
  MDClassesTableViewCell *cell = (MDClassesTableViewCell *)[tableView cellForRowAtIndexPath:indexPath];
  NSArray *sub = [cell.dic objectForKey:@"sub"];
  
  if(sub.count > 0){
    MDClassesViewController *cVC = [[MDClassesViewController alloc] init];
    cVC.data = [cell.dic objectForKey:@"sub"];
    cVC.title = [cell.dic objectForKey:@"desc"];
    [self.navigationController pushViewController:cVC animated:YES];
  }else{
    NSString *className = [cell.dic objectForKey:@"className"];
    Class class = NSClassFromString(className);
    if ([class isSubclassOfClass:[UIViewController class]]) {
      NSString *path = [[NSBundle mainBundle] pathForResource:className ofType:@"nib"];
      UIViewController *instance = nil;
      
      if (path == nil || path.length == 0) {
        instance = [[class alloc] init];
      }else{
        instance = [[class alloc] initWithNibName:className bundle:nil];
      }
      
      [self.navigationController pushViewController:instance animated:YES];
    }else{
      UIAlertView *av = [[UIAlertView alloc] initWithTitle:@"错误" message:@"没有相关类" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:nil];
      [av show];
    }
    
  }
}
@end
