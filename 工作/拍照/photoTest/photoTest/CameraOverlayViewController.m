//
//  CameraOverlayViewController.m
//  photoTest
//
//  Created by hanyfeng on 15/10/19.
//  Copyright © 2015年 MD. All rights reserved.
//

#import "CameraOverlayViewController.h"
#import "ZTCameraView.h"
@interface CameraOverlayViewController ()
@property(nonatomic,strong)ZTCameraView *cameraView;
@property(nonatomic,strong)UIImageView *imageView;
@end

@implementation CameraOverlayViewController

-(void)viewDidLoad
{
    [super viewDidLoad];
    [self customInitUI];
}

-(void)customInitUI
{
    ZTCameraView *ztccv = [[ZTCameraView alloc] initWithFrame:CGRectMake(0, 0, 320, 200) DevicePosition:DevicePositionFront];
    [self.view addSubview:ztccv];
    self.cameraView = ztccv;
    
    UIButton *btn = [[UIButton alloc] init];
    [btn setTitle:@"拍照" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [btn setBackgroundColor:[UIColor greenColor]];
    btn.showsTouchWhenHighlighted = YES;
    [btn sizeToFit];
    [btn setFrame:CGRectMake(0, 220, btn.bounds.size.width, btn.bounds.size.height)];
    [btn addTarget:self action:@selector(takePhoto) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
    UIButton *btn1 = [[UIButton alloc] init];
    [btn1 setTitle:@"停止拍照" forState:UIControlStateNormal];
    [btn1 setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [btn1 setBackgroundColor:[UIColor greenColor]];
    btn1.showsTouchWhenHighlighted = YES;
    [btn1 sizeToFit];
    [btn1 setFrame:CGRectMake(100, 220, btn1.bounds.size.width, btn1.bounds.size.height)];
    [btn1 addTarget:self action:@selector(stopTakePhoto) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn1];
    
    UIButton *btn2 = [[UIButton alloc] init];
    [btn2 setTitle:@"停止拍照" forState:UIControlStateNormal];
    [btn2 setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [btn2 setBackgroundColor:[UIColor greenColor]];
    btn2.showsTouchWhenHighlighted = YES;
    [btn2 sizeToFit];
    [btn2 setFrame:CGRectMake(250, 220, btn2.bounds.size.width, btn2.bounds.size.height)];
    [btn2 addTarget:self action:@selector(changeCamera) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn2];
    
//    UIImageView *iv = [[UIImageView alloc] initWithFrame:CGRectMake(0, 350, 320, 100)];
//    [iv setBackgroundColor:[UIColor redColor]];
//    [self.view addSubview:iv];
//    self.imageView = iv;
}

-(void)takePhoto
{
    [self.cameraView shutterCameraWithBlock:^(UIImage *image, NSError *error) {
        if (error) {
            NSLog(@"收到error:%@",error.domain);
        }else{
            UIImageWriteToSavedPhotosAlbum(image,self,@selector(image:didFinishSavingWithError:contextInfo:),nil);
            NSData* data = UIImageJPEGRepresentation(image, 1.0);
            NSInteger dataSize = data.length/1000;
            NSLog(@"图片大小JPG:%d",dataSize);
            
            data = UIImagePNGRepresentation(image);
            dataSize = data.length/1000;
            NSLog(@"图片大小PNG:%d",dataSize);
        }
    }];
}

-(void)stopTakePhoto
{
    if (_cameraView.isRun == YES) {
        [_cameraView stop];
    }else{
        [_cameraView start];
    }
}

-(void)changeCamera
{
    [_cameraView toggleCamera];
}

- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo
{
    NSLog(@"哈哈 保存成功！！！");
}
@end
