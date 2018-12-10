//
//  PPHelpView.m
//  MyPPSDK
//
//  Created by hanyfeng on 14-4-16.
//  Copyright (c) 2014年 hanyfeng. All rights reserved.
//MRC - 3

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
        NSLog(@"UITableView:%p",_tv);
        [_tv setDataSource:self];
        [_tv setDelegate:self];
        [self addSubview:_tv];
//        [_tv release];//因为_tv是self的subview，而[self removeformsuperview]时会对subview都发送一次release，所以要注意在[self removeformsuperview]之前_tv还有一个引用，否则就会double free，当然可以在其他地方修改
        
        
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
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier] autorelease];
    }
    
    if (indexPath.section == 1 && indexPath.row == 0) {
        cell.textLabel.text = @"返回";
    }
    
    if (indexPath.section == 2 && indexPath.row == 0) {
        cell.textLabel.text = @"获取帮助页面数据";
    }
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 1 && indexPath.row == 0) {
        [self removeFromSuperview];
    }
    
    if (indexPath.section == 2 && indexPath.row == 0) {
        [self getHelpViewData];
    }
}

-(void)getHelpViewData{
    NSLog(@"getHelpViewData");
    PPHttpRequest *ppHttpRequest = [[PPHttpRequest alloc] init];
    [ppHttpRequest setDelegate:self];
    [ppHttpRequest connectToPPServerAndGetHelpViewData];
    self.ppHttpRequest = ppHttpRequest;
    [ppHttpRequest release];
}

#pragma mark - ppHttpRequestDelegate -
-(void)ppHttpRequest:(PPHttpRequest *)ppHttpRequest andParmaDic:(NSDictionary *)parmaDic{
    NSLog(@"ppHttpRequest回调");
    NSLog(@"数据：%@",parmaDic);
}

-(void)dealloc{
    NSLog(@"PPHelpView dealloc:%p",self);
    _tv.delegate = nil;
    _tv.dataSource = nil;
    [_tv release];
    _tv = nil;
    
    [_ppHttpRequest release];
    _ppHttpRequest = nil;
    [super dealloc];
}

@end
