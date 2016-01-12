//
//  ViewController.m
//  PopoverViewSample
//
//  Created by 关东升 on 12-9-24.
//  本书网站：http://www.iosbook1.com
//  智捷iOS课堂：http://www.51work6.com
//  智捷iOS课堂在线课堂：http://v.51work6.com
//  智捷iOS课堂新浪微博：http://weibo.com/u/3215753973
//  作者微博：http://weibo.com/516inc
//  官方csdn博客：http://blog.csdn.net/tonny_guan
//  QQ：1575716557 邮箱：jylong06@163.com
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
}

-(void)showInfo{
    NSLog(@" 1 --- popoverVisible:%d",self.poc.popoverVisible);
    if (self.poc.popoverArrowDirection == UIPopoverArrowDirectionUp) {
        NSLog(@" 1 --- 方向朝上");
    }
}

//右边弹框
- (IBAction)show:(id)sender {

    //创建UIPopoverController对象的内容vc
    SelectViewController *popoverViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"SelectViewController"];
    popoverViewController.vc = self;
    
    //创建UIPopoverController对象
    //因为dismiss后UIPopoverController对象还会存在，所以要添加条件防止多次实例化，造成内存泄露
    if (self.poc == nil)
    {
        popoverViewController.title = @"选择你喜欢的颜色";
        UINavigationController *navi = [[UINavigationController alloc]
                                       initWithRootViewController:popoverViewController];
        self.poc = [[UIPopoverController alloc] initWithContentViewController:navi];
        self.poc.delegate = self;
    }
    
    //弹出
    [self.poc presentPopoverFromBarButtonItem:sender
                     permittedArrowDirections:UIPopoverArrowDirectionUp
                                     animated:YES];
}

#pragma mark --UIPopoverControllerDelegate 协议方法 （点击屏幕其他地方触发）
//是否允许关闭
- (BOOL)popoverControllerShouldDismissPopover:(UIPopoverController *)popoverController{
    NSLog(@" 1 --- UIPopoverControllerDelegate 协议方法1");
    return  YES;
}

//关闭后执行操作
-(void)popoverControllerDidDismissPopover:(UIPopoverController *)popoverController{
    NSLog(@" 1 --- UIPopoverControllerDelegate 协议方法2");
    [self showInfo];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
