//
//  PPHelpView.m
//  MyPPSDK
//
//  Created by hanyfeng on 14-4-16.
//  Copyright (c) 2014年 hanyfeng. All rights reserved.
//ARC - 4

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
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier] ;
    }
    
    if (indexPath.section == 2 && indexPath.row == 0) {
        cell.textLabel.text = @"获取帮助页面数据";
    }
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 2 && indexPath.row == 0) {
        [self getData];
    }
}

-(void)getData{
    NSLog(@"getData");    
    PPWebViewData *ppWebViewData = [[PPWebViewData alloc] init];
    [ppWebViewData setDelegate:self];
    [ppWebViewData getHelpViewData];
    self.webViewData = ppWebViewData;
    
//    self.webViewData = [[PPWebViewData alloc] init];
//    [self.webViewData setDelegate:self];
//    [self.webViewData getHelpViewData];
}

#pragma mark - PPWebViewDataDelegate -
-(void)webViewData:(PPWebViewData*)ppWebViewData andPPHelpViewData:(NSDictionary*)parmaDic{
    NSLog(@"数据：%@",parmaDic);
}

@end
