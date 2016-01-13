//
//  TRTeamTableViewController.m
//  CoreDataWithTwoModel
//
//  Created by hanyfeng on 14-8-25.
//  Copyright (c) 2014年 Tarena. All rights reserved.
//

#import "TRTeamTableViewController.h"
#import "TRPlayerTableViewController.h"
#import "Team.h"
#import "TRDataManager.h"
#import "TRAddViewController.h"

@interface TRTeamTableViewController ()
@property(nonatomic,strong)NSArray *teams;
@end

@implementation TRTeamTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.teams = [[TRDataManager shareDataManager] findAllTeams];
    
    UIBarButtonItem *leftbtn = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addTeam)];
    self.navigationItem.leftBarButtonItem = leftbtn;

    self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    self.navigationItem.title = @"球队";
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshData) name:@"refreshData" object:nil];
}

-(void)refreshData
{
    self.teams = [[TRDataManager shareDataManager] findAllTeams];
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

-(void)addTeam
{
    TRAddViewController *avc = [[TRAddViewController alloc] initWithNibName:@"TRAddViewController" bundle:nil];
    avc.pageType = createNewTeam;
    [self.navigationController pushViewController:avc animated:YES];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.teams.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
    }
    
    Team *team = [self.teams objectAtIndex:indexPath.row];
    cell.textLabel.text = team.name;
    cell.detailTextLabel.text = team.city;
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //跳转到队员列表
    TRPlayerTableViewController *pvc = [[TRPlayerTableViewController alloc] init];
    Team *team = [self.teams objectAtIndex:indexPath.row];
    pvc.team = team;
    [self.navigationController pushViewController:pvc animated:YES];
    
    //修改
//    Team *team = [self.teams objectAtIndex:indexPath.row];
//    TRAddViewController *avc = [[TRAddViewController alloc] initWithNibName:@"TRAddViewController" bundle:nil];
//    avc.pageType = changeTeam;
//    avc.team = team;
//    [self.navigationController pushViewController:avc animated:YES];
}


- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        Team *team = [self.teams objectAtIndex:indexPath.row];
        [[TRDataManager shareDataManager] deleteTeamWithTeam:team];
        self.teams = [[TRDataManager shareDataManager] findAllTeams];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }
}

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
