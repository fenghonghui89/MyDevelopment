//
//  ViewController.m
//  WhereAmI
//
//  Created by 关东升 on 13-1-6.
//  Copyright (c) 2013年 eorient. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UIAlertViewDelegate>

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _locationManager = [[CLLocationManager alloc] init];
    _locationManager.delegate = self;
    
    [self GetAuthorization];
}

-(void)GetAuthorization
{
    if([CLLocationManager locationServicesEnabled]==YES){
        NSLog(@"定位服务检测：已开启");
        if ([CLLocationManager authorizationStatus]<3) {
            NSLog(@"授权检测：未获取授权");
            if ([[[UIDevice currentDevice] systemVersion] floatValue]>=8.0) {
                [_locationManager performSelector:@selector(requestAlwaysAuthorization) withObject:nil];
            }else{
                [_locationManager startUpdatingLocation];
            }
        }else{
            NSLog(@"授权检测：已获取授权");
        }
    }else{
        NSLog(@"定位服务检测：未开启");
        UIAlertView *av = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"定位服务未打开" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [av show];
    }
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [_locationManager stopUpdatingLocation];//停止定位
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

- (IBAction)refreshBtnPress:(id)sender
{
    [self GetAuthorization];
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    NSLog(@"error: %@",error);
}

- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status
{
    if (status <3 ) {
        NSLog(@"授权检测：未获取授权");
    }else{
        NSLog(@"授权检测：已获取授权");
        _locationManager.desiredAccuracy = kCLLocationAccuracyBest;//精确度，6个常量
        _locationManager.distanceFilter = 1000.0f;//距离过滤器，移动多少米再获取信息
        [_locationManager startUpdatingLocation];
    }
}

- (IBAction)reverseGeocode:(id)sender {
    
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    
    [geocoder reverseGeocodeLocation:_currLocation
                   completionHandler:^(NSArray *placemarks, NSError *error) {
                       
                       
                       if ([placemarks count] > 0) {
                           
                           CLPlacemark *placemark = placemarks[0];//取出一个地标
                           
                           NSDictionary *addressDictionary =  placemark.addressDictionary;//取出地标里面的地址信息字典
                           
                           //所在街道信息
                           NSString *address = [addressDictionary objectForKey:(NSString *)kABPersonAddressStreetKey];
                           address = address == nil ? @"": address;
                           
                           //所在州省信息
                           NSString *state = [addressDictionary objectForKey:(NSString *)kABPersonAddressStateKey];
                           state = state == nil ? @"": state;
                           
                           //所在城市信息
                           NSString *city = [addressDictionary objectForKey:(NSString *)kABPersonAddressCityKey];
                           city = city == nil ? @"": city;
                           
                           _txtView.text = [NSString stringWithFormat:@"%@ \n%@ \n%@",state, address,city];
                       }
                       
                       
                   }];
    
}


@end
