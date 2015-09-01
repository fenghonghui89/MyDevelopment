//
//  TRViewController.m
//  Demo3_DrawPad
//
//  Created by Tarena on 13-11-21.
//  Copyright (c) 2013年 Tarena. All rights reserved.
//

#import "TRViewController.h"
#import "TRView.h"

@interface TRViewController ()
@property (weak, nonatomic) IBOutlet TRView *drawView;

@end

@implementation TRViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}
- (IBAction)lineWidthChanged:(UISlider *)sender {
    self.drawView.lineWidth = sender.value;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
