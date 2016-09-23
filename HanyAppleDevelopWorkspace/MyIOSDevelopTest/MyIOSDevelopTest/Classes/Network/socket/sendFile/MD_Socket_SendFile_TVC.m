//
//  MD_Socket_SendFile_TVC.m
//  MyDevelopmentTest
//
//  Created by 冯鸿辉 on 16/3/29.
//  Copyright © 2016年 hanyfeng. All rights reserved.
//

#import "MD_Socket_SendFile_TVC.h"

@interface MD_Socket_SendFile_TVC ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property(nonatomic,strong)NSMutableArray *dataArray;
@end

@implementation MD_Socket_SendFile_TVC

#pragma mark - < vc lifecycle > -
- (void)viewDidLoad {
  [super viewDidLoad];
}

-(void)viewDidAppear:(BOOL)animated{
  [super viewDidAppear:animated];
  
  [self customInitData];
  [self customInitUI];
  
  [self.tableView reloadData];
}

#pragma mark - < method > -
-(void)customInitData{
  
  self.dataArray = [NSMutableArray array];
  
  NSString *path = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
  path = [path stringByAppendingPathComponent:@"testDir"];
  
  NSFileManager *fm = [NSFileManager defaultManager];
  BOOL b;
  if ([fm fileExistsAtPath:path isDirectory:&b]) {
    NSError *error = nil;
    NSArray *fileNames = [fm contentsOfDirectoryAtPath:path error:&error];
    if (error) {
      NSLog(@"error:%@",[error localizedDescription]);
    }else{
      for (NSString *fileName in fileNames) {
        NSString *filePath = [path stringByAppendingPathComponent:fileName];
        [self.dataArray addObject:filePath];
      }
    }
  }
}

-(void)customInitUI{
  
  self.tableView.dataSource = self;
  self.tableView.delegate = self;
}

#pragma mark - < callbakc > -
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
  NSInteger count = self.dataArray.count;
  return count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
  
  static NSString *cellId = @"cellId";
  UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
  if (!cell) {
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
  }
  
  NSString *filePath = self.dataArray[indexPath.row];
  UIImage *img = [UIImage imageWithContentsOfFile:filePath];
  cell.imageView.image = img;
  return cell;
}
@end
