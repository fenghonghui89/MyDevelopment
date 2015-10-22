//
//  ViewController.m
//  appB
//
//  Created by hanyfeng on 15/10/20.
//  Copyright © 2015年 MD. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (strong, nonatomic) IBOutlet UILabel *label;

@end

@implementation ViewController

-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"refreshUI" object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"cleanUI" object:nil];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self.view setBackgroundColor:[UIColor redColor]];
    [self addObserver];
}

- (IBAction)tap:(id)sender
{
    NSString *paramStr = [NSString stringWithFormat:@"appA1://username=%@&age=%@&address=%@", @"test123", @"100", @"上海市"];
//    NSString *paramStr = @"appA1://";
    NSURL *url = [NSURL URLWithString:[paramStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    [[UIApplication sharedApplication] openURL:url];
}

-(void)addObserver
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshUI:) name:@"refreshUI" object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(clearUI:) name:@"cleanUI" object:nil];
}

-(void)refreshUI:(NSNotification *)noti
{
    NSDictionary *dic = noti.object;
    NSString *username = [dic objectForKey:@"Username"];
    NSString *age = [dic objectForKey:@"age"];
    NSString *address = [dic objectForKey:@"address"];
    [self.label setText:[NSString stringWithFormat:@"%@ %@ %@",username,age,address]];
}

-(void)clearUI:(NSNotification *)noti
{
    [self.label setText:@""];
}
@end
