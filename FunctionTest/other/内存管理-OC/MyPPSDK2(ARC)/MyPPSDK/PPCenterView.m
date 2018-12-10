//
//  PPCenterView.m
//  MyPPSDK
//
//  Created by hanyfeng on 14-4-16.
//  Copyright (c) 2014年 hanyfeng. All rights reserved.
//

#import "PPCenterView.h"
#import "PPHelpView.h"

@interface PPCenterView()
@property(nonatomic,strong)UITableView *tv;
@end

@implementation PPCenterView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

-(id)init{
    
    self = [super init];
    if (self) {
        
        
        CGRect screenFrame = [[UIScreen mainScreen] bounds];
        [self setFrame:screenFrame];
        _tv = [[UITableView alloc] initWithFrame:screenFrame style:UITableViewStyleGrouped];
        [_tv setDataSource:self];
        [_tv setDelegate:self];
        [self addSubview:_tv];
    }
    return self;
}

#pragma mark - tableview datasource/delegate -
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 5;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier] ;
    }
    
    if (indexPath.section == 2 && indexPath.row == 0) {
        cell.textLabel.text = @"帮助";

    }
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 2 && indexPath.row == 0) {
        PPHelpView *ppHelpView = [[PPHelpView alloc] init];
        [[[UIApplication sharedApplication] keyWindow] insertSubview:ppHelpView atIndex:1002];
    }

}


@end
