//
//  TRSecondViewController.m
//  Demo7_Layout_Code_OS7
//
//  Created by Tarena on 13-11-21.
//  Copyright (c) 2013年 Tarena. All rights reserved.
//

#import "TRSecondViewController.h"

@interface TRSecondViewController ()
@property (weak, nonatomic) IBOutlet UILabel *label;

@end

@implementation TRSecondViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        //2.方法2-不渗透，只占用当前VC的空间（对于当前VC的下层VC来说还是渗透的，所以会透出下层VC的底色。如果下层VC就是最底层的屏幕，则会透出灰色（屏幕底色是灰色），可以通过在AppDelegate.m改变屏幕底色为白色改变）
        self.edgesForExtendedLayout = UIRectEdgeNone;
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSLog(@"%.2f",self.view.bounds.size.height);
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    //1.解决7.0 navigationBar渗透问题-方法1-根据IOS版本判断是否需要下移64
    if ([[[UIDevice currentDevice]systemVersion] floatValue] >= 7.0) {
        CGFloat topHeight = [self.topLayoutGuide length];
        NSLog(@"%.2f", topHeight);
        
        CGRect frame = self.label.frame;
        frame.origin.y = 20 + topHeight;
        self.label.frame = frame;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
