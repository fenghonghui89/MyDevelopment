//
//  TRViewController.m
//  Day6GetImageFromSystem_my
//
//  Created by HanyFeng on 13-12-11.
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

- (IBAction)click:(UIButton *)sender
{
    UIImagePickerController *ipc = [[UIImagePickerController alloc]init];
    [ipc setSourceType:UIImagePickerControllerSourceTypeSavedPhotosAlbum];//设置图片源
    
    ipc.delegate = self;
    ipc.allowsEditing = YES;//编辑模式
    
    [self presentViewController:ipc animated:YES completion:Nil];
}

//协议方法1-1
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info;
{
    NSLog(@"%@",info);
    UIImage* image = [info objectForKey:@"UIImagePickerControllerEditedImage"];
    UIImageView* imageView = [[UIImageView alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];
    imageView.image = image;
    [self.view addSubview:imageView];
    [self dismissViewControllerAnimated:YES completion:nil];
}

//协议方法1-2
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

//协议方法2-1
- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    
}

//协议方法2-2
- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
