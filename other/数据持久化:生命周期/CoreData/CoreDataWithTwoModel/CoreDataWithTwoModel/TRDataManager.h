//
//  TRDataManager.h
//  CoreDataWithTwoModel
//
//  Created by hanyfeng on 14-8-25.
//  Copyright (c) 2014年 Tarena. All rights reserved.
//

#import "CoreDataManager.h"
#import "Team.h"
#import "Player.h"
#import "Team_MO.h"
#import "Player_MO.h"


@interface TRDataManager : CoreDataManager

+(TRDataManager *)shareDataManager;

-(void)creatTeamWithTeam:(Team *)paramTeam;
-(void)deleteTeamWithTeam:(Team *)paramTeam;
-(void)changeTeamWithOldTeam:(Team *)paramOldTeam andNewTeam:(Team *)paramNewTeam;
-(Team_MO *)findTeamWithTeam:(Team *)paramTeam;
-(NSArray *)findAllTeams;

-(void)creatPlayerWithPlayer:(Player *)paramPlayer;
-(void)deletePlayerWithPlay:(Player *)paramPlayer;
-(void)changePlayerWithOldPlayer:(Player *)paramOldPlayer andNewPlayer:(Player *)paramNewPlayer;
-(Player_MO *)findPlayerWithPlayer:(Player *)paramPlayer;
-(NSArray *)findAllPlayersWithTeam:(Team *)team;
@end
