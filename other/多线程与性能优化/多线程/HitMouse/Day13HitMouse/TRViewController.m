//
//  TRViewController.m
//  Day13HitMouse
//
//  Created by Tarena on 13-12-18.
//  Copyright (c) 2013年 Tarena. All rights reserved.
//

#import "TRViewController.h"
#import "TRMouse.h"
@interface TRViewController ()

@end

@implementation TRViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	[NSThread detachNewThreadSelector:@selector(addMouse) toTarget:self withObject:Nil];//开启子线程，在子线程中创建地鼠
}

//子线程中创建地鼠
-(void)addMouse{
    while (YES) {//不断循环
        [NSThread sleepForTimeInterval:1];
        TRMouse *mouse = [[TRMouse alloc]initWithFrame:CGRectMake(arc4random()%300, arc4random()%400+20, 20, 20)];
        mouse.delegate = self;
        [self performSelectorOnMainThread:@selector(updateUI:) withObject:mouse waitUntilDone:NO];//回到主线程把地鼠添加到界面
    }
}

//回到主线程把地鼠添加到界面
-(void)updateUI:(TRMouse*)mouse{
    [self.view addSubview:mouse];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
