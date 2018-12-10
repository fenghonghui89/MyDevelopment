//
//  PPHelpView.m
//  MyPPSDK
//
//  Created by hanyfeng on 14-4-16.
//  Copyright (c) 2014年 hanyfeng. All rights reserved.
//

#import "PPHelpView.h"

@interface PPHelpView()
@property(nonatomic,strong)UITableView *tv;
@property(nonatomic,strong)PPHttpRequest *ppHttpRequest;
@end

@implementation PPHelpView

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

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 2;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier] ;
    }
    
    if (indexPath.section == 2 && indexPath.row == 0) {
        cell.textLabel.text = @"获取帮助页面数据";
    }
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 2 && indexPath.row == 0) {
        [self getHelpViewData];
    }
}


#pragma mark - PPHttpRequestDelegate -
-(void)getHelpViewData{
    NSLog(@"getHelpViewData");
    PPHttpRequest *ppHttpRequest = [[PPHttpRequest alloc] init];
    [ppHttpRequest setDelegate:self];
    [ppHttpRequest connectToPPServerAndGetHelpViewData];
}

#pragma mark - ppHttpRequestDelegate -
-(void)ppHttpRequest:(PPHttpRequest *)ppHttpRequest andParmaDic:(NSDictionary *)parmaDic{
    NSLog(@"ppHttpRequest回调");
    NSLog(@"数据：%@",parmaDic);
}

@end
