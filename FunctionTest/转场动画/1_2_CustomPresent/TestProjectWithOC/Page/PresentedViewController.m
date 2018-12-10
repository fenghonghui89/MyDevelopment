//
//  PresentedViewController.m
//  TestProjectWithOC
//
//  Created by hanyfeng on 2018/9/30.
//  Copyright © 2018 JiepengZhengDevExtend. All rights reserved.
//

#import "PresentedViewController.h"
@interface PresentedViewController ()

@end

@implementation PresentedViewController

-(void)dealloc{
    NSLog(@"dealloc...");
}

- (void)viewDidLoad {
    [super viewDidLoad];

}

#pragma mark - action

- (IBAction)tap:(id)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(didPresentedVC:)]) {
        [self.delegate didPresentedVC:self];
    }
}

@end
