//
//  MD_TableView_VC.m
//  MyDevelopmentTest
//
//  Created by 冯鸿辉 on 16/3/24.
//  Copyright © 2016年 hanyfeng. All rights reserved.
//

#import "MD_TableView_VC.h"
#import "MD_Model2.h"
#import "ImageDownloader.h"
#import "MD_TableViewCell.h"

static NSString * const cellId = @"cell";

@interface MD_TableView_VC ()<UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate>
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)NSMutableArray *data;
@property(nonatomic,assign)CGRect previousPerRect;
@property(nonatomic,assign)BOOL bb;
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
  
  NSMutableArray *imagePaths = [NSMutableArray array];
  NSArray *arr = [htmlStr componentsSeparatedByString:@"\""];
  for (NSString *path in arr) {
    if ([path hasSuffix:@"jpg"] || [path hasSuffix:@"png"]) {
      [imagePaths addObject:path];
    }
  }
  
  NSMutableArray *images = [NSMutableArray array];
  for (NSString *path in imagePaths) {
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setObject:path forKey:@"imageUrl"];
    
    NSArray *arr = [path componentsSeparatedByString:@"/"];
    NSString *imageName = [arr lastObject];
    [dic setObject:imageName forKey:@"imageName"];
    
    [images addObject:dic];
  }
  
  NSMutableDictionary *dic = [NSMutableDictionary dictionary];
  [dic setObject:images forKey:@"images"];
  [dic setObject:@"2016-1-1" forKey:@"date"];
  NSData *data = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:nil];
  
  self.data = [MDImageItem handleData:data];
  
  for (NSString *path in imagePaths) {
    NSLog(@"p:%@",path);
  }
}

-(void)customInitUI{
  UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, viewW, viewH) style:UITableViewStyleGrouped];
  tableView.delegate = self;
  tableView.dataSource = self;
  [tableView setBackgroundColor:[UIColor orangeColor]];
  [self.view addSubview:tableView];
  self.tableView = tableView;
  
  [tableView registerNib:[UINib nibWithNibName:@"MD_TableViewCell" bundle:nil] forCellReuseIdentifier:cellId];
  
  UIBarButtonItem *rightButtomItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAction target:self action:@selector(rightBarButtonItemTap)];
  self.navigationItem.rightBarButtonItem = rightButtomItem;
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
//        NSLog(@"%@",str);
        [removeIndexPaths addObjectsFromArray:indexPaths];
      } addHandle:^(CGRect addRect) {
        NSArray *indexPaths = [self.tableView indexPathsForRowsInRect:addRect];
        NSString *str = @"add:\n";
        for (NSIndexPath *ip in indexPaths) {
          str = [str stringByAppendingString:[NSString stringWithFormat:@"%ld \n",(long)ip.row]];
        }
//        NSLog(@"%@",str);
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

#pragma mark cell image download
//判断可视的cell对应的数据源是否有image
-(void)loadImagesForOnscreenRows{
  
  NSArray *visibleCells = [self.tableView indexPathsForVisibleRows];
  
  for (NSIndexPath *indexPath in visibleCells) {
    MDImageItem *imageItem = [self.data objectAtIndex:indexPath.row];
    if (imageItem.image == nil) {
      [self startDownloadImage:imageItem indexPath:indexPath];
    }
  }
}

-(void)startDownloadImage:(MDImageItem *)imageItem indexPath:(NSIndexPath *)indexPath{

  [[ImageDownloader shareImageDownloader] startDownloadImage:imageItem.imageUrl complationHandle:^(UIImage *image) {
    
//    NSArray *visibleIndexPaths = [self.tableView indexPathsForVisibleRows];
//    BOOL isSet = NO;
//    for (NSIndexPath *visibleIndexPath in visibleIndexPaths) {
//      if (visibleIndexPath.row == indexPath.row) {
//        NSLog(@"放入缓存，加载图像");
//        
//        imageItem.image = image;
//        
//        MD_TableViewCell *cell = (MD_TableViewCell *)[self.tableView cellForRowAtIndexPath:indexPath];
//        cell.imageView_.image = image;
//        [cell layoutIfNeeded];
//        
//        isSet = YES;
//        
//        return;
//      }
//    }
//    
//    if (isSet == NO) {
//      imageItem.image = image;
//      NSLog(@"cell不在可视区域，缓存但不改变ui");
//    }
    imageItem.image = image;
    MD_TableViewCell *cell = (MD_TableViewCell *)[self.tableView cellForRowAtIndexPath:indexPath];
    cell.imageView_.image = image;
  }];
}

#pragma mark - < action > -
-(void)rightBarButtonItemTap{
  self.bb = !self.bb;
//    self.tableView.editing = !self.tableView.editing;
    
    //开启左边编辑 右边移动
    [self.tableView setEditing:!self.tableView.editing animated:YES];
}
#pragma mark - < callback > -
#pragma mark UITableView
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
  return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
  return self.data.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
  
  MD_TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId forIndexPath:indexPath];

  
  MDImageItem *imageItem = [self.data objectAtIndex:indexPath.row];
  cell.nameLabel.text = imageItem.imageName;
  cell.imageView_.image = [UIImage imageNamed:@"Algeria.png"];
  
  if (imageItem.image == nil) {
//    if (self.tableView.dragging == NO && self.tableView.decelerating == NO) {
////      NSLog(@"首次加载第一页 无缓存");
//      [self startDownloadImage:imageItem indexPath:indexPath];
//    }else{
////      NSLog(@"无缓存，还没停止或者手指还没离开屏幕，不操作");
//    }

//    [self startDownloadImage:imageItem indexPath:indexPath];
    
  }else{
    NSLog(@"有缓存");
    cell.imageView_.image = imageItem.image;
  }

  return cell;
}

#pragma mark UIScrollView
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
//  NSLog(@"~scrollViewDidScroll");
//  [self updataUI];
}

-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
  if (!decelerate) {
//    NSLog(@"~scrollViewDidEndDragging静止情况下手指离开屏幕");
//    [self loadImagesForOnscreenRows];
  }
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
//  NSLog(@"~scrollViewDidEndDecelerating手指离开后减速到0");
//  [self loadImagesForOnscreenRows];
}

#pragma mark - < 设置是否能编辑 默认可以 会首先返回 >
/*
 与editingStyleForRowAtIndexPath commitEditingStyle moveRowAtIndexPath 联动
 */
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
}

#pragma mark - < 左边编辑状态 >
//默认不写该方法是删除
//- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
//
////    return UITableViewCellEditingStyleDelete;//删除
////    return UITableViewCellEditingStyleInsert;//添加
//    return UITableViewCellEditingStyleDelete|UITableViewCellEditingStyleInsert;//多选
//}

////决定编辑状态下的Cell是否需要缩进
//-(BOOL)tableView:(UITableView *)tableView shouldIndentWhileEditingRowAtIndexPath:(NSIndexPath *)indexPath{
//    
//    return YES;
//}
//

//删除数据源和改列表数据要在下面的commitEditingStyle写


#pragma mark - < 右边移动位置 >
//-(void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath{
//
//}

#pragma mark - < 左滑删除 >

//编辑模式与单个左滑编辑下 删除或新增所做的动作 开启单个左滑删除
-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    // 从数据源中删除
    [_data removeObjectAtIndex:indexPath.row];
    // 从列表中删除
    [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    
}


//单个左滑动出现的文字
-(NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath{

    return @"删除~!";
}

//左滑动多个按钮 比上面的优先 ios8新增
-(NSArray<UITableViewRowAction *> *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewRowAction *deleteRowAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDestructive title:@"删除~" handler:^(UITableViewRowAction *action, NSIndexPath *indexPath) {
        NSLog(@"点击了删除");
    }];
    deleteRowAction.backgroundColor = [UIColor purpleColor];
   
    
    // 添加一个修改按钮
    UITableViewRowAction *moreRowAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleNormal title:@"修改~" handler:^(UITableViewRowAction *action, NSIndexPath *indexPath) {
        NSLog(@"点击了修改");
    }];
    
    //背景特效
    moreRowAction.backgroundEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
    
    
    /*
     最先放入数组的按钮显示在最右侧，最后放入的显示在最左侧
     如果我们自己设定了一个或多个按钮，系统自带的删除按钮就消失了
     */
    return @[deleteRowAction,moreRowAction];
}



#pragma mark - < 数据与ui更新 >
//看http://www.jianshu.com/p/f65ca53fc9ba




@end
