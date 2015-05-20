//
//  MDClassesViewController.m
//  MyDevelopmentTest
//
//  Created by hanyfeng on 15/2/16.
//  Copyright (c) 2015年 hanyfeng. All rights reserved.
//

#import "MDClassesViewController.h"
#import "MDTool.h"
#import "MDClassesTableViewCell.h"
@interface MDClassesViewController ()<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,strong)UITableView *tv;
@end

@implementation MDClassesViewController

#pragma mark - vc lifecycle
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self customInitUI];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.translucent = YES;
    self.tabBarController.tabBar.translucent = YES;
}

-(void)customInitUI
{
    UITableView *tv = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    [tv setBackgroundColor:[UIColor greenColor]];
    tv.delegate = self;
    tv.dataSource = self;
    [tv registerNib:[UINib nibWithNibName:@"MDClassesTableViewCell" bundle:nil]forCellReuseIdentifier:@"cell"];
    [self.view addSubview:tv];
}

#pragma mark - call back
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (self.isLastsetLayer == NO) {
        return self.data.count;
    }else{
        return 1;
    }
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(self.isLastsetLayer == NO){
        NSDictionary *dic = [self.data objectAtIndex:section];
        NSArray *sub = [dic objectForKey:@"sub"];
        return sub.count;
    }else{
        return self.data.count;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"cell";
    MDClassesTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (self.isLastsetLayer == NO) {
        NSDictionary *dic = [self.data objectAtIndex:indexPath.section];
        NSArray *sub = [dic objectForKey:@"sub"];
        NSDictionary *subDic = [sub objectAtIndex:indexPath.row];
        cell.dic = subDic;
    }else{
        NSDictionary *dic = [self.data objectAtIndex:indexPath.row];
        cell.dic = dic;
    }
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (self.isLastsetLayer == NO) {
        NSDictionary *dic = [self.data objectAtIndex:section];
        NSString *desc = [dic objectForKey:@"desc"];
        return desc;
    }else{
        return nil;
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.isLastsetLayer == NO) {
        NSDictionary *dic = [self.data objectAtIndex:indexPath.section];
        NSArray *sub = [dic objectForKey:@"sub"];
        NSDictionary *subDic = [sub objectAtIndex:indexPath.row];
        NSArray *subSub = [subDic objectForKey:@"sub"];
        NSString *subClassName = [subDic objectForKey:@"className"];
        if (subSub.count>0) {
            MDClassesViewController *cVC = [[MDClassesViewController alloc] init];
            cVC.data = subSub;
            cVC.isLastsetLayer = YES;
            [self.navigationController pushViewController:cVC animated:YES];
        }else{
            Class class = NSClassFromString(subClassName);
            if ([class isSubclassOfClass:[UIViewController class]]) {
                NSString *path = [[NSBundle mainBundle] pathForResource:subClassName ofType:@"nib"];
                UIViewController *instance = nil;
                
                if (path == nil || path.length == 0) {
                    instance = [[class alloc] init];
                }else{
                    instance = [[class alloc] initWithNibName:subClassName bundle:nil];
                }
                
                [self.navigationController pushViewController:instance animated:YES];
            }else{
                UIAlertView *av = [[UIAlertView alloc] initWithTitle:@"错误" message:@"没有相关类" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:nil];
                [av show];
            }
        }
    }else{
        NSDictionary *dic = [self.data objectAtIndex:indexPath.row];
        NSString *className = [dic objectForKey:@"className"];
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
