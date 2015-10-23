//
//  ViewController.m
//  AFNetworkTest
//
//  Created by hanyfeng on 15/9/28.
//  Copyright © 2015年 hanyfeng. All rights reserved.
//

#import "ViewController.h"
#import <CommonCrypto/CommonDigest.h>
#import "AFNetworkManager.h"
#import "AFHTTPRequestOperationManager.h"
#import "AFNetworkReachabilityManager.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

}

-(NSString *)md5:(NSString *)str
{
    const char *cStr = [str UTF8String];
    unsigned char result[32];
    CC_MD5(cStr, strlen(cStr), result); // This is the md5 call
    return [NSString stringWithFormat:
            @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
            result[0], result[1], result[2], result[3],
            result[4], result[5], result[6], result[7],
            result[8], result[9], result[10], result[11],
            result[12], result[13], result[14], result[15]
            ];
}

//GET
- (IBAction)tap1:(id)sender
{
    //天气
//    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
//    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"application/json"];
//    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
//    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
//    [manager GET:@"http://webservice.webxml.com.cn//webservices/DomesticAirline.asmx/getDomesticCity?"
//      parameters:nil
//         success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
//             NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
//             NSLog(@"me JSON: %@", dic);
//         }
//         failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
//             NSLog(@"error..");
//         }];
    
    //天工问答登录
    NSString *requestURL = @"http://api.wd.tgnet.com/Info/NewestList";
    NSDictionary *paraDic = @{@"class_no":@"",
                              @"page":@(1),
                              @"limit":@(10)
                              };
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
//    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"application/json"];
//    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
//    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager GET:requestURL
      parameters:paraDic
         success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
             NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
             NSLog(@"me JSON: %@", dic);
         }
         failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
             NSLog(@"error..");
         }];
}

//POST
- (IBAction)tap2:(id)sender
{
    NSString *requestURL = @"http://51uca.com/biz/login";
    
    NSString *md5_password = [self md5:@"1234567"];
    NSString *md5_tmp = [md5_password stringByAppendingString:@"rickyhoxiaoyi@163.com"];
    NSString *md5_final = [self md5:md5_tmp];
    NSDictionary *paraDic = @{@"username":@"rickyhoxiaoyi@163.com",
                              @"password":md5_final,
                              @"sysModel":@(1),
                              };
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
//    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"application/json"];
//    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
//    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:requestURL parameters:paraDic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        NSLog(@"me JSON: %@", dic);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"me Error: %d\n%@",error.code,error.domain);
        
    }];
}

//Reachability
- (IBAction)tap3:(id)sender
{
    AFNetworkReachabilityManager *manager = [AFNetworkReachabilityManager sharedManager];
    [manager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        NSLog(@"me - network change status:%d",status);
    }];
    [manager startMonitoring];
    
}

- (IBAction)tap4:(id)sender
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSLog(@"%@",manager.baseURL);
}

@end
