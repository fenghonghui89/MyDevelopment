//
//  DetailViewController.m
//  MasterDetailNib
//
//  Created by 关东升 on 12-9-25.
//  本书网站：http://www.iosbook1.com
//  智捷iOS课堂：http://www.51work6.com
//  智捷iOS课堂在线课堂：http://v.51work6.com
//  智捷iOS课堂新浪微博：http://weibo.com/u/3215753973
//  作者微博：http://weibo.com/516inc
//  官方csdn博客：http://blog.csdn.net/tonny_guan
//  QQ：1575716557 邮箱：jylong06@163.com
//

#import "DetailViewController.h"

@interface DetailViewController ()


@end

@implementation DetailViewController

#pragma mark - Managing the detail item

- (void)viewDidLoad
{
    NSLog(@"detailview viewDidLoad");//初始就会创建子视图vc
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [self configureView];
}

//对应masterview的点击行弹出detailview方法
//方法1-不用复写set方法
//方法2-复写set方法
//- (void)setDetailItem:(id)newDetailItem
//{
//    if (_detailItem != newDetailItem) {
//        _detailItem = newDetailItem;
//        
//        // Update the view.
//        [self configureView];
//    }
//
//    //ipad下，如果masterview存在，则隐藏（竖屏有效果）
//    if (self.masterPopoverController != nil) {
//        [self.masterPopoverController dismissPopoverAnimated:YES];
//    }        
//}

//更新视图
- (void)configureView
{
    if (self.detailItem) {
        self.detailDescriptionLabel.text = [self.detailItem description];
    }
    
    //ipad处于竖屏状态下，如果masterview存在，则隐藏
    if (self.masterPopoverController != nil) {
        NSLog(@"ipad竖屏，masterPopoverController != nil");
        [self.masterPopoverController dismissPopoverAnimated:YES];//隐藏包含主视图vc的PopoverController对象
    }
    
    //ipad处于横屏状态下，masterview显示，但处于nil状态？
    if (self.masterPopoverController == nil) {
        NSLog(@"ipad横屏，masterPopoverController == nil");
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = NSLocalizedString(@"Detail", @"Detail");
    }
    return self;
}
							
#pragma mark - Split view delegate （当设备是ipad时会调用）-

//ipad转为竖屏，masterview将要隐藏时调用
- (void)splitViewController:(UISplitViewController *)splitController willHideViewController:(UIViewController *)viewController withBarButtonItem:(UIBarButtonItem *)barButtonItem forPopoverController:(UIPopoverController *)popoverController
{
    NSLog(@"ipad转为竖屏，masterview将要隐藏");
    barButtonItem.title = NSLocalizedString(@"Master", @"Master");
    [self.navigationItem setLeftBarButtonItem:barButtonItem animated:YES];
    self.masterPopoverController = popoverController;
}

//ipad转为横屏，masterview将要显示时调用
- (void)splitViewController:(UISplitViewController *)splitController willShowViewController:(UIViewController *)viewController invalidatingBarButtonItem:(UIBarButtonItem *)barButtonItem
{
    // Called when the view is shown again in the split view, invalidating the button and popover controller.
    NSLog(@"ipad转为横屏，masterview将要显示");
    [self.navigationItem setLeftBarButtonItem:nil animated:YES];
    self.masterPopoverController = nil;
}

@end
