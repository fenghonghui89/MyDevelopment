//
//  MD_HTTP_URLDecode_VC.m
//  MyDevelopmentTest
//
//  Created by 冯鸿辉 on 16/3/23.
//  Copyright © 2016年 hanyfeng. All rights reserved.
//

#import "MD_HTTP_URLDecode_VC.h"
#import "NSString+URLEncoding.h"
#import "MD_TableViewCell.h"

static NSString * const cellId = @"cellId";

@interface MD_HTTP_URLDecode_VC ()<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong)NSMutableArray *imagePaths;
@end

@implementation MD_HTTP_URLDecode_VC

#pragma mark - < vc lifecycle > -
- (void)viewDidLoad {
  [super viewDidLoad];

}

-(void)viewDidAppear:(BOOL)animated{
  [super viewDidAppear:animated];
  
  [self getWebImg];
  [self customInitUI];

}

#pragma mark - < method > -
-(void)customInitUI{
  [self.tableView registerNib:[UINib nibWithNibName:@"MD_TableViewCell" bundle:nil] forCellReuseIdentifier:cellId];
  [self.tableView reloadData];
}

#pragma mark - < action > -
-(void)urlencode_urldecode{
  
  NSString *path = @"http://webservice.webxml.com.cn/WebServices/WeatherWS.asmx/getWeather?theCityCode=江门&theUserID=";
  
  //encode
  NSString *encodingString = [path stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
  NSString *encodingStringC = [encodingString URLEncodedString];//用CoreFoundation提供的C函数编码（更灵活）
  NSString *encodingStringNew = [encodingString stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLPathAllowedCharacterSet]];
  NSLog(@"encode:%@",encodingString);
  NSLog(@"encodeC:%@",encodingStringC);
  NSLog(@"encodeNew:%@",encodingStringNew);
  
  NSURL *url = [NSURL URLWithString:encodingString];
  NSMutableURLRequest* request = [NSMutableURLRequest requestWithURL:url];
  
  NSHTTPURLResponse *response = nil;
  NSError *error = nil;
  NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
  if (error) {
    NSLog(@"error:%@",error);
  }else{
    NSLog(@"response:%@",[response allHeaderFields]);
    
    //decode
    NSString *string = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
//    string = [string stringByRemovingPercentEncoding];
    NSLog(@"decode:%@",string);
    
    NSStringEncoding gbkEncode = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);
    NSString *stringGBK = [[NSString alloc] initWithData:data encoding:gbkEncode];////中文GB2312解码（GB2312是国家编码，UTF8是国际通用编码）
    NSLog(@"decode gbk:%@",stringGBK);
    
    NSString *stringC = [string URLDecodedString];//用CoreFoundation提供的C函数解码（更灵活）
    NSLog(@"decodeC:%@",stringC);
  }
}

-(void)GBKencode{
  
  NSStringEncoding gbkEncode = CFStringConvertEncodingToNSStringEncoding (kCFStringEncodingGB_18030_2000);
  char* c_test = "北京";
  long nLen = strlen(c_test);//长度
  NSString* str = [[NSString alloc]initWithBytes:c_test length:nLen encoding:gbkEncode];
  NSLog(@"str = %@",str);
}

-(void)getWebImg{
  
  NSString *baseUrl = @"http://www.sina.com.cn";
  NSURL *url = [NSURL URLWithString:baseUrl];
  NSError *error = nil;
  NSString *htmlString = [NSString stringWithContentsOfURL:url encoding:NSUTF8StringEncoding error:&error];
  if (error) {
    NSLog(@"utf8 encoding error...:%@",[error localizedDescription]);
    
    htmlString = [NSString stringWithContentsOfURL:url encoding:NSASCIIStringEncoding error:&error];
    if (error) {
      NSLog(@"ascii encoding error...:%@",[error localizedDescription]);
    }else{
      NSLog(@"ascii string...:%@",htmlString);
    }
  }else{
    NSLog(@"utf8 string...:%@",htmlString);
  }
  
  //获取页面中所有图片的路径
  self.imagePaths = [NSMutableArray array];
  NSArray *arr = [htmlString componentsSeparatedByString:@"\""];//按"分割源代码（转义字符\"）
  for (NSString *str in arr) {
    if ([str hasSuffix:@"jpg"] || [str hasSuffix:@"png"]) {
      if ([str rangeOfString:@"http"].location == NSNotFound) {
        NSString *newPath = [baseUrl stringByAppendingString:str];
        [self.imagePaths addObject:newPath];
        NSLog(@"image path...:%@   %@",newPath,str);
      }else{
        [self.imagePaths addObject:str];
        NSLog(@"image path...:%@",str);
      }
    }
  }
  NSLog(@"images count...:%lu",(unsigned long)self.imagePaths.count);
}

#pragma mark - < callback > -
#pragma mark UITableView
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
  return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
  
  return self.imagePaths.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
  
  MD_TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId forIndexPath:indexPath];

  NSString *imagePath = self.imagePaths[indexPath.row];
  
  dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
    NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:imagePath]];
    UIImage *image = [UIImage imageWithData:data];
    
    dispatch_async(dispatch_get_main_queue(), ^{
      cell.imageView_.image = image;
    });
  });
  
  return cell;
}

@end
