//
//  TRViewController.m
//  Day4UserDefults
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
    
    //1.读取数据
    //创建一个一般的NSUserDefaults对象
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    
    //读取“指定的类型和key”所对应的数据
    //注：程序第一次运行是什么都取不到的，因此int的默认值为0，所以第一次运行起来，runTimes为0，如果存的是对象，第一次取出来的为nil
    int runTimes = [ud integerForKey:@"runTimes"];
    
    NSLog(@"%d",runTimes);
    
    //2.设置数据
    //设置key所对应的数据
    [ud setInteger:++runTimes forKey:@"runTimes"];
    
    //3.同步数据
    //同步：把数据从内存当中，及时同步到文件当中
    [ud synchronize];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
