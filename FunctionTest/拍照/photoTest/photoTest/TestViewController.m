//
//  TestViewController.m
//  photoTest
//
//  Created by 冯鸿辉 on 15/11/20.
//  Copyright © 2015年 MD. All rights reserved.
//

#import "TestViewController.h"
#import "ZTCameraView.h"
#import "Test2ViewController.h"
@interface TestViewController ()
@property (weak, nonatomic) IBOutlet UIView *photobgview;
@property (weak, nonatomic) IBOutlet UIView *bgview;
@property(nonatomic,strong)ZTCameraView *cameraView;
@property(nonatomic,strong)UIImageView *imageView;
@property(nonatomic,strong)UIImage *img;
@end

@implementation TestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewDidAppear:(BOOL)animated
{
  [super viewDidAppear:animated];
  [self customInitUI];
}

-(void)customInitUI
{
  [self.view setBackgroundColor:[UIColor whiteColor]];
  self.navigationController.navigationBar.translucent = NO;
  
  CGRect rect = self.photobgview.bounds;
  ZTCameraView *ztccv = [[ZTCameraView alloc] initWithFrame:rect DevicePosition:DevicePositionBack];
  ztccv.isSaveMask = YES;
  [self.view addSubview:ztccv];
  self.cameraView = ztccv;
  
}

- (IBAction)takephoto:(id)sender {
  [self.cameraView shutterCameraWithBlock:^(UIImage *image, NSError *error) {
    if (error) {
      NSLog(@"收到error:%@",error.domain);
    }else{
//      CGRect rect1 = [[UIScreen mainScreen] bounds];
//      rect1.origin.x = 10;
//      rect1.origin.y = 10;
//      rect1.size.width = rect1.size.width-20;
//      rect1.size.height = rect1.size.height-20-44-20;
//      UIImageView *iv = [[UIImageView alloc] initWithImage:image];
//      [iv setBackgroundColor:[UIColor orangeColor]];
//      [iv setFrame:rect1];
//      iv.contentMode = UIViewContentModeScaleAspectFit;
//      [self.view addSubview:iv];
//      self.imageView = iv;
//      
//      UITapGestureRecognizer *tapGR = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap11:)];
//      [iv setUserInteractionEnabled:YES];
//      [iv addGestureRecognizer:tapGR];

      
      NSData *imgdata = UIImageJPEGRepresentation(image, 0.3);
      UIImage *newImg = [UIImage imageWithData:imgdata];
      
      self.img = newImg;
      UIImageWriteToSavedPhotosAlbum(newImg,self,@selector(image:didFinishSavingWithError:contextInfo:),nil);
//      //保存图片
//      NSArray *newZipPaths=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
//      NSString *newZipPath=[newZipPaths[0] stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.jpg",@"test"]];
//      NSLog(@"newZipPath %@",newZipPath);
//      //    NSString *newZipPath = [NSString stringWithFormat:@"%@/Documents/%@.jpg",NSHomeDirectory(),imageName];
//      
//      NSFileManager *manager=[NSFileManager defaultManager];
//      [manager createFileAtPath:newZipPath contents:imgdata attributes:nil];


    }
  }];
}
- (IBAction)stop:(id)sender {
  if (_cameraView.isRun == YES) {
    [_cameraView stop];
  }else{
    [_cameraView start];
  }

}

- (IBAction)change:(id)sender {
  [_cameraView toggleCamera];

}
- (IBAction)goto:(id)sender {
  Test2ViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"Test2ViewController"];
  vc.img = self.img;
  [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - < callback > -
- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo
{
  NSLog(@"保存到相册成功");
}

-(void)performSegueWithIdentifier:(NSString *)identifier sender:(id)sender
{
  if ([identifier isEqualToString:@"totest2"]) {
    Test2ViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"Test2ViewController"];
    vc.img = self.img;
  }
}
@end
