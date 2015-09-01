//
//  TRViewController.m
//  my04
//
//  Created by HanyFeng on 13-11-21.
//  Copyright (c) 2013年 Hany. All rights reserved.
//

#import "TRViewController.h"
#import "TRView.h"
@interface TRViewController ()
@property (weak, nonatomic) IBOutlet TRView *drawView;
@property(nonatomic,assign)NSMutableArray* drawLines;
@end

@implementation TRViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.drawView.drawLines = [NSMutableArray array];

	// Do any additional setup after loading the view, typically from a nib.
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
