//
//  ViewController.m
//  photoTest
//
//  Created by hanyfeng on 15/10/19.
//  Copyright © 2015年 MD. All rights reserved.
//

#define CAMERA_TRANSFORM_Y 1.24299
#import "UIImage+Scale.h"
#import "ViewController.h"
#import "CameraOverlayViewController.h"
@interface ViewController ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate>
@property (nonatomic,strong) UIImagePickerController *ipc;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor greenColor]];
    // Do any additional setup after loading the view, typically from a nib.
}

- (IBAction)tap:(id)sender {
  UIImagePickerController *ipc = [[UIImagePickerController alloc]init];
  [ipc setSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
  //    ipc.showsCameraControls = YES;
  //    ipc.allowsEditing = YES;
  ipc.delegate = self;
  _ipc = ipc;
  [self presentViewController:ipc animated:YES completion:Nil];
}


- (IBAction)photoTap:(id)sender
{

  
  CameraOverlayViewController *cvc = [[CameraOverlayViewController alloc] init];
  [self.navigationController pushViewController:cvc animated:YES];

}

#pragma mark - < callback > -
//保存图片时用到的方法
- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo
{
    NSLog(@"哈哈 保存成功！！！");
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark imagePickerController delegate
//点击相册中的图片后
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info;
{
    NSLog(@"哈哈 didFinishPickingMediaWithInfo！！！");
    
    UIImage *image = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
    UIImageView *iv = [[ UIImageView alloc]init];
    iv.image = [self compressIamge:image];
    [self.view addSubview:iv];
    
    
    iv.frame = [UIScreen mainScreen].bounds;
    //    iv.frame = CGRectMake(200, 200, 100, 100);
    //    [iv setClipsToBounds:YES];
    [iv setContentMode:UIViewContentModeScaleAspectFit];
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

//协议方法：相册右上角的删除按钮
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    NSLog(@"哈哈 相册已经消失");
}

#pragma mark navi delegate
//协议方法：相册将要显示
- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    NSLog(@"哈哈 相册将要显示");
}

//协议方法：相册已经显示
- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    NSLog(@"哈哈 相册已经显示");
    NSLog(@"ImagePickerController.view%@",NSStringFromCGRect(_ipc.view.frame));
}

- (UIImage *)compressIamge:(UIImage *)image {
//    UIImage *imageSave;
//    CGFloat maxsize = 640;
//    
//    if (image.size.height > maxsize && image.size.height < image.size.width  ) {
//        CGFloat fScale = maxsize / image.size.height;
//        CGFloat fWidth = image.size.width * fScale;
//        imageSave = [image scaleToSize:CGSizeMake(fWidth, maxsize)];
//    }
//    else if (image.size.width > maxsize && image.size.width < image.size.height  ) {
//        CGFloat fScale = maxsize / image.size.width;
//        CGFloat fHeight = image.size.height * fScale;
//        imageSave = [image scaleToSize:CGSizeMake(maxsize, fHeight)];
//    }
//    else {
//        imageSave = image;
//    }
//    return imageSave;
    UIImage *imageSave;
    imageSave = [image scaleToSize:CGSizeMake([UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    return imageSave;
}
@end
