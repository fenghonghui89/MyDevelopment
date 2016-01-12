//
//  SelectViewController.m
//  PopoverViewSample
//
//  Created by 关东升 on 12-9-24.
//  本书网站：http://www.iosbook1.com
//  智捷iOS课堂：http://www.51work6.com
//  智捷iOS课堂在线课堂：http://v.51work6.com
//  智捷iOS课堂新浪微博：http://weibo.com/u/3215753973
//  作者微博：http://weibo.com/516inc
//  官方csdn博客：http://blog.csdn.net/tonny_guan
//  QQ：1575716557 邮箱：jylong06@163.com
//

#import "SelectViewController.h"

@interface SelectViewController ()

@end

@implementation SelectViewController

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
    
    self.listData = [[NSArray alloc] initWithObjects:@"红色",@"蓝色",@"黄色",@"关闭", nil];
    
}

-(void)showInfo{
    NSLog(@" 2 --- popoverVisible:%d",self.vc.poc.popoverVisible);
    if (self.vc.poc.popoverArrowDirection == UIPopoverArrowDirectionUp) {
        NSLog(@" 2 --- 方向朝上");
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark --UITableViewDataSource 协议方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.listData count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"CellIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    cell.textLabel.text =   [self.listData objectAtIndex:[indexPath row]];
    
    return cell;
}

#pragma mark --UITableViewDelegate 协议方法

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	//类似于折叠cell，改变当前选择和已被选择的cell的样式，再把当前选择的下标保存到属性
    
    if (indexPath.row == 3)
    {
        NSLog(@" 2 --- 关闭");
        [self.vc.poc dismissPopoverAnimated:YES];//不会回调关闭协议方法；不能self调用；dismiss后对象仍存在
    }
    
    else
    {
        NSInteger newRow = [indexPath row];
        
        NSInteger oldRow = (self.lastIndexPath != nil) ? [self.lastIndexPath row] : -1;
        
        if (newRow != oldRow) {
            UITableViewCell *newCell = [tableView cellForRowAtIndexPath:indexPath];
            newCell.accessoryType = UITableViewCellAccessoryCheckmark;
            
            UITableViewCell *oldCell = [tableView cellForRowAtIndexPath:self.lastIndexPath];
            oldCell.accessoryType = UITableViewCellAccessoryNone;
            
            self.lastIndexPath = indexPath;
            [self showInfo];
        }
    }
	   
}

@end
