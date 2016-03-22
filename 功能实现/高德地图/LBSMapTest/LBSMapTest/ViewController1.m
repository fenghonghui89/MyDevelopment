//
//  ViewController1.m
//  LBSMapTest
//
//  Created by 冯鸿辉 on 16/3/21.
//  Copyright © 2016年 DGC. All rights reserved.
//
/*
 info.plist
 NSLocationWhenInUseUsageDescription表示应用在前台的时候可以搜到更新的位置信息。
 NSLocationAlwaysUsageDescription表示应用在前台和后台（suspend或terminated)都可以获取到更新的位置数据。

 开启后台定位
 左侧目录中选中工程名，开启 TARGETS->Capabilities->Background Modes，在 Background Modes中勾选 Location updates，如下图所示：
 */



#define screenW [[UIScreen mainScreen] bounds].size.width
#define screenH [[UIScreen mainScreen] bounds].size.height
#import "ViewController1.h"
#import "ViewController2.h"
#import "CustomAnnotationView.h"
#import <MAMapKit/MAMapKit.h>
@interface ViewController1 ()
<
MAMapViewDelegate
>
@property(nonatomic,strong)MAMapView *mapView;
@end

@implementation ViewController1

#pragma mark - < vc lifecycle > -
- (void)viewDidLoad {
  [super viewDidLoad];
  
  self.edgesForExtendedLayout = UIRectEdgeNone;
}

-(void)viewDidAppear:(BOOL)animated{
  [super viewDidAppear:animated];
  
  [self customInitUI];
}

#pragma mark - < method > -
-(void)customInitUI{

  //注册 bundleid key 要跟控制台设置的一致
  [MAMapServices sharedServices].apiKey = @"6d89b5f59bc0a6865fd9b0e522b696dd";

  //添加地图
  self.mapView = [[MAMapView alloc] initWithFrame:CGRectMake(0, 0, screenW, self.view.bounds.size.height)];
  self.mapView.delegate = self;
  [self.view addSubview:self.mapView];
  
  
  UIButton *goToBtn = [[UIButton alloc] initWithFrame:CGRectMake(screenW-50, self.view.bounds.size.height-50, 50, 50)];
  [goToBtn setBackgroundColor:[UIColor blueColor]];
  [goToBtn setTitle:@"go" forState:UIControlStateNormal];
  [goToBtn setTintColor:[UIColor whiteColor]];
  [goToBtn addTarget:self action:@selector(goToBtnTap) forControlEvents:UIControlEventTouchUpInside];
  [self.view addSubview:goToBtn];
  
  
  //开启定位 显示定位图层
//  self.mapView.showsUserLocation = YES;
//  [self.mapView setUserTrackingMode:MAUserTrackingModeFollow];
  
  //自定义定位精度圈开关
  self.mapView.customizeUserLocationAccuracyCircleRepresentation = YES;
  
  //开启后台保持定位
  self.mapView.pausesLocationUpdatesAutomatically = NO;//指定定位是否会被系统自动暂停
  self.mapView.allowsBackgroundLocationUpdates = YES;//是否允许后台定位，iOS9以上系统必须配置
  
  //更改地图类型
  self.mapView.mapType = MAMapTypeStandard;
  
  //显示交通路况
  self.mapView.showTraffic = YES;
  
  //添加一个点
  MAPointAnnotation *pointAnnotation = [[MAPointAnnotation alloc] init];
//  pointAnnotation.coordinate = CLLocationCoordinate2DMake(39.989631, 116.481018);
  pointAnnotation.coordinate = CLLocationCoordinate2DMake(23.119944, 113.321090);
  pointAnnotation.title = @"自定义的title";
  pointAnnotation.subtitle = @"xxx大街";
  [self.mapView addAnnotation:pointAnnotation];
  [self.mapView setCenterCoordinate:CLLocationCoordinate2DMake(23.119944, 113.321090) animated:YES];//地图移动到该点
  [self.mapView setZoomLevel:19 atPivot:self.view.center animated:YES];//缩放
  
  //改变logo 指南针 比例尺
  self.mapView.showsCompass= YES; // 设置成NO表示关闭指南针；YES表示显示指南针
  self.mapView.compassOrigin= CGPointMake(_mapView.compassOrigin.x, 22); //设置指南针位置
}


#pragma mark - < action > -

-(void)goToBtnTap{
//  [self.mapView setCenterCoordinate:CLLocationCoordinate2DMake(23.119944, 113.321090) animated:YES];//地图移动到该点
//  [self.mapView setZoomLevel:19 atPivot:self.view.center animated:YES];//缩放
  
  __block UIImage *screenshotImage = nil;
  __block NSInteger resState = 0;
  [self.mapView takeSnapshotInRect:CGRectMake(0, 0, screenW, self.view.bounds.size.height) withCompletionBlock:^(UIImage *resultImage, NSInteger state) {
    screenshotImage = resultImage;
    resState = state; // state表示地图此时是否完整，0-不完整，1-完整
    
    ViewController2 *vc = [[ViewController2 alloc] initWithNibName:@"ViewController2" bundle:nil];
    vc.img = screenshotImage;
    [self.navigationController pushViewController:vc animated:YES];
  }];
}

#pragma mark - < callback > -
//取出当前位置的坐标
-(void)mapView:(MAMapView *)mapView didUpdateUserLocation:(MAUserLocation *)userLocation updatingLocation:(BOOL)updatingLocation{
  if(updatingLocation)
  {
    NSLog(@"latitude : %f,longitude: %f",userLocation.coordinate.latitude,userLocation.coordinate.longitude);
  }
}

//自定义定位精度圈
- (MAOverlayRenderer *)mapView:(MAMapView *)mapView rendererForOverlay:(id <MAOverlay>)overlay
{
  /* 自定义定位精度对应的MACircleView. */
  if (overlay == mapView.userLocationAccuracyCircle)
  {
    MACircleRenderer *accuracyCircleRenderer = [[MACircleRenderer alloc] initWithCircle:overlay];
    
    accuracyCircleRenderer.lineWidth    = 2.f;
    accuracyCircleRenderer.strokeColor  = [UIColor lightGrayColor];
    accuracyCircleRenderer.fillColor    = [UIColor colorWithRed:1 green:0 blue:0 alpha:.3];
    
    return accuracyCircleRenderer;
  }
  
  return nil;
}

//自定义定位标注样式
-(MAAnnotationView *)mapView:(MAMapView *)mapView viewForAnnotation:(id<MAAnnotation>)annotation{
  
  //自定义用户定位标注样式
//  if ([annotation isKindOfClass:[MAUserLocation class]])
//  {
//    static NSString *userLocationStyleReuseIndetifier = @"userLocationStyleReuseIndetifier";
//    MAAnnotationView *annotationView = [mapView dequeueReusableAnnotationViewWithIdentifier:userLocationStyleReuseIndetifier];
//    if (annotationView == nil)
//    {
//      annotationView = [[MAAnnotationView alloc] initWithAnnotation:annotation
//                                                    reuseIdentifier:userLocationStyleReuseIndetifier];
//    }
//    annotationView.image = [UIImage imageNamed:@"jiantou.jpg"];
//    
//    return annotationView;
//  }
//  return nil;
  
  
  //根据添加的标注数据 生成大头针标注
//  if ([annotation isKindOfClass:[MAPointAnnotation class]])
//  {
//    static NSString *pointReuseIndentifier = @"pointReuseIndentifier";
//    MAPinAnnotationView*annotationView = (MAPinAnnotationView*)[mapView dequeueReusableAnnotationViewWithIdentifier:pointReuseIndentifier];
//    if (annotationView == nil)
//    {
//      annotationView = [[MAPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:pointReuseIndentifier];
//    }
//    annotationView.canShowCallout= YES;       //设置气泡可以弹出，默认为NO
//    annotationView.animatesDrop = YES;        //设置标注动画显示，默认为NO
//    annotationView.draggable = YES;        //设置标注可以拖动，默认为NO
//    annotationView.pinColor = MAPinAnnotationColorPurple;
//    return annotationView;
//  }
//  return nil;

  //根据添加的标注数据 生成自定义标注（默认气泡）
//  if ([annotation isKindOfClass:[MAPointAnnotation class]])
//  {
//    static NSString *reuseIndetifier = @"annotationReuseIndetifier";
//    MAAnnotationView *annotationView = [mapView dequeueReusableAnnotationViewWithIdentifier:reuseIndetifier];
//    if (annotationView == nil)
//    {
//      annotationView = [[MAAnnotationView alloc] initWithAnnotation:annotation
//                                                    reuseIdentifier:reuseIndetifier];
//    }
//    annotationView.image = [UIImage imageNamed:@"jiantou.jpg"];
//    annotationView.canShowCallout= YES;       //设置气泡可以弹出，默认为NO
//    annotationView.draggable = YES;        //设置标注可以拖动，默认为NO
//
//    //设置中心点偏移，使得标注底部中间点成为经纬度对应点
//    annotationView.centerOffset = CGPointMake(0, -18);
//    return annotationView;
//  }
//  return nil;

  //根据添加的标注数据 生成自定义标注（自定义气泡）
  if ([annotation isKindOfClass:[MAPointAnnotation class]])
  {
    static NSString *reuseIndetifier = @"annotationReuseIndetifier";
    CustomAnnotationView *annotationView = (CustomAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:reuseIndetifier];
    if (annotationView == nil)
    {
      annotationView = [[CustomAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:reuseIndetifier];
    }
    annotationView.image = [UIImage imageNamed:@"jiantou.jpg"];
    
    // 设置为NO，用以调用自定义的calloutView
    annotationView.canShowCallout = NO;
    
    // 设置中心点偏移，使得标注底部中间点成为经纬度对应点
    annotationView.centerOffset = CGPointMake(0, -18);
    return annotationView;
  }
  return nil;
}


@end
