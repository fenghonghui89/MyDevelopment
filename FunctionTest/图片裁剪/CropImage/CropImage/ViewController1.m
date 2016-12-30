//
//  ViewController1.m
//  CropImage
//
//  Created by 冯鸿辉 on 16/3/9.
//  Copyright © 2016年 杨 烽. All rights reserved.
//

#import "ViewController1.h"

@interface ViewController1 ()


@end

@implementation ViewController1

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

-(void)viewDidAppear:(BOOL)animated{
  [super viewDidAppear:animated];
  self.imageView.image = self.photo;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (IBAction)btntap:(id)sender {
  [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)dealloc {
  [_imageView release];
  [super dealloc];
}
- (void)viewDidUnload {
  [self setImageView:nil];
  [super viewDidUnload];
}
@end
