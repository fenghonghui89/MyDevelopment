//
//  MD_FreeTest_VC.m
//  MyDevelopmentTest
//
//  Created by 冯鸿辉 on 16/2/26.
//  Copyright © 2016年 hanyfeng. All rights reserved.
//





#import "MD_FreeTest_VC.h"

#pragma mark - ******************* MD_FreeTest_VC *******************
@interface MD_FreeTest_VC ()

@property (weak, nonatomic) IBOutlet UIButton *btn;
@property (weak, nonatomic) IBOutlet UILabel *titlelabel;
@property (weak, nonatomic) IBOutlet UITextField *testfield;


@end

@implementation MD_FreeTest_VC


#pragma mark - < vc lifecycle >
- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    NSDictionary *headers = @{ @"cache-control": @"no-cache",
                               @"postman-token": @"ff9f44b2-4eb8-aabf-b0eb-837f08abf1d4" };
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"http://app.3hmlg.com/common/getServerTime.action"]
                                                           cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                       timeoutInterval:10.0];
    [request setHTTPMethod:@"GET"];
    [request setAllHTTPHeaderFields:headers];
    
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request
                                                completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                                                    if (error) {
                                                        NSLog(@"error..%@", error);
                                                    } else {
                                                        NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *) response;
                                                        NSLog(@"%@", httpResponse);
                                                    }
                                                }];
    [dataTask resume];
}

-(void)viewDidAppear:(BOOL)animated{
    
    [super viewDidAppear:animated];
}

#pragma mark - < method >

- (UIImage*)text:(NSString*)text addToView:(UIImage*)image{
    
    //设置字体样式
    
    UIFont *font = [UIFont fontWithName:@"PingFangSC-Regular" size:15];
    
    NSDictionary *dict = @{NSFontAttributeName:font,NSForegroundColorAttributeName:[UIColor redColor]};
    
    CGSize textSize = [text sizeWithAttributes:dict];
    
    //绘制上下文
    
    UIGraphicsBeginImageContext(image.size);
    
    [image drawInRect:CGRectMake(0,0, image.size.width, image.size.height)];
    
    int border =10;
    
    CGRect re = {CGPointMake(image.size.width- textSize.width- border, image.size.height- textSize.height- border), textSize};
    
    //此方法必须写在上下文才生效
    
    [text drawInRect:re withAttributes:dict];
    
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return newImage;
    
}

-(void)customInitUI{
    
}


-(NSInteger)test0{
    return 100;
}

-(NSInteger)test1{
    return 100;
}

#pragma mark - < action >
- (IBAction)btnTap:(id)sender {
    
    UIImage *img = [[UIImage alloc] init];
    img = [self text:@"xxx" addToView:img];
    
    UIImageView *iv = [[UIImageView alloc] initWithImage:img];
    [iv setFrame:CGRectMake(100, 100, 100, 100)];
    [self.view addSubview:iv];
}

@end
