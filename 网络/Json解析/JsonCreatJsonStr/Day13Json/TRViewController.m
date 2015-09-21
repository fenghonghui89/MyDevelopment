//
//  TRViewController.m
//  Day13Json
//
//  Created by Tarena on 13-12-18.
//  Copyright (c) 2013年 Tarena. All rights reserved.
//

#import "TRViewController.h"

@interface TRViewController ()

@end

@implementation TRViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    //模拟网上的数据
    NSArray *names = @[@"张三",@"李四",@"王五",@"赵六"];
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:@"张三",@"name",@"20",@"age",names,@"names", nil];
    
    //创建json字符串（看源码，此处的object只能是数组和字典）
    SBJsonWriter *jw = [[SBJsonWriter alloc]init];
    NSString *jsonStr = [jw stringWithObject:dic];
    
    //解析json字符串
    NSDictionary *newDic = [jsonStr JSONValue];
    NSLog(@"newDic = %@",newDic);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
