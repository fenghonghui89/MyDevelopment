//
//  FlipsideViewController.m
//  UtiliySampleNib
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

#import "FlipsideViewController.h"

@interface FlipsideViewController ()

@end

@implementation FlipsideViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.contentSizeForViewInPopover = CGSizeMake(320.0, 480.0);//ipad下popver视图大小
    }
    return self;
}
							
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Actions

- (IBAction)done:(id)sender
{
    //方法1-调用被委托对象的协议方法
    [self.delegate flipsideViewControllerDidFinish:self];
    
//    //方法2-自己dismiss(不推荐，除非主视图和子视图关系紧密)
//    //iphone
//    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
//        [self dismissViewControllerAnimated:YES completion:nil];
//    }
//    
//    //ipad（因为delegate是id，无法点出flipsidePopoverController属性，则不能调用后面的方法）
//    else {
//        [self.delegate.flipsidePopoverController dismissPopoverAnimated:YES];
//    }
}

@end
