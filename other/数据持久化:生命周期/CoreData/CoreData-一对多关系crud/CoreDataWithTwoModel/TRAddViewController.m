//
//  TRAddViewController.m
//  CoreDataWithTwoModel
//
//  Created by hanyfeng on 14-8-25.
//  Copyright (c) 2014年 Tarena. All rights reserved.
//

#import "TRAddViewController.h"
#import "TRDataManager.h"
#import "Team.h"
@interface TRAddViewController ()
@property (weak, nonatomic) IBOutlet UITextField *nameTF;
@property (weak, nonatomic) IBOutlet UITextField *cityOrAgeTF;
@property (weak, nonatomic) IBOutlet UITextField *teamTF;

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *cityOrAgeLabel;
@property (weak, nonatomic) IBOutlet UILabel *teamLabel;

@end

@implementation TRAddViewController

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
    
    if (self.pageType == createNewTeam) {
        self.navigationItem.title = @"新增球队";
        self.cityOrAgeLabel.text = @"城市";
        [self.teamLabel setHidden:YES];
        [self.teamTF setHidden:YES];
    }
    
    if (self.pageType == changeTeam) {
        self.navigationItem.title = @"修改球队";
        self.cityOrAgeLabel.text = @"城市";
        self.nameTF.text = self.team.name;
        self.cityOrAgeTF.text = self.team.city;
        [self.teamLabel setHidden:YES];
        [self.teamTF setHidden:YES];
    }
    
    if (self.pageType == createNewPlayer) {
        self.navigationItem.title = @"新增队员";
        self.cityOrAgeLabel.text = @"年龄";
        self.teamTF.text = self.team.name;
    }
    
    if (self.pageType == changePlayer) {
        self.navigationItem.title = @"修改队员";
        self.cityOrAgeLabel.text = @"年龄";
        NSLog(@"-%@ %@ %@",self.player.name,[NSString stringWithFormat:@"%d",[self.player.age intValue]],self.player.team.name);
        self.nameTF.text = self.player.name;
        self.cityOrAgeTF.text = [NSString stringWithFormat:@"%d",[self.player.age intValue]];
        self.teamTF.text = self.player.team.name;
    }
}

- (IBAction)finish:(id)sender
{
    
    if (self.pageType == createNewTeam) {
        Team *team = [[Team alloc] init];
        team.name = self.nameTF.text;
        team.city = self.cityOrAgeTF.text;
        [[TRDataManager shareDataManager] creatTeamWithTeam:team];
    }
    
    if (self.pageType == changeTeam) {
        Team *team = [[Team alloc] init];
        team.name = self.nameTF.text;
        team.city = self.cityOrAgeTF.text;
        [[TRDataManager shareDataManager] changeTeamWithOldTeam:self.team andNewTeam:team];
    }
    
    if (self.pageType == createNewPlayer) {
        Player *player = [[Player alloc] init];
        player.name = self.nameTF.text;
        player.age = [NSNumber numberWithInt:[self.cityOrAgeTF.text intValue]];
        player.team = self.team;
        [[TRDataManager shareDataManager] creatPlayerWithPlayer:player];
    }
    
    if (self.pageType == changePlayer) {
        Player *player = [[Player alloc] init];
        player.name = self.nameTF.text;
        player.age = [NSNumber numberWithInt:[self.cityOrAgeTF.text intValue]];
        player.team = self.player.team;
        [[TRDataManager shareDataManager] changePlayerWithOldPlayer:self.player andNewPlayer:player];
    }
    
    [[NSNotificationCenter defaultCenter]postNotificationName:@"refreshData" object:nil];
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)cancle:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
