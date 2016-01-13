//
//  PPHelpView.m
//  MyPPSDK
//
//  Created by hanyfeng on 14-4-16.
//  Copyright (c) 2014年 hanyfeng. All rights reserved.
//MRC - 4

#import "PPHelpView.h"

@interface PPHelpView()
@property(nonatomic,strong)UITableView *tv;
@property(nonatomic,strong)PPWebViewData *webViewData;
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
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier] autorelease] ;
    }
    
    if (indexPath.section == 1 && indexPath.row == 0) {
        cell.textLabel.text = @"返回";
    }
    
    if (indexPath.section == 2 && indexPath.row == 0) {
        cell.textLabel.text = @"获取帮助数据";
    }
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 1 && indexPath.row == 0) {
        [self removeFromSuperview];
    }
    
    if (indexPath.section == 2 && indexPath.row == 0) {
        [self getData];
    }
}

-(void)getData{
    PPWebViewData *ppWebViewData = [[PPWebViewData alloc] init];
    [ppWebViewData setDelegate:self];
    [ppWebViewData getHelpViewData];
    self.webViewData = ppWebViewData;
    [ppWebViewData release];
    
}

#pragma mark - PPWebViewDataDelegate -
-(void)webViewData:(PPWebViewData*)ppWebViewData andPPHelpViewData:(NSDictionary*)parmaDic{
    NSLog(@"---%@",parmaDic);
}

-(void)dealloc{
    NSLog(@"PPHelpView dealloc:%p",self);
    _tv.delegate = nil;
    _tv.dataSource = nil;
    [_tv release];
    _tv = nil;
    [_webViewData release];
    _webViewData = nil;
    [super dealloc];
}

@end
