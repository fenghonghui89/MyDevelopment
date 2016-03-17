//
//  NKC_QRCode_VC.m
//  Tpages.Mall
//
//  Created by 冯鸿辉 on 16/3/16.
//  Copyright © 2016年 GoTravel. All rights reserved.
//

@import AVFoundation;
#import "MD_AVQRCode_VC.h"
#import "MDDefine.h"
#import "MDTool.h"
#import "Masonry.h"
@interface MD_AVQRCode_VC()<AVCaptureMetadataOutputObjectsDelegate>

@property(nonatomic,strong) UIView *bgView;
@property(nonatomic,strong) UIView *previewView;
@property(nonatomic,strong) UIView *overLayerView;
@property(nonatomic,strong) UIView *maskView;
@property(nonatomic,strong)AVCaptureSession *session;
@property(nonatomic,strong)AVCaptureDevice *device;
@end

@implementation MD_AVQRCode_VC

#pragma mark - < vc lifecycle > -

-(void)dealloc{
  [self.session stopRunning];
}

- (void)viewDidLoad {
  
  [super viewDidLoad];
  
}

-(void)viewDidAppear:(BOOL)animated{
  [super viewDidAppear:animated];
  
  [self customInitData];
  [self customInitUI];
  [self customInitCamera];
  [self.session startRunning];
}

-(void)viewDidDisappear:(BOOL)animated{
  [self.session stopRunning];
  [self.bgView removeFromSuperview];
}

#pragma mark - < method > -
-(void)customInitData{
  
  //session
  AVCaptureSession *session = [[AVCaptureSession alloc]init];
  [session setSessionPreset:AVCaptureSessionPresetHigh];//高质量采集率
  self.session = session;
  
  //device
  AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
  self.device = device;
}

-(void)customInitUI{
  [self customInitUIBase];
}


-(void)customInitUIBase{
  
  //bgview
  UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, viewW, viewH)];
  [self.view addSubview:bgView];
  self.bgView = bgView;
  
  //previewView
  UIView *previewView = [[UIView alloc] initWithFrame:bgView.bounds];
  [self.bgView addSubview:previewView];
  self.previewView = previewView;
  
  //previewLayer
  AVCaptureVideoPreviewLayer *previewLayer = [AVCaptureVideoPreviewLayer layerWithSession:self.session];
  
  CALayer *viewLayer = [self.previewView layer];
  viewLayer.masksToBounds = YES;
  [previewLayer setFrame:self.previewView.bounds];
  [previewLayer setVideoGravity:AVLayerVideoGravityResizeAspectFill];
  [viewLayer insertSublayer:previewLayer below:[[viewLayer sublayers] objectAtIndex:0]];
  
  //overlayerView
  UIView *overlayerView = [[UIView alloc] initWithFrame:bgView.bounds];
  [overlayerView setBackgroundColor:[UIColor blackColor]];
  [overlayerView setAlpha:0.5];
  [self.bgView addSubview:overlayerView];
  self.overLayerView = overlayerView;
  
  //maskView
  CGFloat w = screenW*0.7;
  CGFloat h = screenW*0.7;
  CGFloat x = (screenW - w)/2;
  CGFloat y = 100;
  UIView *maskView = [[UIView alloc] initWithFrame:CGRectMake(x, y, w, h)];
  [maskView setBackgroundColor:[UIColor clearColor]];
  [maskView setAlpha:0.3];
  [maskView.layer setBorderColor:[UIColor yellowColor].CGColor];
  [maskView.layer setBorderWidth:2];
  [self.bgView addSubview:maskView];
  self.maskView = maskView;
  
  //使截取框透明
  [self overlayClipping];
  
  //label
  UILabel *msgLabel = [[UILabel alloc] init];
  [msgLabel setText:@"将二维码放入框内，即可自动扫描"];
  [msgLabel setTextColor:[UIColor whiteColor]];
  [msgLabel sizeToFit];
  [self.bgView addSubview:msgLabel];
  [msgLabel mas_makeConstraints:^(MASConstraintMaker *make) {
    make.top.equalTo(self.maskView.mas_bottom).with.offset(20);
    make.centerX.mas_equalTo(self.maskView.mas_centerX);
  }];
}


- (void)overlayClipping
{
  CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
  CGMutablePathRef path = CGPathCreateMutable();
  
  // Left side of the ratio view
  CGPathAddRect(path, nil, CGRectMake(0,
                                      0,
                                      self.maskView.frame.origin.x,
                                      self.bgView.frame.size.height));
  
  // Right side of the ratio view
  CGPathAddRect(path, nil, CGRectMake(self.maskView.frame.origin.x + self.maskView.frame.size.width,
                                      0,
                                      self.bgView.frame.size.width - self.maskView.frame.origin.x - self.maskView.frame.size.width,
                                      self.bgView.frame.size.height));
  
  // Top side of the ratio view
  CGPathAddRect(path, nil, CGRectMake(0,
                                      0,
                                      self.bgView.frame.size.width,
                                      self.maskView.frame.origin.y));
  
  // Bottom side of the ratio view
  CGPathAddRect(path, nil, CGRectMake(0,
                                      self.maskView.frame.origin.y + self.maskView.frame.size.height,
                                      self.bgView.frame.size.width,
                                      self.bgView.frame.size.height - self.maskView.frame.origin.y - self.maskView.frame.size.height));
  
  maskLayer.path = path;
  self.overLayerView.layer.mask = maskLayer;
  CGPathRelease(path);
}

-(void)customInitCamera{
  
#pragma 创建输入流
  AVCaptureDeviceInput *input = [AVCaptureDeviceInput deviceInputWithDevice:self.device error:nil];
  [self.session addInput:input];
  
#pragma 创建输出流
  AVCaptureMetadataOutput *output = [[AVCaptureMetadataOutput alloc]init];
  
  //设置代理 在主线程里刷新
  [output setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
  
  //要先加入到session
  [self.session addOutput:output];
  
  //再设置扫码支持的编码格式
  [output setMetadataObjectTypes:@[AVMetadataObjectTypeQRCode]];
  
  //设置响应范围 CGRectMake(Y,X,H,W) 1代表最大值  原点是navi右下角 往左往下为正
  CGFloat y = self.maskView.frame.origin.y/self.bgView.bounds.size.height;
  CGFloat x = (self.bgView.bounds.size.width-self.maskView.frame.origin.x-self.maskView.frame.size.width)/self.bgView.bounds.size.width;
  CGFloat h = self.maskView.frame.size.height/self.bgView.bounds.size.height;
  CGFloat w = self.maskView.frame.size.width/self.bgView.bounds.size.width;
  [output setRectOfInterest:CGRectMake(y,x,h,w)];
  
}

#pragma mark - < callback > -
-(void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection{
  if (metadataObjects.count>0) {
    AVMetadataMachineReadableCodeObject * metadataObject = [metadataObjects objectAtIndex : 0 ];
    NSLog(@"%@",metadataObject.stringValue);
  }
}

@end
