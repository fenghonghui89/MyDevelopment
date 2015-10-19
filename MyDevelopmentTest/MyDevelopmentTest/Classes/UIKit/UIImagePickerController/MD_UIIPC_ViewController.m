//
//  MD_UIIPC_ViewController.m
//  MyDevelopmentTest
//
//  Created by hanyfeng on 15/6/9.
//  Copyright (c) 2015年 hanyfeng. All rights reserved.
//

#import "MD_UIIPC_ViewController.h"

@interface MD_UIIPC_ViewController ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate>
@property (nonatomic,strong ) UIView         * v;
@property (nonatomic,strong ) UIScrollView   * sv;
@property (nonatomic, strong) NSMutableArray *images;
@property (strong, nonatomic) UIView         *editView;
@property (nonatomic, strong) UIImageView    *dragIV;
@property (nonatomic,strong) UIImagePickerController *ipc;
@end



@implementation MD_UIIPC_ViewController

#pragma mark - < vc cycle > -
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self customInitUI];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    //创建存放图片的scrollView
    UIScrollView *sv = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, viewW, 80)];
    [sv setBackgroundColor:[UIColor purpleColor]];
    [sv setContentSize:CGSizeMake(self.images.count*80, 0)];
    [self.view addSubview:sv];
    
    //从数组中取出图片添加到scrollView
    for (int i=0; i<self.images.count; i++) {
        
        UIImageView *iv = [[UIImageView alloc]initWithFrame:CGRectMake(i*80, 0, 80, 80)];
        iv.image = [self.images objectAtIndex:i];
        iv.userInteractionEnabled = YES;//图片里面有手势，所以图片要开启交互
        [sv addSubview:iv];
        
        //添加拖动手势到图片
        UILongPressGestureRecognizer *lpgr = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(longAction:)];
        [iv addGestureRecognizer:lpgr];
    }
}

#pragma mark init
-(void)customInitUI
{
    UIView *editView = [[UIView alloc] init];
    [editView setBackgroundColor:[UIColor grayColor]];
    [editView setFrame:[MDTool setRectX:10 y:80+10 w:viewW-20 h:viewH-80-10-10-30-10]];
    [editView setClipsToBounds:YES];
    self.editView = editView;
    [self.view addSubview:editView];
    
    CGFloat y = viewH-40;
    UIButton *btn = [[UIButton alloc] initWithFrame:[MDTool setRectX:10 y:y w:100 h:30]];
    [btn setTitle:@"获取相册" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [btn setBackgroundColor:[UIColor greenColor]];
    [btn addTarget:self action:@selector(getPhoto) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];

    CGFloat x = screenW-10-100;
    UIButton *btn2 = [[UIButton alloc] initWithFrame:[MDTool setRectX:x y:y w:100 h:30]];
    [btn2 setTitle:@"生成图片" forState:UIControlStateNormal];
    [btn2 setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [btn2 setBackgroundColor:[UIColor greenColor]];
    [btn2 addTarget:self action:@selector(createImage) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn2];
}

#pragma mark - < action > -
//获取相册
-(void)getPhoto
{
    self.images = [NSMutableArray array];
    UIImagePickerController *ipc = [[UIImagePickerController alloc]init];
    [ipc setSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
//    [ipc setSourceType:UIImagePickerControllerSourceTypeCamera];
    ipc.delegate = self;
    _ipc = ipc;
    [self presentViewController:ipc animated:YES completion:Nil];
}

//生成图片
-(void)createImage
{
    UIGraphicsBeginImageContext(self.editView.bounds.size);//创建一个画布
    [self.editView.layer renderInContext:UIGraphicsGetCurrentContext()];//把内容渲染到画布当中
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext(); //从画布中取到图片
    UIImageWriteToSavedPhotosAlbum(image, self, @selector(image:didFinishSavingWithError:contextInfo:), Nil);//把图片保存到相册当中
}

//被选中的图片的删除按钮——删除滚动栏上被点击的图片，后面的图片往前移动
//利用删除数组中其中一个元素后，后面的元素下标会自动往前移
-(void)deleteImage:(UIButton*)btn
{
    //从数组中删除所点击的图片（后面的图片的下标会自动往前移）
    [self.images removeObjectAtIndex:btn.tag];
    
    //先把subviews中的所有view删除掉（否则图片会重复）
    for (UIView *iv in _sv.subviews) {
        [iv removeFromSuperview];
    }
    
    //再把数组中的图片重新放入到scrollView中
    for (int i=0; i<self.images.count; i++) {
        UIImageView *iv = [[UIImageView alloc]initWithFrame:CGRectMake(i*80, 0, 80, 80)];
        iv.image = self.images[i];
        iv.userInteractionEnabled = YES;
        [_sv addSubview:iv];
        
        //给数组中的图片重新添加删除按钮
        UIButton *delBtn = [[UIButton alloc]initWithFrame:CGRectMake(60, 0, 20, 20)];
        delBtn.tag = i;
        [delBtn setBackgroundColor:[UIColor blackColor]];
        [delBtn setTitle:@"X" forState:UIControlStateNormal];
        [delBtn addTarget:self action:@selector(deleteImage:) forControlEvents:UIControlEventTouchUpInside];
        [iv addSubview:delBtn];
    }
}

//滚动栏上的返回按钮
- (void)backAction
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark 手势
//手势响应的方法(点击是没有反应的，长按才有反应)
-(void)longAction:(UILongPressGestureRecognizer*)lpgr
{
    UIImageView *iv = (UIImageView*)lpgr.view;//手势.view就是手势的容器（这里是imageView），但要转型（因为返回的是UIView类型）
    CGPoint p = [lpgr locationInView:self.view];//取得当前点击的坐标
    
    //按照手势的状态进行switch选择·
    switch ((int)lpgr.state) {
            
            //点击图片时新建图片，并加入到当前view
        case UIGestureRecognizerStateBegan:
        {
            _dragIV = [[UIImageView alloc]initWithFrame:iv.frame];
            _dragIV.image = iv.image;
            [self.view addSubview:_dragIV];
        }
            break;
            
            //移动时，把图片的重点赋值给当前相对于self.view的坐标
        case UIGestureRecognizerStateChanged:
        {
            if (self.dragIV) {
                self.dragIV.center = p;
            }
        }
            break;
            
            //手势结束
        case UIGestureRecognizerStateEnded:
        {
            //方法1：
            //            if (CGRectContainsPoint(_editView.frame, p)) {//判断是否在某个view的frame内
            //                //把相对于self.view的一点坐标转换到相对于ediView的坐标
            //                CGPoint center = self.dragIV.center;
            //                CGPoint newCenter = [self.view convertPoint:center toView:self.editView];
            //                self.dragIV.center = newCenter;
            //                self.dragIV.userInteractionEnabled = YES;
            //                [self addGestures];//添加手势
            //                [_editView addSubview:self.dragIV];
            //            }else{//如果不在frame内，移除图片
            //                [_dragIV removeFromSuperview];
            //            }
            
            //方法2：（更好）
            if (self.dragIV) {
                if (CGRectContainsPoint(_editView.frame, p)) {//判断是否在某个view的frame内
                    //把相对于self.view的一点坐标转换到相对于ediView的坐标
                    CGPoint center = self.dragIV.center;
                    CGPoint newCenter = [self.view convertPoint:center toView:self.editView];
                    self.dragIV.center = newCenter;
                    self.dragIV.userInteractionEnabled = YES;
                    [self addGestures];//添加手势
                    [_editView addSubview:self.dragIV];
                }else{//如果不在frame内，移除图片
                    [_dragIV removeFromSuperview];
                }
            }
            
        }
            break;
    }
}

/*-------------------------手势识别-----------------------------------------*/

-(void)addGestures
{
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(panAction:)];
    UIPinchGestureRecognizer *pinch = [[UIPinchGestureRecognizer alloc]initWithTarget:self action:@selector(pinchAction:)];
    UIRotationGestureRecognizer *rotation = [[UIRotationGestureRecognizer alloc]initWithTarget:self action:@selector(rotationAction:)];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction:)];
    
    [self.dragIV addGestureRecognizer:tap];
    [self.dragIV addGestureRecognizer:pan];
    [self.dragIV addGestureRecognizer:pinch];
    [self.dragIV addGestureRecognizer:rotation];
}

//点击
-(void)tapAction:(UITapGestureRecognizer*)tap
{
    [self.editView bringSubviewToFront:tap.view];//把子View放到最前端显示
}

//移动
-(void)panAction:(UIPanGestureRecognizer*)pan
{
    CGPoint p = [pan locationInView:self.editView];
    UIImageView *iv = (UIImageView*)pan.view;
    switch (pan.state) {
        case UIGestureRecognizerStateChanged:
            iv.center = p;
            break;
        default:
            break;
    }
}

//缩放
-(void)pinchAction:(UIPinchGestureRecognizer*)pinch
{
    //方法1：（刘国斌）
    UIImageView *iv = (UIImageView*)pinch.view;
    float scale = pinch.scale;
    [iv setTransform:CGAffineTransformScale(iv.transform, scale, scale)];
    pinch.scale = 1;
    
    //方法2：（赵哲）
    //    UIImageView *iv = (UIImageView*)pinch.view;
    //    CGAffineTransform transform = iv.transform;
    //    transform = CGAffineTransformScale(transform, pinch.scale, pinch.scale);
    //    iv.transform = transform;
    //    pinch.scale = 1;
}

//旋转
-(void)rotationAction:(UIRotationGestureRecognizer*)rotation
{
    //方法1：（刘国斌）
    UIImageView *iv = (UIImageView*)rotation.view;
    [iv setTransform:CGAffineTransformRotate(iv.transform, rotation.rotation)];
    rotation.rotation = 0;
    
    //方法2：（赵哲）
    //    UIImageView *iv = (UIImageView*)rotation.view;
    //    CGAffineTransform transform = iv.transform;
    //    transform = CGAffineTransformRotate(transform, rotation.rotation);
    //    iv.transform = transform;
    //    rotation.rotation = 0;
}

#pragma mark - < callback > -
//保存图片时用到的方法
- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo
{
    NSLog(@"哈哈 保存成功！！！");
}

#pragma mark imagePickerController delegate
//点击相册中的图片后
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info;
{
    NSLog(@"点击相册中的图片！！！");
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
    
    /*
     如果是拍照，暂时无法做到拍照后返回到拍照页面，只能在这里dismiss后再弹出
     */
}

//协议方法：相册右上角的删除按钮
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self dismissViewControllerAnimated:YES completion:nil];
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
    
    _v = [[ UIView alloc]initWithFrame:CGRectMake(0, _ipc.view.frame.size.height-100, viewW, 100)];
    _v.backgroundColor = [UIColor redColor];
    _sv = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 20, viewW, 80)];
    
    [_sv setBackgroundColor:[UIColor blueColor]];
    [_v addSubview:_sv];
    [viewController.view addSubview:_v];
    
    //给滚动栏添加返回按钮
    UIButton *backBtn = [[UIButton alloc]initWithFrame:CGRectMake(220, 0, 100, 20)];
    [backBtn setTitle:@"Done" forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
    [self.v addSubview:backBtn];
}
@end
