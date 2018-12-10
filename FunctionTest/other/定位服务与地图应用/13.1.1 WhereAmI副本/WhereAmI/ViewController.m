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

    //判断是否开启了位置服务
    if ([CLLocationManager locationServicesEnabled]) {
        //设置定位
        _locationManager = [[CLLocationManager alloc] init];
        _locationManager.delegate = self;
        _locationManager.desiredAccuracy = kCLLocationAccuracyBest;
        _locationManager.distanceFilter = 1000.0f;
        
        //设置地图
        _myMapView.showsUserLocation = YES;
        [_myMapView setUserTrackingMode:MKUserTrackingModeFollow animated:YES];
        _myMapView.delegate = self;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [_locationManager startUpdatingLocation];
    [_locationManager startUpdatingHeading];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
    [_locationManager stopUpdatingLocation];
    [_locationManager stopUpdatingHeading];
}

#pragma mark - Core Location委托方法用于实现位置的更新
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    //通过定位获取位置
    CLLocation *currLocation = [locations lastObject];
    _txtLng.text = [NSString stringWithFormat:@"%3.5f",currLocation.coordinate.longitude];//经度
	_txtLat.text = [NSString stringWithFormat:@"%3.5f",currLocation.coordinate.latitude];//纬度
    _txtAlt.text = [NSString stringWithFormat:@"%3.5f",currLocation.altitude];//高度
    
    //设置地图显示范围
    //方式1：（正常）
    MKCoordinateSpan span;
    span.latitudeDelta = 0.01;
    span.longitudeDelta = 0.01;
    [_myMapView setRegion:MKCoordinateRegionMake(currLocation.coordinate, span)];
    
    //方式2：（地图不缩小，算有问题？）
//    MKCoordinateRegion viewRegion = MKCoordinateRegionMakeWithDistance(currLocation.coordinate, 1000, 1000);
//    [_myMapView setRegion:viewRegion animated:YES];
}


-(void)locationManager:(CLLocationManager *)manager didUpdateHeading:(CLHeading *)newHeading
{
    _txtHead.text = [NSString stringWithFormat:@"%3.5f",newHeading.trueHeading];
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    NSLog(@"error: %@",error);
}

#pragma mark - Map View Delegate Methods
- (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation
{
    _myMapView.centerCoordinate = userLocation.location.coordinate;
}

- (void)mapViewDidFailLoadingMap:(MKMapView *)theMapView withError:(NSError *)error
{
    NSLog(@"error : %@",[error description]);
}

@end
