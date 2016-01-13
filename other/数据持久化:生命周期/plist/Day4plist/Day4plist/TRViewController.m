//
//  TRViewController.m
//  Day4plist
//
//  Created by Tarena on 13-12-5.
//  Copyright (c) 2013年 Tarena. All rights reserved.
//

#import "TRViewController.h"

@interface TRViewController ()

@end

@implementation TRViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //把plist文件 转为数组
    NSString *namesPath = [[NSBundle mainBundle]pathForResource:@"my" ofType:@"plist"];
	NSArray *names = [NSArray arrayWithContentsOfFile:namesPath];
    
    for (NSString *name in names) {
        NSLog(@"%@",name);
    }
    
    //把plist 转为字典
    NSString *levelsPath = [[NSBundle mainBundle]pathForResource:@"leves" ofType:@"plist"];
    NSDictionary *levels = [NSDictionary dictionaryWithContentsOfFile:levelsPath];
    NSLog(@"第2关敌人数量%@",[levels objectForKey:@"level2"]);
    
    //把数组转为plist文件
    NSArray *newNames = @[@"哈哈",@"嘿嘿",@"呵呵"];
    [newNames writeToFile:@"/Users/apple/Desktop/newNames.plist" atomically:YES];
    
    //字典保存为plist文件
    NSNumber* num1 = [NSNumber numberWithInt:1];
    NSNumber* num2 = [NSNumber numberWithInt:2];
    NSNumber* num3 = [NSNumber numberWithInt:3];
    
    NSDictionary* newLevels = [NSDictionary dictionaryWithObjectsAndKeys:num1,@"one",num2,@"two",num3,@"three", nil];
    [newLevels writeToFile:@"/Users/apple/Desktop/newLevels.plist" atomically:YES];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
