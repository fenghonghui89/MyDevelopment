//
//  MDSearchBarViewController.m
//  MyDevelopmentTest
//
//  Created by hanyfeng on 15/3/4.
//  Copyright (c) 2015年 hanyfeng. All rights reserved.
//

#import "MDSearchBarViewController.h"
@interface MDSearchBarViewController ()<UITableViewDataSource,UITableViewDelegate,UISearchBarDelegate, UISearchDisplayDelegate>
@property (nonatomic, strong) NSArray *listTeams;
@property (nonatomic, strong) NSMutableArray *listFilterTeams;
@property (nonatomic, strong) UISearchBar *searchBar;
@end

@implementation MDSearchBarViewController

#pragma mark - vc lifecycle
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self customInitData];
    [self customInitUI];
}

-(void)customInitData
{
    NSBundle *bundle = [NSBundle mainBundle];
    NSString *plistPath = [bundle pathForResource:@"team" ofType:@"plist"];
    self.listTeams = [[NSArray alloc] initWithContentsOfFile:plistPath];
    
    //初次进入查询所有数据
    [self filterContentForSearchText:@"" scope:-1];
}

-(void)customInitUI
{
    UITableView *tv = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    tv.delegate = self;
    tv.dataSource = self;
    [self.view addSubview:tv];
    
    UISearchBar *searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, screenW, 44)];
    [searchBar setShowsScopeBar:NO];
    [searchBar setScopeButtonTitles:@[@"中文",@"英文"]];
    [searchBar setPlaceholder:@"Search for Name"];
    [searchBar setShowsSearchResultsButton:YES];
    [searchBar sizeToFit];
    [searchBar setDelegate:self];
    [tv addSubview:searchBar];
    self.searchBar = searchBar;
}

#pragma mark - action
#pragma mark Content Filtering
//searchText-搜索内容 scope-搜索选项（0：英文 1：中文 其他：全部）
- (void)filterContentForSearchText:(NSString*)searchText scope:(NSUInteger)scope;
{
    
    if([searchText length]==0)
    {
        //查询所有
        self.listFilterTeams = [NSMutableArray arrayWithArray:self.listTeams];
        return;
    }
    
    NSPredicate *scopePredicate;
    NSArray *tempArray ;
    
    switch (scope) {
        case 0: //英文
            scopePredicate = [NSPredicate predicateWithFormat:@"SELF.name contains[c] %@",searchText];
            tempArray =[self.listTeams filteredArrayUsingPredicate:scopePredicate];
            self.listFilterTeams = [NSMutableArray arrayWithArray:tempArray];
            
            break;
        case 1://中文
            scopePredicate = [NSPredicate predicateWithFormat:@"SELF.image contains[c] %@",searchText];
            tempArray =[self.listTeams filteredArrayUsingPredicate:scopePredicate];
            self.listFilterTeams = [NSMutableArray arrayWithArray:tempArray];
            
            break;
        default:
            //查询所有
            self.listFilterTeams = [NSMutableArray arrayWithArray:self.listTeams];
            break;
    }
}

#pragma mark - callback
#pragma mark tableview
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.listFilterTeams count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"CellIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    
    
    NSUInteger row = [indexPath row];
    NSDictionary *rowDict = [self.listFilterTeams objectAtIndex:row];
    cell.textLabel.text =  [rowDict objectForKey:@"name"];
    cell.detailTextLabel.text = [rowDict objectForKey:@"image"];
    
    NSString *imagePath = [rowDict objectForKey:@"image"];
    imagePath = [imagePath stringByAppendingString:@".png"];
    cell.imageView.image = [UIImage imageNamed:imagePath];
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    return cell;
}
#pragma mark searchBar
#pragma mark -UISearchBarDelegate 协议方法
- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    //查询所有
    [self filterContentForSearchText:@"" scope:-1];
}

-(void)searchBar:(UISearchBar *)searchBar selectedScopeButtonIndexDidChange:(NSInteger)selectedScope
{
    NSLog(@"");
}

#pragma mark -UISearchDisplayController Delegate Methods
//当文本内容发生改变时候，向表视图数据源发出重新加载消息
- (BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString
{
    [self filterContentForSearchText:searchString scope:self.searchBar.selectedScopeButtonIndex];
    
    //YES情况下表视图可以重新加载
    return YES;
}

// 当Scope Bar的选择发生变化时候，向表视图数据源发出重新加载消息
- (BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchScope:(NSInteger)searchOption
{
    [self filterContentForSearchText:self.searchBar.text scope:searchOption];
    
    // YES情况下表视图可以重新加载
    return YES;
}

@end
