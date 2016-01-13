//
//  TRViewController.m
//  Demo4_Message
//
//  Created by Tarena on 13-11-18.
//  Copyright (c) 2013年 Tarena. All rights reserved.
//

#import "TRViewController.h"

@interface TRViewController () <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *inputBackgroundImageView;
@property (weak, nonatomic) IBOutlet UIImageView *textFieldBackgroundImageView;
@property (weak, nonatomic) IBOutlet UIView *inputTextView;


@end

@implementation TRViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UIImage * inputBack = [UIImage imageNamed:@"ToolViewBkg_Black.png"];
    UIImage * resizedInputBack =
    [inputBack resizableImageWithCapInsets:UIEdgeInsetsMake(10, 10, 10, 10)
                              resizingMode:UIImageResizingModeStretch];
    self.inputBackgroundImageView.image = resizedInputBack;
    
    UIImage * textFieldBack = [UIImage imageNamed:@"SendTextViewBkg.png"];
    UIImage * resizedTextFieldBack =
    [textFieldBack resizableImageWithCapInsets:UIEdgeInsetsMake(11, 15, 13, 15)
                                  resizingMode:UIImageResizingModeStretch];
    self.textFieldBackgroundImageView.image = resizedTextFieldBack;
    
    
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    NSLog(@"%.2f,%.2f",self.view.bounds.size.height,self.inputTextView.frame.origin.y);//inputTextView的值错误（bug?）
    
    //有toolbar，在IOS6.0下加载时输入框坐标系错误问题，用下面的语句重新指定
    if ([[[UIDevice currentDevice] systemVersion] floatValue] <= 6.1) {
        CGRect frameOfInputView = self.inputTextView.frame;
        frameOfInputView.origin.y = self.view.bounds.size.height - self.inputTextView.frame.size.height;
        self.inputTextView.frame = frameOfInputView;
    }
    NSLog(@"%.2f",self.inputTextView.frame.origin.y);
    
    NSNotificationCenter * notificationCenter =
    [NSNotificationCenter defaultCenter];
    
    [notificationCenter addObserver:self
                           selector:@selector(keyboardAppear:)
                               name:UIKeyboardWillShowNotification
                             object:nil];
    
    [notificationCenter addObserver:self
                           selector:@selector(keyboardDisappear:)
                               name:UIKeyboardWillHideNotification
                             object:nil];
    
}

//收到通知对象后键盘显示
- (void)keyboardAppear:(NSNotification *)notification
{
    //  1.  获取键盘相对于自己VC的view的坐标系信息
    CGRect frameOfKeyboard = [notification.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    UIWindow * window = [[[UIApplication sharedApplication] delegate] window];
    frameOfKeyboard = [self.view convertRect:frameOfKeyboard fromView:window];
    
    //  2.  计算输入框的结束的坐标信息
    CGRect frameOfInputView = self.inputTextView.frame;
    frameOfInputView.origin.y = frameOfKeyboard.origin.y - frameOfInputView.size.height;
    
    //  3.  获取键盘动画信息，动画方式更改输入框的坐标信息
    NSTimeInterval duration = [notification.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    duration += 2;
    
    UIViewAnimationOptions options = [notification.userInfo[UIKeyboardAnimationCurveUserInfoKey]unsignedIntegerValue];
    
    [UIView animateWithDuration:duration
                          delay:0.0
                        options:options
                     animations:
     ^{
         self.inputTextView.frame = frameOfInputView;
     }
                     completion:nil];
}

//收到通知对象后键盘消失
- (void)keyboardDisappear:(NSNotification *)notification
{
    CGRect frameOfInputView = self.inputTextView.frame;
    frameOfInputView.origin.y = self.view.bounds.size.height - frameOfInputView.size.height;
    
    //有toolbar，在IOS7.0下收键盘时，输入框坐标系错误问题，用下面的语句解决
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0) {
        frameOfInputView.origin.y -= [self.bottomLayoutGuide length];
    }
    
    NSTimeInterval duration = [notification.userInfo[UIKeyboardAnimationDurationUserInfoKey]doubleValue];
    duration += 2;
    
    UIViewAnimationOptions options =[notification.userInfo[UIKeyboardAnimationCurveUserInfoKey]unsignedIntegerValue];
    
    [UIView animateWithDuration:duration
                          delay:0.0
                        options:options
                     animations:
     ^{
         self.inputTextView.frame = frameOfInputView;
     }
                     completion:nil];
}

//取消广播
- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    NSNotificationCenter * notificationCenter = [NSNotificationCenter defaultCenter];
    [notificationCenter removeObserver:self
                                  name:UIKeyboardWillShowNotification
                                object:nil];
    [notificationCenter removeObserver:self
                                  name:UIKeyboardWillHideNotification
                                object:nil];
}

//收起键盘
- (IBAction)closeKeyboard:(id)sender
{
    [sender resignFirstResponder];
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 20;
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
        cell.accessoryType = UITableViewCellAccessoryDetailDisclosureButton;
        cell.textLabel.textColor = [UIColor blackColor];
        cell.textLabel.font = [UIFont boldSystemFontOfSize:18];
    }
    
    cell.textLabel.text = [NSString stringWithFormat:@"Table View Cell %ld", (long)indexPath.row];
    
    return cell;
}

@end
