//
//  TRAddViewController.h
//  CoreDataWithTwoModel
//
//  Created by hanyfeng on 14-8-25.
//  Copyright (c) 2014年 Tarena. All rights reserved.
//

typedef NS_ENUM(NSInteger, pageType){
    createNewTeam = 0,
    changeTeam = 1,
    createNewPlayer = 2,
    changePlayer = 3
};


#import <UIKit/UIKit.h>
#import "Team.h"
#import "Player.h"
@interface TRAddViewController : UIViewController
@property(nonatomic,assign)pageType pageType;
@property(nonatomic,strong)Player *player;
@property(nonatomic,strong)Team *team;
@end
