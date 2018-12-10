//
//  ViewController.h
//  WhereAmI
//
//  Created by 关东升 on 13-1-6.
//  Copyright (c) 2013年 eorient. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import <CoreLocation/CLLocationManagerDelegate.h>


@interface ViewController : UIViewController <CLLocationManagerDelegate>

@property (weak, nonatomic) IBOutlet UITextField *txtLng;//经度
@property (weak, nonatomic) IBOutlet UITextField *txtLat;//纬度
@property (weak, nonatomic) IBOutlet UITextField *txtAlt;//高度
@property (weak, nonatomic) IBOutlet UITextField *txtHead;//方向
@property(nonatomic, strong) CLLocationManager *locationManager;
@property(nonatomic, strong)  CLLocation *currLocation;

@end
