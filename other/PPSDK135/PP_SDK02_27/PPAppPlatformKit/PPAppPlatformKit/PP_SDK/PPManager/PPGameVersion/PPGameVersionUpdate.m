////
////  PPGameVersionUpdate.m
////  SDKDemoForFramework
////
////  Created by Seven on 13-7-3.
////  Copyright (c) 2013年 Server. All rights reserved.
////
//
//#import "PPGameVersionUpdate.h"
//#import "PPAppPlatformKit.h"
//#import "PPCommon.h"
//#import "PPGameVersionUpdateAlertView.h"
//#import "PPAlertView.h"
//static int verifyCount = 0;
//@implementation PPGameVersionUpdate
//
///// <summary>
///// 查询当前游戏版本更新信息
///// </summary>
//-(void)ppGameVersionRequest:(NSString *)str{
//    verifyCount = verifyCount + 1;
//    NSDictionary *infoDict = [[NSBundle mainBundle] infoDictionary];
//    NSString *requsetBodyData = [NSString stringWithFormat:@"{\"appid\":\"%d\",\"ppKey\":\"%@\",\"uid\":\"%lld\",\"uuid\":\"%@\",\"BundleId\":\"%@\",\"version\":\"%@\"}",
//                                 PP_REQUEST_APPID,PUBLICKEY,PP_REQUEST_USERID,PP_REQUEST_UUID,
//                                 [infoDict objectForKey:@"CFBundleIdentifier"]
////                                 @"com.teiron.SDK-DEMO"
////                                 @"com.sohu.newspaper"
//                                 ,str];
//    NSString *requestURLStr = [PP_ADDRESS stringByAppendingString:@"/?act=apponline.getVersionUpdate"];
//    NSURL *requestUrl = [NSURL URLWithString:[requestURLStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
//    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:requestUrl];
//    [request setHTTPMethod:@"POST"];
//    [request setHTTPBody:[requsetBodyData dataUsingEncoding:NSUTF8StringEncoding]];
//    [request setTimeoutInterval:10];
//    
//    if (PP_ISNSLOG) {
//        NSLog(@"请求查询当前游戏版本更新信息requsetBodyData--\n%@",requsetBodyData);
//        NSLog(@"请求查询当前游戏版本更新信息url地址requestURLStr--\n%@",requestURLStr);
//    }
//    [self sendRequest:request];
//}
//
//
//-(void)s{
//    if (![[NSFileManager defaultManager] fileExistsAtPath:PP_UPDATEGAMEFLAG_FILE]) {
//            [[NSFileManager defaultManager] createFileAtPath:PP_UPDATEGAMEFLAG_FILE contents:nil attributes:nil];
//            queueBillNoArray = [[NSMutableArray alloc] initWithContentsOfFile:PP_BILLNOLISTNOTIFICATIONFILEPATH];
//        
//    }else{
//        queueBillNoArray = [[NSMutableArray alloc] initWithContentsOfFile:PP_BILLNOLISTNOTIFICATIONFILEPATH];
//    }
//
//}
//
//-(void)sendRequest:(NSMutableURLRequest *)request
//{
//    if (![NSURLConnection canHandleRequest:request])
//    {
//        return;
//    }
//    NSURLConnection *connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
//    if (recvData) {
//        [recvData release];
//        recvData = nil;
//    }
//    
//    if(connection){
//        recvData = [[NSMutableData alloc] init];
//    }
//    [connection start];
//    [connection release];
//}
//
//#pragma mark  -------------------------request connection delegate methods ------------------------------------
//-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
//{
//    [recvData setLength:0];
//}
//
//-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
//{
//    [recvData appendData:data];
//}
//
//-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
//{
//    [[NSNotificationCenter defaultCenter] postNotificationName:PP_PHP_RESPONSE_CONNECTIONERROR_NOTIFICATION
//                                                        object:nil];
//    [PPUIKit setVerifyingUpdate:NO];
//}
//
//-(void)connectionDidFinishLoading:(NSURLConnection *)connection
//{
//    
//    [PPUIKit setVerifyingUpdate:NO];
//    
//    NSString *jsonStr = [[NSString alloc] initWithData:recvData encoding:NSUTF8StringEncoding];
//    NSDictionary *conDidFinishDic = [NSJSONSerialization JSONObjectWithData:recvData options:NSJSONReadingAllowFragments error:nil];
//    [recvData release];
//    recvData = nil;
////    NSDictionary *conDidFinishDic = [jsonStr objectFromJSONString];
//    
//    if (PP_ISNSLOG) {
////        NSLog(@"PPGameVersionUpdate返回的str--%@",jsonStr);
//        NSLog(@"【PPGameVersionUpdate】请求返回的dic -%@",conDidFinishDic);
//    }
//    
//
//    
//    [jsonStr release];
//    
//    if (conDidFinishDic == nil) {
//        [[NSNotificationCenter defaultCenter] postNotificationName:PP_PHP_RESPONSE_CONNECTIONERROR_NOTIFICATION
//                                                            object:nil];
//    }
//    
//    int result = [[conDidFinishDic objectForKey:@"error"] intValue];
//    NSString *getSDKName = [conDidFinishDic objectForKey:@"sdk_name"];
//    if ([getSDKName isEqualToString:PP_PHP_RESPONSE_GET_GAMEVERSIONUPDATE_SDKNAME]) {
//        //如果error为0 表示有新的版本 则去解析data数据
//        [[NSNotificationCenter defaultCenter] postNotificationName:PP_PHP_RESPONSE_GAMEUPDATE_NOTIFICATION
//                                                            object:[NSString stringWithFormat:@"%d",result]];
//        
//        [PPUIKit setVerifyingUpdate:YES];
//        
//        if (result == 0) {
//            NSDictionary *dataDic = [conDidFinishDic objectForKey:@"data"] ;
//            int if_update_force = [[dataDic objectForKey:@"if_update_force"] intValue];
//            NSDictionary *ipa_update_describe_list = [dataDic objectForKey:@"ipa_update_describe_list"];
//            NSString *newest_ipa_download_url = [dataDic objectForKey:@"newest_ipa_download_url"];
//            NSString *newest_version = [dataDic objectForKey:@"newest_version"];
//            //读取本地记录是否为忽略版本
//            if ([[NSFileManager defaultManager] fileExistsAtPath:PP_UPDATEGAMEFLAG_FILE]) {
//                NSMutableArray *tempArray = [NSMutableArray arrayWithContentsOfFile:PP_UPDATEGAMEFLAG_FILE];
//                if (PP_ISNSLOG) {
//                    NSLog(@"读取出本地忽略的版本%@",tempArray);
//                }
//                
//                for (NSString *tempStr in tempArray){
//                    if ([tempStr isEqualToString:newest_version]) {
//                        [PPUIKit setVerifyingUpdate:YES];
//                        if ([[PPAppPlatformKit sharedInstance] delegate]) {
//                            [[[PPAppPlatformKit sharedInstance] delegate] ppVerifyingUpdatePassCallBack];
//                        }
//                        return;
//                    }
//                }
//            }
//
//            if(if_update_force == 0)
//            {
//                [PPUIKit setVerifyingUpdate:YES];
//                //不强更
//                PPGameVersionUpdateAlertView *ppGameAlertView = [[PPGameVersionUpdateAlertView alloc] initWithForce:NO
//                                                                                                 UpdateDescribeList:ipa_update_describe_list
//                                                                                                        DownloadUrl:newest_ipa_download_url
//                                                                                                      NewestVersion:newest_version];
//                [ppGameAlertView showModel];
//                [ppGameAlertView release];
//            }
//            else if (if_update_force == 1)
//            {
//                //强更
//                [PPUIKit setVerifyingUpdate:NO];
//                PPGameVersionUpdateAlertView *ppGameAlertView = [[PPGameVersionUpdateAlertView alloc] initWithForce:YES
//                                                                                                 UpdateDescribeList:ipa_update_describe_list
//                                                                                                        DownloadUrl:newest_ipa_download_url
//                                                                                                      NewestVersion:newest_version];
//                [ppGameAlertView showModel];
//                [ppGameAlertView release];
//            }
//        }
//        //如果error为1 表示没新的版本更新 忽略 这个时候data也为空
//        else if(result == 1)
//        {
//            [PPUIKit setVerifyingUpdate:YES];
//            if ([[PPAppPlatformKit sharedInstance] delegate]) {
//                [[[PPAppPlatformKit sharedInstance] delegate] ppVerifyingUpdatePassCallBack];
//            }
//
//        }
//        //如果为2  表示 接口没有传appid 或者  version过来
//        else if(result == 2)
//        {
//            [PPUIKit setVerifyingUpdate:NO];
//            PPAlertView *alert = [[PPAlertView alloc] initWithTitle:PP_ADDRESS message:@"参数缺失,请联系运营"];
//            [alert setCancelButtonTitle:@"确定" block:^{
//                exit(0);
//            }];
//            [alert addButtonWithTitle:nil block:nil];
//            [alert show];
//            
//        }else if(result == 3)
//        {
//            //没有设置游戏BundleId
//           
//            [PPUIKit setVerifyingUpdate:NO];
//            PPAlertView *alert = [[PPAlertView alloc] initWithTitle:PP_ADDRESS message:@"缺少游戏BundleId，请联系运营"];
//            [alert setCancelButtonTitle:@"确定" block:^{
//                exit(0);
//            }];
//            [alert addButtonWithTitle:nil block:nil];
//            [alert show];
//
//        }else if (result == 4){
////            BundleId不正确
//            [PPUIKit setVerifyingUpdate:NO];
//            PPAlertView *alert = [[PPAlertView alloc] initWithTitle:PP_ADDRESS message:@"BundleId不正确，请联系运营"];
//            [alert setCancelButtonTitle:@"确定" block:^{
//                exit(0);
//            }];
//            [alert addButtonWithTitle:nil block:nil];
//            [alert show];
//
//        }
//        
//        
//    }
//
//}
//
//
//
//@end
//
