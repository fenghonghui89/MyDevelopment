//
//  MD_TableView_VC.m
//  MyDevelopmentTest
//
//  Created by 冯鸿辉 on 16/3/24.
//  Copyright © 2016年 hanyfeng. All rights reserved.
//

#import "MD_TableView_VC.h"

@interface MD_TableView_VC ()<UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate>
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)NSMutableArray *imagePaths;
@property (nonatomic,assign)CGRect previousPerRect;
@end

@implementation MD_TableView_VC

#pragma mark - < vc lifecycle > -
- (void)viewDidLoad {
  [super viewDidLoad];
  
}

-(void)viewDidAppear:(BOOL)animated{
  [super viewDidAppear:animated];
  
  [self customInitData];
  [self customInitUI];
}

#pragma mark - < method > -
#pragma mark customInit
-(void)customInitData{

  self.previousPerRect = CGRectZero;
  
  NSURL *url = [NSURL URLWithString:@"http://www.sina.com.cn"];
  NSError *error = nil;
  NSString *htmlStr = [[NSString alloc] initWithContentsOfURL:url encoding:NSUTF8StringEncoding error:&error];
  if (error) {
    NSLog(@"error:%@",[error localizedDescription]);
  }else{
    NSLog(@"解析成功");
  }
  
  self.imagePaths = [NSMutableArray array];
  NSArray *arr = [htmlStr componentsSeparatedByString:@"\""];
  for (NSString *path in arr) {
    if ([path hasSuffix:@"jpg"] || [path hasSuffix:@"png"]) {
      [self.imagePaths addObject:path];
    }
  }
}

-(void)customInitUI{
  UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, viewW, viewH) style:UITableViewStyleGrouped];
  tableView.delegate = self;
  tableView.dataSource = self;
  [tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
  [tableView setBackgroundColor:[UIColor orangeColor]];
  [self.view addSubview:tableView];
  self.tableView = tableView;
}

#pragma mark tableview lazy load
-(void)updataUI{
  
  BOOL isVisible = [self isViewLoaded];
  if (!isVisible) {
    return;
  }
  
  CGRect preRect = self.tableView.bounds;
  preRect = CGRectInset(preRect, 0, -0.5*CGRectGetHeight(preRect));
  
  CGFloat delta = ABS(CGRectGetMidY(self.previousPerRect)-CGRectGetMidY(preRect));{
    if (delta > CGRectGetHeight(self.tableView.bounds)*0.3) {
      NSMutableArray *removeIndexPaths = [NSMutableArray array];
      NSMutableArray *addIndexPaths = [NSMutableArray array];
      
      [self compareNewRect:preRect oldRect:self.previousPerRect removeHandle:^(CGRect removeRect) {
        NSArray *indexPaths = [self.tableView indexPathsForRowsInRect:removeRect];
        NSString *str = @"remove:\n";
        for (NSIndexPath *ip in indexPaths) {
          str = [str stringByAppendingString:[NSString stringWithFormat:@"%ld \n",(long)ip.row]];
        }
        NSLog(@"%@",str);
        [removeIndexPaths addObjectsFromArray:indexPaths];
      } addHandle:^(CGRect addRect) {
        NSArray *indexPaths = [self.tableView indexPathsForRowsInRect:addRect];
        NSString *str = @"add:\n";
        for (NSIndexPath *ip in indexPaths) {
          str = [str stringByAppendingString:[NSString stringWithFormat:@"%ld \n",(long)ip.row]];
        }
        NSLog(@"%@",str);
        [addIndexPaths addObjectsFromArray:indexPaths];
        
      }];
      
      self.previousPerRect = preRect;
    }
  }
  
}

-(void)compareNewRect:(CGRect)newRect oldRect:(CGRect)oldRect removeHandle:(void(^)(CGRect removeRect))removeHandle addHandle:(void(^)(CGRect addRect))addHandle{
  
  if(CGRectIntersectsRect(newRect, oldRect))
  {
    CGFloat newMaxY = CGRectGetMaxY(newRect);
    CGFloat newMinY = CGRectGetMinY(newRect);
    CGFloat oldMaxY = CGRectGetMaxY(oldRect);
    CGFloat oldMinY = CGRectGetMinY(oldRect);
    
    if (newMinY > oldMinY) {//下滚
      CGRect rectToRemove = CGRectMake(oldRect.origin.x, oldMinY, oldRect.size.width, (newMinY-oldMinY));
      removeHandle(rectToRemove);
    }
    
    if (newMinY < oldMinY) {//初始 回滚
      CGRect rectToAdd = CGRectMake(newRect.origin.x, newMinY, newRect.size.width, oldMinY-newMinY);
      addHandle(rectToAdd);
    }
    
    if (newMaxY > oldMaxY) {//初始 下滚
      CGRect rectToAdd = CGRectMake(newRect.origin.x, oldMaxY, oldRect.size.width, newMaxY-oldMaxY);
      addHandle(rectToAdd);
    }
    
    if (newMaxY < oldMaxY) {//回滚
      CGRect rectToRemove = CGRectMake(newRect.origin.x, newMaxY, newRect.size.width, oldMaxY - newMaxY);
      removeHandle(rectToRemove);
    }
  }
  else
  {
    addHandle(newRect);
    removeHandle(oldRect);
  }
}
#pragma mark - < action > -

#pragma mark - < callback > -
#pragma mark UITableView
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
  return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
  return 30;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
  static NSString *identifier = @"cell";
  UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
  if (!cell) {
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
  }
  cell.textLabel.text = [NSString stringWithFormat:@"%ld %ld",(long)indexPath.section,(long)indexPath.row];
  return cell;
}

#pragma mark UIScrollView
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
  [self updataUI];
}

@end
