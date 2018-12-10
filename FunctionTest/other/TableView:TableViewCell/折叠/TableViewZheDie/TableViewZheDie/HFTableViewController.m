//
//  HFViewController.m
//  TableViewZheDie
//
//  Created by hanyfeng on 14-4-3.
//  Copyright (c) 2014年 hanyfeng. All rights reserved.
//

#import "HFTableViewController.h"
#define originalHeight 25.0f//原始高度
#define newHeight 85.0f//展开高度
#define isOpen @"85.0f"

@interface HFTableViewController ()
@end

@implementation HFTableViewController
{
    NSMutableDictionary *dicClicked;
    NSInteger count;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
	count = 0;
    dicClicked = [NSMutableDictionary dictionaryWithCapacity:3];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 50;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //每个section的第一个cell显示内容
    static NSString *contentIndentifer = @"Container";
    if (indexPath.row == 0) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:contentIndentifer];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:contentIndentifer];
        }
        
        NSString *statisticsContent = @"rlf:岁月流芳，花开几度，走在岁月里，醉在流香里，总在时光里辗转徘徊。花开几许，落花几度，岁月寒香，飘进谁的诗行，一抹幽香，掺入几许愁伤，流年似花，春来秋往，睁开迷离的双眼，回首张望，随风的尘烟荡漾着迷忙，昨日的光阴已逝去，留下无尽的回忆让人留恋与追忆";
        
        cell.textLabel.font = [UIFont systemFontOfSize:12.0f];
        cell.textLabel.text = statisticsContent;
        cell.textLabel.textColor = [UIColor brownColor];
        
        cell.textLabel.opaque = NO; // 选中Opaque表示视图后面的任何内容都不应该绘制--cell更有立体感
        cell.textLabel.numberOfLines = 8;
        cell.selectionStyle = UITableViewCellSelectionStyleBlue;
        
        return cell;
    }
    
    //每个section的第二个cell显示心
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    cell.imageView.image = [UIImage imageNamed:@"ic_milestone_heart.png"];
    cell.textLabel.text = [NSString stringWithFormat:@"%d",count];
    
    count++;
    
    return cell;
}

#pragma mark row高度（局部刷新row会进入到这个方法）
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //如果是内容cell所在的row，则判断是折叠还是展开状态，然后返回对应的高度
    if (indexPath.row == 0) {
        
        if ([[dicClicked objectForKey:indexPath] isEqualToString: isOpen])
            return [[dicClicked objectForKey:indexPath] floatValue];
        else
            return originalHeight;
    
    }else {//如果是其他cell，则返回其他值
        return 45.0f;
    }

}

#pragma mark Section的标题栏高度
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0)
        return 100;
    else
        return 30.0f;
}

#pragma mark section头部view
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    CGRect headerFrame = CGRectMake(0, 0, 300, 30);
    CGFloat y = 2;
    
    if (section == 0) {
        headerFrame = CGRectMake(0, 0, 300, 30);
        y = 20;
    }
    
    UIView *headerView = [[UIView alloc] initWithFrame:headerFrame];
    
    //左边的日期标签
    UILabel *dateLabel=[[UILabel alloc] initWithFrame:CGRectMake(20, y, 240, 24)];
    dateLabel.font=[UIFont boldSystemFontOfSize:16.0f];
    dateLabel.textColor = [UIColor darkGrayColor];
    dateLabel.backgroundColor=[UIColor clearColor];
    [headerView addSubview:dateLabel];
    
    //右边的年龄标签
    UILabel *ageLabel=[[UILabel alloc] initWithFrame:CGRectMake(216, y, 88, 24)];
    ageLabel.font=[UIFont systemFontOfSize:14.0];
    ageLabel.textAlignment = NSTextAlignmentRight;
    ageLabel.textColor = [UIColor darkGrayColor];
    ageLabel.backgroundColor=[UIColor clearColor];
    [headerView addSubview:ageLabel];
    
    //日期格式
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"MM dd,yyyy";
    dateLabel.text = [NSString stringWithFormat:@"%@",[dateFormatter stringFromDate:[NSDate date]]];
    ageLabel.text = @"1岁 2天";
    
    return headerView;
}

#pragma mark - Table view delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //如果点击的是内容cell
    if (indexPath.row == 0) {
    
        //取到这个cell
        UITableViewCell *targetCell = [tableView cellForRowAtIndexPath:indexPath];
        
        //判断cell的高度是展开还是折叠，折叠则加入到字典，否则从字典中去除
        if (targetCell.frame.size.height == originalHeight){
            [dicClicked setObject:isOpen forKey:indexPath];
        }
        else{
            [dicClicked removeObjectForKey:indexPath];
        }
        
        //局部刷新row：需要刷新的下标集合（数组）,动画效果
        [self.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath, nil] withRowAnimation:UITableViewRowAnimationLeft];
    }
    
    NSLog(@"indexPath=%@",indexPath);
    NSLog(@"dicClicked=%@",dicClicked);
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
