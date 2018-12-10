//
//  TRViewController.m
//  my04
//
//  Created by HanyFeng on 13-11-11.
//  Copyright (c) 2013年 Hany. All rights reserved.
//

#import "TRViewController.h"

@interface TRViewController ()

@end

@implementation TRViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    //方法3：用组合+纯代码的方式创建tableView
    UITableView* secondTableView = [UITableView new];
    secondTableView.frame = CGRectMake(160, 0, 160, 200);
    secondTableView.delegate = self;
    secondTableView.dataSource = self;
    [self.view addSubview:secondTableView];
    
    //方法4：用内嵌的方式创建tableView
    TRTableViewController* thirdTableViewController = [TRTableViewController new];
    self.tableViewController = thirdTableViewController;//作用：引用thirdTableViewController，延长其生命周期
    thirdTableViewController.view.frame = CGRectMake(0, 200, 160, 200);
    [self.view addSubview:thirdTableViewController.view];

}

//方法2：用组合+nib的方式创建tableView
//在xib中直接拖入控件，协议方法手动写，注意delegate和dataSource连线，父view遵守协议
//如果数据源来自父view，且数据不断更新，要有reloadData
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    // Configure the cell...
    cell.textLabel.text = @"aaaa";
    return cell;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
