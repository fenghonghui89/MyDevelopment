//
//  ViewController.m
//  WhereAmI
//
//  Created by 关东升 on 13-1-6.
//  Copyright (c) 2013年 eorient. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property(nonatomic,assign)CLLocationCoordinate2D locationCoordinate;
@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}


- (IBAction)geocodeQuery:(id)sender {
    
    if (_txtQueryKey.text == nil || [_txtQueryKey.text length] == 0) {
        return;
    }
    
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    [geocoder geocodeAddressString:_txtQueryKey.text completionHandler:^(NSArray *placemarks, NSError *error) {
        
        NSLog(@"查询记录数：%i",[placemarks count]);
        if ([placemarks count] > 0) {
            CLPlacemark* placemark = placemarks[0];
            
            //获取经纬度
            CLLocationCoordinate2D coordinate = placemark.location.coordinate;
            _locationCoordinate = coordinate;
            NSString* strCoordinate  = [NSString stringWithFormat:@"经度:%3.5f \n纬度:%3.5f",coordinate.latitude, coordinate.longitude];
            
            //获取地址信息
            NSDictionary *addressDictionary =  placemark.addressDictionary;
            
            NSString *address = [addressDictionary objectForKey:(NSString *)kABPersonAddressStreetKey];
            address = address == nil ? @"": address;
            
            NSString *state = [addressDictionary objectForKey:(NSString *)kABPersonAddressStateKey];
            state = state == nil ? @"": state;
            
            NSString *city = [addressDictionary objectForKey:(NSString *)kABPersonAddressCityKey];
            city = city == nil ? @"": city;
            
            //输出
            _txtView.text = [NSString stringWithFormat:@"%@ \n %@ \n%@ \n%@",strCoordinate,state, address,city];
            
            [_txtQueryKey resignFirstResponder];
        }
        
    }];

}

//查询指定范围
- (IBAction)checkRegion:(id)sender
{
    if (_txtQueryKey.text == nil || [_txtQueryKey.text length] == 0) {
        return;
    }
    
    //设定范围：经纬度、区域半径、应用中的唯一标示符
    CLRegion *region = [[CLRegion alloc] initCircularRegionWithCenter:_locationCoordinate radius:1000.0f identifier:@"GeocodeRegion"];
    
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    [geocoder geocodeAddressString:_txtQueryKey.text inRegion:region completionHandler:^(NSArray *placemarks, NSError *error) {
        
        NSLog(@"查询记录数：%i",[placemarks count]);
        if ([placemarks count] > 0) {
            CLPlacemark* placemark = placemarks[0];
            CLLocationCoordinate2D coordinate = placemark.location.coordinate;
            _locationCoordinate = coordinate;
            NSString* strCoordinate  = [NSString stringWithFormat:@"经度:%3.5f \n纬度:%3.5f",coordinate.latitude, coordinate.longitude];
            
            NSDictionary *addressDictionary =  placemark.addressDictionary;
            
            NSString *address = [addressDictionary objectForKey:(NSString *)kABPersonAddressStreetKey];
            address = address == nil ? @"": address;
            
            NSString *state = [addressDictionary objectForKey:(NSString *)kABPersonAddressStateKey];
            state = state == nil ? @"": state;
            
            NSString *city = [addressDictionary objectForKey:(NSString *)kABPersonAddressCityKey];
            city = city == nil ? @"": city;
            
            _txtView.text = [NSString stringWithFormat:@"%@ \n %@ \n%@ \n%@ \n\n",strCoordinate,state, address,city];
            
            [_txtQueryKey resignFirstResponder];
        }
        
    }];
}


@end
