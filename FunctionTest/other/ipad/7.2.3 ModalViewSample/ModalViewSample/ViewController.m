//
//  ViewController.m
//  ModalViewSample
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
#import "ModalViewController.h"

@interface ViewController ()

@end

@implementation ViewController

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

/*
 方法1：storyboard连线跳转（看截图）
 方法2：代码（如下）
 */
- (IBAction)onclick:(id)sender {
    
    ModalViewController *modalViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"modalViewController"];
    
    //跳转动画类型
    modalViewController.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
    
    //呈现样式类型
    switch (self.segControl.selectedSegmentIndex) {
        case 0:
            modalViewController.modalPresentationStyle = UIModalPresentationFullScreen;
            break;
        case 1:
            modalViewController.modalPresentationStyle = UIModalPresentationPageSheet;
            break;
        case 2:
            modalViewController.modalPresentationStyle = UIModalPresentationFormSheet;
            break;
        default:
            modalViewController.modalPresentationStyle = UIModalPresentationCurrentContext;
            break;
    }
    
    [self presentViewController:modalViewController animated:YES completion:nil];
    
    
}
@end
