//
//  HFViewController.m
//  test
//
//  Created by hanyfeng on 14-5-5.
//  Copyright (c) 2014年 hanyfeng. All rights reserved.
//

#import "HFViewController.h"

@interface HFViewController ()
@property(nonatomic,strong)UITextField *tf;
@property(nonatomic,strong)UIView *vi;
@property(nonatomic,strong)UILabel *label;
@property(nonatomic,assign)BOOL keyboardIsShow;//标记状态：YES-弹出键盘、NO-收起键盘
@end

@implementation HFViewController



- (void)viewDidLoad
{
    NSLog(@" --- viewDidLoad-%@",[self showInterfaceOrientation]);
    
    [super viewDidLoad];
    
    UIView *vi = [[UIView alloc] init];
    [vi setBackgroundColor:[UIColor grayColor]];
    [self.view addSubview:vi];
    self.vi = vi;
    
    UILabel *label = [[UILabel alloc] init];
    [label setBackgroundColor:[UIColor greenColor]];
    [label setText:@"测试"];
    [label setTextColor:[UIColor blackColor]];
    [self.vi addSubview:label];
    self.label = label;
    
    UITextField *tf = [[UITextField alloc] init];
    tf.frame = CGRectZero;
    tf.delegate = self;
    [tf setBackgroundColor:[UIColor redColor]];
    [self.vi addSubview:tf];
    self.tf = tf;
    
    self.keyboardIsShow = NO;
}

#pragma mark - UITextField Delegate -
//开始输入，改变控件坐标
-(void)textFieldDidBeginEditing:(UITextField *)textField{
    self.keyboardIsShow = YES;
    [self changeUIFrame];
}

//点击键盘的return键时
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}

//输入已经结束，恢复控件坐标
-(void)textFieldDidEndEditing:(UITextField *)textField{
    self.keyboardIsShow = NO;
    [self changeUIFrame];
}

#pragma mark - 打印信息 -
//打印宽高
-(void)showInfo{
    NSLog(@" width --- b:%f f:%f s:%f kb:%f kf:%f",self.view.bounds.size.width,self.view.frame.size.width,[[UIScreen mainScreen] bounds].size.width,[[UIApplication sharedApplication] keyWindow].bounds.size.width,[[UIApplication sharedApplication] keyWindow].frame.size.width);
    NSLog(@" heigh --- b:%f f:%f s:%f kb:%f kf:%f",self.view.bounds.size.height,self.view.frame.size.height,[[UIScreen mainScreen] bounds].size.height,[[UIApplication sharedApplication] keyWindow].bounds.size.height,[[UIApplication sharedApplication] keyWindow].frame.size.height);
    printf("\n");
}

//打印当前旋转方向
-(NSString *)showInterfaceOrientation{
    UIInterfaceOrientation interfaceOrientation = (UIInterfaceOrientation)[[UIApplication sharedApplication] statusBarOrientation];
    NSString* string = nil;
    if (interfaceOrientation == UIInterfaceOrientationPortrait) {
        string = @"Portrait";
    }
    if (interfaceOrientation == UIInterfaceOrientationPortraitUpsideDown) {
        string = @"PortraitUpsideDown";
    }
    if (interfaceOrientation == UIInterfaceOrientationLandscapeLeft) {
        string = @"LandscapeLeft";
    }
    if (interfaceOrientation == UIInterfaceOrientationLandscapeRight) {
        string = @"LandscapeRight";
    }
    return string;
}

#pragma mark - 坐标调整/视图生命周期 -
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    NSLog(@" --- viewWillAppear");
}

-(void)viewWillLayoutSubviews{
    [super viewWillLayoutSubviews];
    NSLog(@" --- viewWillLayoutSubviews-%@",[self showInterfaceOrientation]);
}

-(void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    NSLog(@" --- viewDidLayoutSubviews-%@",[self showInterfaceOrientation]);
    [self setUIFrame];
    
    if (self.keyboardIsShow == YES) {
        [self changeUIFrame];
    }
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:YES];
    NSLog(@" --- viewDidAppear");
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:YES];
    NSLog(@" --- viewWillDisappear");
}

-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:YES];
    NSLog(@" --- viewDidDisappear");
}

//设置固有控件的初始坐标
-(void)setUIFrame{
    CGRect frame = CGRectZero;

    frame = self.vi.frame;
    frame = CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height);
    self.vi.frame = frame;
    
    frame = self.label.frame;
    frame = CGRectMake(self.vi.bounds.size.width - (self.vi.bounds.size.width - 100) / 2 - 100, 100, 100, 30);
    self.label.frame = frame;
    
    frame = self.tf.frame;
    frame = CGRectMake(self.vi.bounds.size.width - (self.vi.bounds.size.width - 220) / 2 - 220, 150, 220, 50);
    self.tf.frame = frame;
}

//改变固有控件的坐标
-(void)changeUIFrame{
    
    //弹出键盘
    if (self.keyboardIsShow == YES) {
        NSLog(@" --- 弹出键盘-%@",[self showInterfaceOrientation]);
        
        //根据当前设备选装的方向改变坐标
        UIInterfaceOrientation interfaceOrientation = (UIInterfaceOrientation)[[UIApplication sharedApplication] statusBarOrientation];
        CGRect frame = CGRectZero;
        
        if (interfaceOrientation == UIInterfaceOrientationPortrait) {
            frame = self.vi.frame;
            frame.origin.y -= 100;
            self.vi.frame = frame;
        }
        
        if (interfaceOrientation == UIInterfaceOrientationPortraitUpsideDown) {
            frame = self.vi.frame;
            frame.origin.y -= 100;
            self.vi.frame = frame;
        }
        
        if (interfaceOrientation == UIInterfaceOrientationLandscapeLeft) {
            frame = self.vi.frame;
            frame.origin.y -= 100;
            self.vi.frame = frame;
        }
        
        if (interfaceOrientation == UIInterfaceOrientationLandscapeRight) {
            frame = self.vi.frame;
            frame.origin.y -= 100;
            self.vi.frame = frame;
        }
    }
    
    //收起键盘
    if (self.keyboardIsShow == NO) {
        NSLog(@" --- 收起键盘-%@",[self showInterfaceOrientation]);
        [self setUIFrame];
    }
    
    return;
}

#pragma mark - 旋屏开关 -
-(BOOL)shouldAutorotate{
    return YES;
}

-(NSUInteger)supportedInterfaceOrientations{
    return UIInterfaceOrientationMaskAll;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
