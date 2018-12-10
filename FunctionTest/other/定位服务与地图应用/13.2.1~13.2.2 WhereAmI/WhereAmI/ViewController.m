//
//  ViewController.m
//  WhereAmI
//
//  Created by 关东升 on 13-1-6.
//  Copyright (c) 2013年 eorient. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _mapView.mapType = MKMapTypeStandard;
    _mapView.delegate = self;
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}


- (IBAction)geocodeQuery:(id)sender
{
    if (_txtQueryKey.text == nil || [_txtQueryKey.text length] == 0) {
        return;
    }
    
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    [geocoder geocodeAddressString:_txtQueryKey.text completionHandler:^(NSArray *placemarks, NSError *error) {
        
        NSLog(@"查询记录数：%i",[placemarks count]);
        
        //编码成功则移除所有标注点
        if ([placemarks count] > 0) {
            [_mapView removeAnnotations:_mapView.annotations];
        }
        
        for (int i = 0; i < [placemarks count]; i++) {
            
            CLPlacemark* placemark = placemarks[i];
            
            //关闭键盘
            [_txtQueryKey resignFirstResponder];
            
            /*
             调整地图位置和缩放比例
             */
            
            //方式1
            //地图区域：中心点、南北跨度（米）、东西跨度（米）-影响缩放
            MKCoordinateRegion viewRegion = MKCoordinateRegionMakeWithDistance(placemark.location.coordinate, 100, 100);
            //重设显示区域，使地图有飞过去的效果
            [_mapView setRegion:viewRegion animated:YES];
            
            //方式2
//            //创建一个显示范围
//            MKCoordinateSpan span;
//            span.latitudeDelta = 0.01;
//            span.longitudeDelta = 0.01;
//            //把经纬度和范围 设置给地图对象
//            [_mapView setRegion:MKCoordinateRegionMake(placemark.location.coordinate, span)];
            

            /*
             设置地图标注信息实体
             */
            
            //系统提供的地图标注信息实体类
            //MKPointAnnotation *aaa = [[MKPointAnnotation alloc] init];
            //aaa.coordinate = placemark.location.coordinate;
            
            //设置 自定义的地图标注信息实体
            MapLocation *annotation = [[MapLocation alloc] init];
            annotation.streetAddress = placemark.thoroughfare;
            annotation.city = placemark.locality;
            annotation.state = placemark.administrativeArea;
            annotation.zip = placemark.postalCode;
            annotation.coordinate = placemark.location.coordinate;
 
            //把标注点添加到地图中
            [_mapView addAnnotation:annotation];
        }
    }];

}

#pragma mark Map View Delegate Methods

//在地图添加标注时回调
- (MKAnnotationView *) mapView:(MKMapView *)theMapView viewForAnnotation:(id <MKAnnotation>) annotation
{
	//获取可重用的地图标注对象，如果没有则创建
	MKPinAnnotationView *annotationView = (MKPinAnnotationView *)[_mapView dequeueReusableAnnotationViewWithIdentifier:@"PIN_ANNOTATION"];
    
	if(annotationView == nil) {
		annotationView = [[MKPinAnnotationView alloc] initWithAnnotation:annotation  reuseIdentifier:@"PIN_ANNOTATION"];
	}
    
	annotationView.pinColor = MKPinAnnotationColorPurple;//大头针的颜色
	annotationView.animatesDrop = YES;//动画效果
	annotationView.canShowCallout = YES;//显示附加信息
	
	return annotationView;
}

@end
