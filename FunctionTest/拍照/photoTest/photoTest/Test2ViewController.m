//
//  Test2ViewController.m
//  photoTest
//
//  Created by 冯鸿辉 on 15/11/20.
//  Copyright © 2015年 MD. All rights reserved.
//

#import "Test2ViewController.h"
#import "AGSimpleImageEditorView.h"
@interface Test2ViewController ()
@property (weak, nonatomic) IBOutlet UIView *bgview;
@property (weak, nonatomic) IBOutlet UIView *photoview;
@property(nonatomic,strong)AGSimpleImageEditorView *agsview;
@end

@implementation Test2ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

-(void)viewDidAppear:(BOOL)animated
{
  [super viewDidAppear:animated];
  [self customInitUI];
}

-(void)customInitUI
{
  NSArray *newZipPaths=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
  NSString *newZipPath=[newZipPaths[0] stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.jpg",@"test"]];
  
  UIImage *img = [UIImage imageWithContentsOfFile:newZipPath];
  
  CGRect rect = self.photoview.bounds;
  UIView *editv = [[UIView alloc] initWithFrame:rect];
  [editv setBackgroundColor:[UIColor whiteColor]];
  [self.view addSubview:editv];
  
  AGSimpleImageEditorView *editorView = [[AGSimpleImageEditorView alloc] initWithImage:self.img];
  editorView.frame = editv.bounds;
  [editv addSubview:editorView];
  self.agsview = editorView;
  
  //外边框的宽度及颜色
  editorView.borderWidth = 5.f;
  editorView.borderColor = [UIColor redColor];
  
  //截取框的宽度及颜色
  editorView.ratioViewBorderWidth = 5.f;
  editorView.ratioViewBorderColor = [UIColor orangeColor];
  
  //截取比例，我这里按正方形1:1截取（可以写成 3./2. 16./9. 4./3.）
  editorView.ratio = 4./3.;
  
  

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
  UIImage *resultImage = self.agsview.output;
  
  //把图片保存到相册当中
  UIImageWriteToSavedPhotosAlbum(resultImage, self, @selector(image:didFinishSavingWithError:contextInfo:), Nil);
}

#pragma mark - < callback > -
- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo
{
  NSLog(@"保存到相册成功");
}
@end
