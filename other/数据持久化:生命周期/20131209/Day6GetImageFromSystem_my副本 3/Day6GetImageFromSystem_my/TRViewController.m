//
//  TRViewController.m
//  Day6GetImageFromSystem_my
//
//  Created by HanyFeng on 13-12-11.
//  Copyright (c) 2013年 Hany. All rights reserved.
//

#import "TRViewController.h"

@interface TRViewController ()
@property(nonatomic,strong)UIView* v;

@end

@implementation TRViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (IBAction)click:(UIButton *)sender
{
    UIImagePickerController *ipc = [[UIImagePickerController alloc]init];
    [ipc setSourceType:UIImagePickerControllerSourceTypeSavedPhotosAlbum];
    ipc.delegate = self;
//    ipc.allowsEditing = YES;
    [self presentViewController:ipc animated:YES completion:Nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info;
{
    NSLog(@"%@",info);
    UIImage* image = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
    UIImageView* imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 80, 80)];
    imageView.image = image;
    [self.v addSubview:imageView];
//    [self dismissViewControllerAnimated:YES completion:nil];

}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    
}

- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    self.v = [[UIView alloc] initWithFrame:CGRectMake(0, 468, 320, 80)];
    self.v.backgroundColor = [UIColor redColor];
    
    [viewController.view addSubview:self.v];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
