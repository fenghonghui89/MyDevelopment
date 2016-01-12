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
    
    //定位服务管理对象初始化
    _locationManager = [[CLLocationManager alloc] init];
    _locationManager.delegate = self;
    
    if([CLLocationManager headingAvailable]){}
    
    //判断用户是否是否授权、ios版本
    if ([CLLocationManager authorizationStatus]<3) {
        if ([[[UIDevice currentDevice] systemVersion] floatValue]>=8.0) {
            [_locationManager performSelector:@selector(requestAlwaysAuthorization) withObject:nil];
        }else{
            [_locationManager startUpdatingLocation];//开始定位
            [_locationManager startUpdatingHeading];//开始获取自身方向(陀螺仪)
        }
    }
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [_locationManager startUpdatingLocation];//开始定位
    [_locationManager startUpdatingHeading];//开始获取自身方向(陀螺仪)
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
    [_locationManager stopUpdatingLocation];//停止定位
    [_locationManager stopUpdatingHeading];//停止获取自身方向(陀螺仪)
}

#pragma mark Core Location委托方法用于实现位置的更新
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    //locations是位置变化的集合，它按照时间变化的顺序存放，最后一个元素即为当前设备的位置
    _currLocation = [locations lastObject];
    
    CGFloat latitude = _currLocation.coordinate.latitude;
    CGFloat longitude = _currLocation.coordinate.longitude;
    CGFloat altitude = _currLocation.altitude;
    _txtLat.text = [NSString stringWithFormat:@"%3.5f",latitude];//纬度
    _txtLng.text = [NSString stringWithFormat:@"%3.5f",longitude];//经度
    _txtAlt.text = [NSString stringWithFormat:@"%3.5f",altitude];//高度
}

-(void)locationManager:(CLLocationManager *)manager didUpdateHeading:(CLHeading *)newHeading
{
    //获取陀螺仪的值 touch没有陀螺仪 取值范围0-360
    //制作指南针：类似于控件旋转，用transform（location），把这里获得的角度转变为弧度值即可
    _txtHead.text = [NSString stringWithFormat:@"%3.5f",newHeading.trueHeading];
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    NSLog(@"error: %@",error);
}

- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status
{
    if (status <3 ) {
        NSLog(@"未获取授权");
    }else{
        NSLog(@"已获取授权");
        _locationManager.desiredAccuracy = kCLLocationAccuracyBest;//精确度，6个常量
        _locationManager.distanceFilter = 1000.0f;//距离过滤器，移动多少米再获取信息
        [_locationManager startUpdatingLocation];
        [_locationManager startUpdatingHeading];
    }
}

@end
