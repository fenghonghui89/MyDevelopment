//
//  TRDataManager.m
//  CoreDataWithTwoModel
//
//  Created by hanyfeng on 14-8-25.
//  Copyright (c) 2014年 Tarena. All rights reserved.
//

#import "TRDataManager.h"


@implementation TRDataManager

static TRDataManager *shareDataManager = nil;
+(TRDataManager *)shareDataManager
{
    static dispatch_once_t oncePath;
    dispatch_once(&oncePath, ^{
        shareDataManager = [[self alloc] init];
        [shareDataManager managedObjectContext];
    });
    return shareDataManager;
}

#pragma mark - team
-(void)creatTeamWithTeam:(Team *)paramTeam
{
    Team_MO *team_MO = [self findTeamWithTeam:paramTeam];
    
    if (team_MO == nil) {
        team_MO = [NSEntityDescription insertNewObjectForEntityForName:@"Team_MO" inManagedObjectContext:self.managedObjectContext];
        team_MO.name = paramTeam.name;
        team_MO.city = paramTeam.city;
    }else{
        UIAlertView *av = [[UIAlertView alloc] initWithTitle:@"出错" message:@"已存在同名球队" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [av show];
        return;
    }
    
    [self saveContext];
}

-(void)deleteTeamWithTeam:(Team *)paramTeam
{
    Team_MO *team_MO = nil;
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    [fetchRequest setEntity:[NSEntityDescription entityForName:@"Team_MO" inManagedObjectContext:self.managedObjectContext]];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"name == %@",paramTeam.name];
    [fetchRequest setPredicate:predicate];
    
    NSError *error = nil;
    NSArray *teams_MO = [self.managedObjectContext executeFetchRequest:fetchRequest error:&error];
    if ([teams_MO count] > 0) {
        team_MO = [teams_MO lastObject];
        [self.managedObjectContext deleteObject:team_MO];
    }
    
    [self saveContext];
}

-(void)changeTeamWithOldTeam:(Team *)paramOldTeam andNewTeam:(Team *)paramNewTeam
{
    Team_MO *newTeam_MO = [self findTeamWithTeam:paramNewTeam];
    if (newTeam_MO != nil) {
        UIAlertView *av = [[UIAlertView alloc] initWithTitle:@"出错" message:@"已存在同名球队" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [av show];
        return;
    }
    Team_MO *team_MO = [self findTeamWithTeam:paramOldTeam];
    team_MO.name = paramNewTeam.name;
    team_MO.city = paramNewTeam.city;
    [self saveContext];
}

-(Team_MO *)findTeamWithTeam:(Team *)paramTeam
{
    Team_MO *team_MO = nil;
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    [fetchRequest setEntity:[NSEntityDescription entityForName:@"Team_MO" inManagedObjectContext:self.managedObjectContext]];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"name == %@",paramTeam.name];
    [fetchRequest setPredicate:predicate];
    [fetchRequest setFetchLimit:1];
    
    NSError *error = nil;
    NSArray *teams_MO = [self.managedObjectContext executeFetchRequest:fetchRequest error:&error];
    if ([teams_MO count] > 0) {
        team_MO = [teams_MO lastObject];
    }
    
    return team_MO;
}

-(NSArray *)findAllTeams
{
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    [fetchRequest setEntity:[NSEntityDescription entityForName:@"Team_MO" inManagedObjectContext:self.managedObjectContext]];
    
    NSSortDescriptor *sortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"name"ascending:YES];
    [fetchRequest setSortDescriptors:@[sortDescriptor]];
    
    NSError *error = nil;
    NSArray *teams_MO = [self.managedObjectContext executeFetchRequest:fetchRequest error:&error];
    
    NSMutableArray *teams = [NSMutableArray array];
    for (Team_MO *team_MO in teams_MO) {
        Team *team = [[Team alloc] init];
        team.name = team_MO.name;
        team.city = team_MO.city;
        [teams addObject:team];
    }
    
    return teams;
}

#pragma mark - player
-(void)creatPlayerWithPlayer:(Player *)paramPlayer
{
    
    Player_MO *player_MO = nil;
    player_MO = [self findPlayerWithPlayer:paramPlayer];
    
    if (player_MO == nil) {
        player_MO = [NSEntityDescription insertNewObjectForEntityForName:@"Player_MO" inManagedObjectContext:self.managedObjectContext];
        player_MO.name = paramPlayer.name;
        player_MO.age = paramPlayer.age;
        player_MO.team_MO = [self findTeamWithTeam:paramPlayer.team];
        //或者
        //    Team_MO *team_MO = [self findTeamWithTeam:paramPlayer.team];
        //    [team_MO addPlayers_MOObject:player_MO];
    }else{
        UIAlertView *av = [[UIAlertView alloc] initWithTitle:@"出错" message:@"已存在同名队员" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [av show];
        return;
    }
    
    [self saveContext];
}

-(void)deletePlayerWithPlay:(Player *)paramPlayer
{
    Player_MO *player_MO = nil;
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    [fetchRequest setEntity:[NSEntityDescription entityForName:@"Player_MO" inManagedObjectContext:self.managedObjectContext]];
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"team_MO == %@ AND name == %@",[self findTeamWithTeam:paramPlayer.team],paramPlayer.name];
    [fetchRequest setPredicate:predicate];
    [fetchRequest setFetchLimit:1];
    
    NSError *error = nil;
    NSArray *players_MO = [self.managedObjectContext executeFetchRequest:fetchRequest error:&error];
    if (players_MO.count > 0) {
        player_MO = [players_MO lastObject];
        [self.managedObjectContext deleteObject:player_MO];
    }
    
    [self saveContext];
}

-(void)changePlayerWithOldPlayer:(Player *)paramOldPlayer andNewPlayer:(Player *)paramNewPlayer
{
    Player_MO *player_MO = [self findPlayerWithPlayer:paramNewPlayer];
    if (player_MO != nil) {
        if ([player_MO.age intValue] != [paramOldPlayer.age intValue]) {
            UIAlertView *av = [[UIAlertView alloc] initWithTitle:@"出错" message:@"已存在同名队员" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [av show];
            return;
        }
    }
    
    Player_MO *newPlayer_MO = [self findPlayerWithPlayer:paramOldPlayer];
    newPlayer_MO.name = paramNewPlayer.name;
    newPlayer_MO.age = paramNewPlayer.age;
    
    [self saveContext];
}

-(Player_MO *)findPlayerWithPlayer:(Player *)paramPlayer
{
    Player_MO *player_MO = nil;
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    [fetchRequest setEntity:[NSEntityDescription entityForName:@"Player_MO" inManagedObjectContext:self.managedObjectContext]];
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"team_MO == %@ AND name == %@",[self findTeamWithTeam:paramPlayer.team],paramPlayer.name];
    [fetchRequest setPredicate:predicate];
    [fetchRequest setFetchLimit:1];
    
    NSError *error = nil;
    NSArray *players_MO = [self.managedObjectContext executeFetchRequest:fetchRequest error:&error];
    
    if (players_MO.count > 0) {
        player_MO = [players_MO lastObject];
    }
    return player_MO;
}

-(NSArray *)findAllPlayersWithTeam:(Team *)paramTeam
{
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    [fetchRequest setEntity:[NSEntityDescription entityForName:@"Player_MO" inManagedObjectContext:self.managedObjectContext]];
    
    NSSortDescriptor *sortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"age"ascending:YES];
    [fetchRequest setSortDescriptors:@[sortDescriptor]];
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"team_MO == %@",[self findTeamWithTeam:paramTeam]];
    [fetchRequest setPredicate:predicate];
    
    NSError *error = nil;
    NSArray *players_MO = [self.managedObjectContext executeFetchRequest:fetchRequest error:&error];
    
    NSMutableArray *players = [NSMutableArray array];
    for (Player_MO *player_MO in players_MO) {
        Player *player = [[Player alloc] init];
        player.name = player_MO.name;
        player.age = player_MO.age;
        player.team = paramTeam;
        [players addObject:player];
    }
    
    return players;
}

@end
