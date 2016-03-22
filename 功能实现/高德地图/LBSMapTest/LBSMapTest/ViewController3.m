//
//  ViewController3.m
//  LBSMapTest
//
//  Created by 冯鸿辉 on 16/3/22.
//  Copyright © 2016年 DGC. All rights reserved.
//

#import "ViewController3.h"
#import <AMapSearchKit/AMapSearchKit.h>
@interface ViewController3 ()<AMapSearchDelegate>
@property(nonatomic,strong)AMapSearchAPI *search;
@end

@implementation ViewController3

#pragma mark - < vc lifecycle > -
- (void)viewDidLoad {
  [super viewDidLoad];
  
  self.edgesForExtendedLayout = UIRectEdgeNone;
  
  [self customInit];
  [self searchWeather];
}


#pragma mark - < method > -
-(void)customInit{
  
  //配置用户Key
  [AMapSearchServices sharedServices].apiKey = @"6d89b5f59bc0a6865fd9b0e522b696dd";
  
  //初始化检索对象
  _search = [[AMapSearchAPI alloc] init];
  _search.delegate = self;
  
}


#pragma mark - < action > -
-(void)aroundSearch{
  //构造AMapPOIAroundSearchRequest对象，设置周边请求参数
  AMapPOIAroundSearchRequest *request = [[AMapPOIAroundSearchRequest alloc] init];
  request.location = [AMapGeoPoint locationWithLatitude:39.990459 longitude:116.481476];
  request.keywords = @"方恒";
  // types属性表示限定搜索POI的类别，默认为：餐饮服务|商务住宅|生活服务
  // POI的类型共分为20种大类别，分别为：
  // 汽车服务|汽车销售|汽车维修|摩托车服务|餐饮服务|购物服务|生活服务|体育休闲服务|
  // 医疗保健服务|住宿服务|风景名胜|商务住宅|政府机构及社会团体|科教文化服务|
  // 交通设施服务|金融保险服务|公司企业|道路附属设施|地名地址信息|公共设施
  request.types = @"餐饮服务|生活服务";
  request.sortrule = 0;
  request.requireExtension = YES;
  
  //发起周边搜索
  [_search AMapPOIAroundSearch: request];
}

-(void)searchLocation{
  //构造AMapGeocodeSearchRequest对象，address为必选项，city为可选项
  AMapGeocodeSearchRequest *geo = [[AMapGeocodeSearchRequest alloc] init];
  geo.address = @"西单";
  
  //发起正向地理编码
  [_search AMapGeocodeSearch: geo];
}

-(void)searchAddress{
  //构造AMapReGeocodeSearchRequest对象
  AMapReGeocodeSearchRequest *regeo = [[AMapReGeocodeSearchRequest alloc] init];
  regeo.location = [AMapGeoPoint locationWithLatitude:39.990459     longitude:116.481476];
  regeo.radius = 10000;
  regeo.requireExtension = YES;
  
  //发起逆地理编码
  [_search AMapReGoecodeSearch: regeo];
}

-(void)searchContent{
  //构造AMapInputTipsSearchRequest对象，设置请求参数
  AMapInputTipsSearchRequest *tipsRequest = [[AMapInputTipsSearchRequest alloc] init];
  tipsRequest.keywords = @"肯德基";
  tipsRequest.city = @"北京";
  
  //发起输入提示搜索
  [_search AMapInputTipsSearch: tipsRequest];
}

-(void)searchWeather{
  //构造AMapWeatherSearchRequest对象，配置查询参数
  AMapWeatherSearchRequest *request = [[AMapWeatherSearchRequest alloc] init];
  request.city = @"广州";
  request.type = AMapWeatherTypeLive; //AMapWeatherTypeLive为实时天气；AMapWeatherTypeForecase为预报天气
  
  //发起行政区划查询
  [_search AMapWeatherSearch:request];
  
}
#pragma mark - < callback > -
//实现POI搜索对应的回调函数
- (void)onPOISearchDone:(AMapPOISearchBaseRequest *)request response:(AMapPOISearchResponse *)response
{
  if(response.pois.count == 0)
  {
    return;
  }
  
  //通过 AMapPOISearchResponse 对象处理搜索结果
  NSString *strCount = [NSString stringWithFormat:@"count: %ld",(long)response.count];
  NSString *strSuggestion = [NSString stringWithFormat:@"Suggestion: %@", response.suggestion];
  NSString *strPoi = @"";
  for (AMapPOI *p in response.pois) {
    strPoi = [NSString stringWithFormat:@"%@\nPOI: %@", strPoi, p.description];
  }
  NSString *result = [NSString stringWithFormat:@"%@ \n %@ \n %@", strCount, strSuggestion, strPoi];
  NSLog(@"Place: %@", result);
}

//实现正向地理编码的回调函数
- (void)onGeocodeSearchDone:(AMapGeocodeSearchRequest *)request response:(AMapGeocodeSearchResponse *)response
{
  if(response.geocodes.count == 0)
  {
    return;
  }
  
  //通过AMapGeocodeSearchResponse对象处理搜索结果
  NSString *strCount = [NSString stringWithFormat:@"count: %ld", (long)response.count];
  NSString *strGeocodes = @"";
  for (AMapTip *p in response.geocodes) {
    NSString *location = [NSString stringWithFormat:@"(%f,%f)",p.location.latitude,p.location.longitude];
    strGeocodes = [NSString stringWithFormat:@"%@\ngeocode: %@", strGeocodes, location];
  }
  NSString *result = [NSString stringWithFormat:@"%@ \n %@", strCount, strGeocodes];
  NSLog(@"Geocode: %@", result);
}

//实现逆地理编码的回调函数
- (void)onReGeocodeSearchDone:(AMapReGeocodeSearchRequest *)request response:(AMapReGeocodeSearchResponse *)response
{
  if(response.regeocode != nil)
  {
    //通过AMapReGeocodeSearchResponse对象处理搜索结果
    NSString *result = [NSString stringWithFormat:@"ReGeocode: %@", response.regeocode.formattedAddress];
    NSLog(@"ReGeo: %@", result);
  }
}

//实现输入提示的回调函数
-(void)onInputTipsSearchDone:(AMapInputTipsSearchRequest*)request response:(AMapInputTipsSearchResponse *)response
{
  if(response.tips.count == 0)
  {
    return;
  }
  
  //通过AMapInputTipsSearchResponse对象处理搜索结果
  NSString *strCount = [NSString stringWithFormat:@"count: %ld", (long)response.count];
  NSString *strtips = @"";
  for (AMapTip *p in response.tips) {
    strtips = [NSString stringWithFormat:@"%@\nTip: %@", strtips, p.description];
  }
  NSString *result = [NSString stringWithFormat:@"%@ \n %@", strCount, strtips];
  NSLog(@"InputTips: %@", result);
}

//实现天气查询的回调函数
- (void)onWeatherSearchDone:(AMapWeatherSearchRequest *)request response:(AMapWeatherSearchResponse *)response
{
  //如果是实时天气
  if(request.type == AMapWeatherTypeLive)
  {
    if(response.lives.count == 0)
    {
      return;
    }
    for (AMapLocalWeatherLive *live in response.lives) {
      NSLog(@"实时天气:%@",live.weather);
    }
  }
  //如果是预报天气
  else
  {
    if(response.forecasts.count == 0)
    {
      return;
    }
    for (AMapLocalWeatherForecast *forecast in response.forecasts) {
      NSLog(@"预报天气：%@",forecast.casts);
    }
  }
}
@end
