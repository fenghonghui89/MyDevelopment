//
//  MD_Category_ViewController.m
//  MyDevelopmentOC
//
//  Created by hanyfeng on 15/5/25.
//  Copyright (c) 2015年 MD. All rights reserved.
//

#import "MD_Category_ViewController.h"
#import "TRMyclass.h"
#import "TRMyclass+TRCategory.h"
#import "NSString+TRJson.h"//可以对官方类进行分类以添加方法
@interface MD_Category_ViewController ()

@end

@implementation MD_Category_ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self categoryTest];
}

-(void)categoryTest
{
    TRMyclass* myclass = [[TRMyclass alloc] init];
    
    //分类创建的方法是公有的
    [myclass methodMyclass];
    [myclass methodCategory];
    
    //myclass.age=1;//扩展声明的变量是私有的
    
    NSString* str = [NSString new];
    [str Json];

}
@end
