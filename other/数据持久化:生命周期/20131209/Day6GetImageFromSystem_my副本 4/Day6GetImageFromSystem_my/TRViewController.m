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
@property(nonatomic,strong)UIScrollView* sv;
@property (nonatomic, strong)NSMutableArray *images;

@end

@implementation TRViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.images = [NSMutableArray array];//初始化数组
}

//进入相册按钮
- (IBAction)click:(UIButton *)sender
{
    UIImagePickerController *ipc = [[UIImagePickerController alloc]init];
    [ipc setSourceType:UIImagePickerControllerSourceTypeSavedPhotosAlbum];
    ipc.delegate = self;
    [self presentViewController:ipc animated:YES completion:Nil];
}

//协议方法：点击相册中的图片后
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info;
{
    UIImage *image = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
    UIImageView *iv = [[ UIImageView alloc]initWithFrame:CGRectMake(self.images.count *80, 0, 80, 80)];
    iv.userInteractionEnabled = YES;
    iv.image = image;
    [self.sv addSubview:iv];
    [self.sv setContentSize:CGSizeMake(80*self.images.count, 0)];
    
    //给选中的图片删除按钮（需要传参，参数类型是UIButton）
    UIButton *delBtn = [[UIButton alloc]initWithFrame:CGRectMake(60, 0, 20, 20)];
    delBtn.tag = self.images.count;
    [delBtn setBackgroundColor:[UIColor blackColor]];
    [delBtn setTitle:@"X" forState:UIControlStateNormal];
    [delBtn addTarget:self action:@selector(deleteImage:) forControlEvents:UIControlEventTouchUpInside];
    [iv addSubview:delBtn];
    
    [self.images addObject:image];
}

//被选中的图片的删除按钮——删除滚动栏上被点击的图片，后面的图片往前移动
//利用删除数组中其中一个元素后，后面的元素下标会自动往前移
-(void)deleteImage:(UIButton*)btn
{
    //从数组中删除所点击的图片（后面的图片的下标会自动往前移）
    [self.images removeObjectAtIndex:btn.tag];

    //先把subviews中的所有view删除掉（否则图片会重复）
    for (UIView *iv in self.sv.subviews) {
        [iv removeFromSuperview];
    }
    
    //再把数组中的图片重新放入到scrollView中
    for (int i=0; i<self.images.count; i++) {
        UIImageView *iv = [[UIImageView alloc]initWithFrame:CGRectMake(i*80, 0, 80, 80)];
        iv.image = self.images[i];
        iv.userInteractionEnabled = YES;
        [self.sv addSubview:iv];
        
        //给数组中的图片重新添加删除按钮
        UIButton *delBtn = [[UIButton alloc]initWithFrame:CGRectMake(60, 0, 20, 20)];
        delBtn.tag = i;
        [delBtn setBackgroundColor:[UIColor blackColor]];
        [delBtn setTitle:@"X" forState:UIControlStateNormal];
        [delBtn addTarget:self action:@selector(deleteImage:) forControlEvents:UIControlEventTouchUpInside];
        [iv addSubview:delBtn];
    }
}

//协议方法：相册右上角的删除按钮
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

//协议方法：相册将要显示
- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    
}

//协议方法：相册已经显示
- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    self.v = [[ UIView alloc]initWithFrame:CGRectMake(0, 300, 320, 100)];
    self.v.backgroundColor = [UIColor redColor];
    
    self.sv = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 20, 320, 80)];
//      [self.sv setShowsHorizontalScrollIndicator:NO];
//      [self.sv setShowsVerticalScrollIndicator:NO];
    
    [self.sv setBackgroundColor:[UIColor blueColor]];
    [self.v addSubview:self.sv];
    [viewController.view addSubview:self.v];
    
    //给滚动栏添加返回按钮
    UIButton *backBtn = [[UIButton alloc]initWithFrame:CGRectMake(220, 0, 100, 20)];
    [backBtn setTitle:@"Done" forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
    [self.v addSubview:backBtn];
}

//滚动栏上的返回按钮
- (void)backAction
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
