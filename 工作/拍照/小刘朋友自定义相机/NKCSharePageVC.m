//
//  NKCSharePageVC.m
//  TpagesS
//
//  Created by KongNear on 15/9/15.
//  Copyright (c) 2015年 NearKong. All rights reserved.
//

#define NKCSharePhoto 3001

#import "NKCSharePageVC.h"
#import "ZTCameraView.h"
@interface NKCSharePageVC () <UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIActionSheetDelegate>
@property (nonatomic, weak) IBOutlet UIImageView *imageView;
@property (strong, nonatomic) NSMutableArray *dataArray;

@end

@implementation NKCSharePageVC
{
    ZTCameraView*ztc;
}

#pragma mark - Class Load Method
- (void)viewDidLoad {
    [super viewDidLoad];
    self.dataArray=[NSMutableArray array];

    // Do any additional setup after loading the view.
//    [self takePictureWithCamera:TRUE];
    
    UIView*view=[[UIView alloc]init];
    view.frame=CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    view.backgroundColor=[UIColor blackColor];
    view.alpha=0.8;
    [self.view addSubview:view];
    
    UIButton*TakePhoto=[UIButton buttonWithType:UIButtonTypeCustom];
    TakePhoto.frame=CGRectMake((self.view.frame.size.width-40)/2-5, 500, 50, 50);
    TakePhoto.backgroundColor=[UIColor whiteColor];
    TakePhoto.layer.masksToBounds=YES;
    TakePhoto.layer.cornerRadius=24;
    [TakePhoto addTarget:nil action:@selector(action) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:TakePhoto];
    
    ztc=[[ZTCameraView alloc]initWithFrame:CGRectMake(10, 68, self.view.frame.size.width-20, self.view.frame.size.height-250) DevicePosition:DevicePositionBack];
    [self.view addSubview:ztc];

    for (int j=0; j<5; j++) {
    UIButton*btn=[UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame=CGRectMake(20+70*j, 560, 50, 50);
    btn.layer.borderWidth=2;
    btn.layer.borderColor=[[UIColor whiteColor] CGColor];
        [btn addTarget:nil action:@selector(aaa) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
       
    }
}
-(void)aaa{
    NSLog(@"dd");
}

#pragma mark - Bar Button Item
- (IBAction)retakePicture:(UIBarButtonItem *)sender {
    UIActionSheet *myActionSheet = [[UIActionSheet alloc] initWithTitle:nil
                                                               delegate:self
                                                      cancelButtonTitle:@"Cancel"
                                                 destructiveButtonTitle:nil
                                                      otherButtonTitles:@"Using Camera", @"Form Photo Library", nil];
    
    myActionSheet.tag = NKCSharePhoto;
    [myActionSheet showInView:self.view];

}


#pragma mark - Private Method
- (void)takePictureWithCamera:(BOOL)usingCamera
{
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];

    if (usingCamera && [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
    }
    else {
        imagePicker.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
    }
    
    imagePicker.delegate = self;
    
    [self presentViewController:imagePicker animated:YES completion:NULL];
}


#pragma mark - UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    // Get picked image from info dictionary
    UIImage *image = info[UIImagePickerControllerOriginalImage];
    picker.sourceType =UIImagePickerControllerSourceTypePhotoLibrary;
    // Put that image onto the screen in our image view
    self.imageView.image = image;
//    picker.sourceType =    UIImagePickerControllerSourceTypeSavedPhotosAlbum;
    // Dismiss the modal image picker
    picker.allowsEditing=YES;

    [self dismissViewControllerAnimated:YES completion:NULL];
//    picker.allowsImageEditing=YES;
    
}




- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    NSLog(@"取消了选择图片");
    [self dismissViewControllerAnimated:YES completion:NULL];
}




#pragma mark - UIActionSheetDelegate
- (void)actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex{
    //呼出的菜单按钮点击后的响应
    if (buttonIndex == actionSheet.cancelButtonIndex)
    {
        NSLog(@"取消");
        return;
    }
    if (actionSheet.tag == NKCSharePhoto) {
        switch (buttonIndex)
        {
            case 0:  //打开照相机拍照
//                [self takePictureWithCamera:TRUE];
//                [self openCamera];
//                [ztc  start];
                break;
                
            case 1:  //打开本地相册
                [self takePictureWithCamera:FALSE];
//                [self openPics];

                break;
        }
    }
}


int i=0;
-(void)action{
    
    //    i=0;
    if (i<5) {
        [ztc shutterCameraWithBlock:^(UIImage *image, NSError *error) {
            if (error) {
                NSLog(@"error。。%@",error.domain);
            }
            if(i==0) {
                
                UIImageView*imageView=[[UIImageView alloc]initWithImage:image];
                imageView.frame=CGRectMake(20, 560, 50, 50);
                [self.view addSubview:imageView];
                

                
            }
            else if (i==1){
                UIImageView*imageView2=[[UIImageView alloc]initWithImage:image];
                imageView2.frame=CGRectMake(90, 560, 50, 50);
                
                [self.view addSubview:imageView2];
            }
            else if (i==2){
                UIImageView*imageView3=[[UIImageView alloc]initWithImage:image];
                imageView3.frame=CGRectMake(160, 560, 50, 50);
                
                [self.view addSubview:imageView3];
            }
            else if (i==3){
                UIImageView*imageView4=[[UIImageView alloc]initWithImage:image];
                imageView4.frame=CGRectMake(230, 560, 50, 50);
                
                [self.view addSubview:imageView4];
            }
            else if (i==4){
                UIImageView*imageView5=[[UIImageView alloc]initWithImage:image];
                imageView5.frame=CGRectMake(300, 560, 50, 50);
                [self.view addSubview:imageView5];
            }
            
            i++;
        }];
        
        NSLog(@"i++==%d",i);
    }
    
    //    ccController*cc=[[ccController alloc]init];
    //    [self presentViewController:cc animated:YES completion:nil];
    
}

/** 弃用此方法，因为 iOS8 中，不能同时显示2个视图。iOS7无此问题
 *  改为使用- (void)actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex 代替
 *  报错如下：Warning: Attempt to present <UIImagePickerController: 0x7faadb886600>  on <NKCSharePageVC: 0x7faadac73e10> which is already presenting (null)
 *  参考此网站：http://www.th7.cn/Program/IOS/201411/310108.shtml
 */
//- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
//    if (buttonIndex == actionSheet.cancelButtonIndex)
//    {
//        NSLog(@"取消");
//        return;
//    }
//    if (actionSheet.tag == NKCSharePhoto) {
//        switch (buttonIndex)
//        {
//            case 0:  //打开照相机拍照
//                [self takePictureWithCamera:TRUE];
//                break;
//                
//            case 1:  //打开本地相册
//                [self takePictureWithCamera:FALSE];
//                break;
//        }
//    }
//}

@end
