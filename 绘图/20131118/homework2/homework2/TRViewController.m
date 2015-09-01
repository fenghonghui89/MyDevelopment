//
//  TRViewController.m
//  homework2
//
//  Created by HanyFeng on 13-11-19.
//  Copyright (c) 2013年 Hany. All rights reserved.
//

#import "TRViewController.h"

@interface TRViewController ()

@end

@implementation TRViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (IBAction)tap:(id)sender {
    if (self.fromMe == YES) {
        UILabel* messageLabel = [UILabel new];
        self.messageImage = [UIImage imageNamed:@"message_i"];
        messageLabel.
    }
}

//-(void)aaa
//{
//    UIImageView* imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"message_i"]];
//    NSString* message = self.textField.text;
//    CGSize size = [message sizeWithFont:[UIFont systemFontOfSize:20] constrainedToSize:CGSizeMake(200, 9999)];
//    imageView.frame.size = CGSizeMake(size.width, size.height);
//    float iii1=0,iii2 =0;
//    UILabel* messageLabel = [UILabel new];
//    messageLabel.size = CGSizeMake(size.width, size.height);
//    messageLabel.text = self.textField.text;
//    messageLabel.frame.origin = CGPointMake(self.view.frame.size.width-iii1, self.view.frame.size.height-iii2);
//    messageLabel.alpha = 0;
//}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
