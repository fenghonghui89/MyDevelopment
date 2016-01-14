//
//  PPWebViewData.m
//  SDKDemoForFramework
//
//  Created by Seven on 13-10-9.
//  Copyright (c) 2013年 Server. All rights reserved.
//

#import "PPWebViewData.h"
#import "PPCommon.h"
#import "PPAppPlatformKitConfig.h"

@implementation PPWebViewData


- (void)setDelegate:(id<PPWebViewDataDelegate>)delegate
{
    if (_delegate) {
        [_delegate release];
        _delegate = nil;
    }
    
    if (delegate) {
        _delegate = [delegate retain];
    }
}

- (void)cancel
{
    if (_delegate) {
        [_delegate release];
        _delegate = nil;
    }
    
    
}


-(id)init{
    self = [super init];
    if (self) {
        
        
        
    }
    return self;
}

/**
 *使用md5加密参数的方法
 * @param FunctionName:要为哪个方法加密的方法名
 * @param username:用户名，string格式
 * @param phone:用户电话号码，string格式
 * @param Phone_code:用户输入的手机获取验证码，string格式
 * @param NewPwd:用户输入的新密码，string格式
 * @param nextCode:用于启动下一步的内部验证码
 * @param Email:用户邮箱
 * @param Question_1:用户密保问题一
 * @param Question_2:用户密保问题之二
 * @param Answer_1:用户密保问题一的答案
 * @param Answer_2:用户密保问题二的答案
 * @return json
 */
- (NSString *)makeSignMD5:(Functions)paramFunctionName
                Username:(NSString *)paramUsername
                   Phone:(NSString *)paramPhone
              Phone_code:(NSString *)paramPhone_code
                  NewPwd:(NSString *)paramNewPwd
                nextCode:(NSString *)paramNextCode
                   Email:(NSString *)paramEmail
              Question_1:(Question )paramQuestion_1
              Question_2:(Question )paramQuestion_2
                Answer_1:(NSString *)paramAnswer_1
                Answer_2:(NSString *)paramAnswer_2
          NSTimeInterval:(NSString *)paramNSTimeInterval
{
    if(PP_ISNSLOG)
    {
        NSLog(@"BEGIN MD5 = %d",paramFunctionName);
    }
    NSString *paramSign = @"";
//    NSDate* dat = [NSDate dateWithTimeIntervalSinceNow:0];
//    NSTimeInterval a = [dat timeIntervalSince1970] * 1000;
//    //转为字符型
//    NSString *timeString = [NSString stringWithFormat:@"%f", a];
    switch (paramFunctionName) {
            
            // getPhoneCodeChkUserName = 1
        case 1:
            paramSign = [PPCommon md5HexDigest:[NSString stringWithFormat:@"{\"username\":\"%@\",\"phone\":\"%@\",\"version\":\"%@\",\"key\":\"%@\"}",
                                                     paramUsername,paramPhone,PP_REQUEST_VERSION,MD5_KEY]];
            break;
            
            //findPwdByPhone = 2
        case 2:
            paramSign = [PPCommon md5HexDigest:[NSString stringWithFormat:@"{\"username\":\"%@\",\"phone\":\"%@\",\"phoneCode\":\"%@\",\"version\":\"%@\",\"key\":\"%@\"}",
                                                     paramUsername,paramPhone,paramPhone_code,PP_REQUEST_VERSION,MD5_KEY]];
            break;
            
            //resetPwdByPhone = 3
        case 3:
            paramSign = [PPCommon md5HexDigest:[NSString stringWithFormat:@"{\"username\":\"%@\",\"newPwd\":\"%@\",\"nextCode\":\"%@\",\"version\":\"%@\",\"key\":\"%@\"}",
                                                     paramUsername,paramNewPwd,paramNextCode,PP_REQUEST_VERSION,MD5_KEY]];
            break;
            
            //findPwdByEmail = 4
        case 4:
            
            paramSign = [PPCommon md5HexDigest:[NSString stringWithFormat:@"{\"username\":\"%@\",\"time\":\"%@\",\"version\":\"%@\",\"key\":\"%@\"}",
                                                     paramUsername,paramNSTimeInterval,PP_REQUEST_VERSION,MD5_KEY]];
            NSLog(@"%@",[NSString stringWithFormat:@"{\"username\":\"%@\",\"time\":\"%@\",\"version\":\"%@\",\"key\":\"%@\"}",
                         paramUsername,paramNSTimeInterval,PP_REQUEST_VERSION,MD5_KEY]);
            break;
            
            //getUserQuestion = 5
        case 5:
            paramSign = [PPCommon md5HexDigest:[NSString stringWithFormat:@"{\"username\":\"%@\",\"version\":\"%@\",\"key\":\"%@\"}",
                                                     paramUsername,PP_REQUEST_VERSION,MD5_KEY]];
            break;
            
            //chkUserQuestion = 6
        case 6:
            paramSign = [PPCommon md5HexDigest:[NSString stringWithFormat:@"{\"username\":\"%@\",\"question_1\":\"%d\",\"question_2\":\"%d\",\"answer_1\":\"%@\",\"answer_2\":\"%@\",\"version\":\"%@\",\"key\":\"%@\"}",
                                                     paramUsername,paramQuestion_1,paramQuestion_2,paramAnswer_1,paramAnswer_2,PP_REQUEST_VERSION,MD5_KEY]];
            break;
            
            //resetPwdByQuestion = 7
        case 7:
            paramSign = [PPCommon md5HexDigest:[NSString stringWithFormat:@"{\"username\":\"%@\",\"newPwd\":\"%@\",\"nextCode\":\"%@\",\"version\":\"%@\",\"key\":\"%@\"}",paramUsername,paramNewPwd,paramNextCode,PP_REQUEST_VERSION,MD5_KEY]];
            break;
            
            //findUserNameByEmail = 8
        case 8:
            
            NSLog(@"%@",    [NSString stringWithFormat:@"{\"email\":\"%@\",\"time\":\"%@\",\"version\":\"%@\",\"key\":\"%@\"}",paramEmail,paramNSTimeInterval,PP_REQUEST_VERSION,MD5_KEY]
                  );
            paramSign = [PPCommon md5HexDigest:[NSString stringWithFormat:@"{\"email\":\"%@\",\"time\":\"%@\",\"version\":\"%@\",\"key\":\"%@\"}",paramEmail,paramNSTimeInterval,PP_REQUEST_VERSION,MD5_KEY]
];
            
//                        paramSign = [PPCommon md5HexDigest:[NSString stringWithFormat:@"{\"email\":\"%@\",\"time\":\"%@\",\"key\":\"%@\"}",paramEmail,paramNSTimeInterval,MD5_KEY]];
            break;
            
            //findUserNameByPhone = 9
        case 9:
            paramSign = [PPCommon md5HexDigest:[NSString stringWithFormat:@"{\"phone\":\"%@\",\"version\":\"%@\",\"key\":\"%@\"}",paramPhone,PP_REQUEST_VERSION,MD5_KEY]];
            break;
    }
    
    if(PP_ISNSLOG)
    {
        NSLog(@"END MD5 = %d",paramFunctionName);
    }
    
    return paramSign;
}

#pragma mark - 找回账号，密码，以手机号，邮箱 -
/**
 * 通过手机找回用户名接口
 * @param phone:用户的电话号码
 * @param sign:参数列表加密后的参数
 * @return json
 */
- (void)getFindUserNameByPhone:(NSString*)paramPhone Sign:(NSString*)paramSign{
    if (PP_ISNSLOG)
    {
        NSLog(@"BEGIN - findPwdByPhone)");
    }
    
    
    
    
    PPHttpRequest *ppRequest = [[PPHttpRequest alloc] init];
    [ppRequest setDelegate:self];
    
    
    
    NSString *requsetBodyData = [NSString stringWithFormat:@"{\"phone\":\"%@\",\"sign\":\"%@\",\"version\":\"%@\"}",
                                 paramPhone,paramSign,PP_REQUEST_VERSION];
    
    
    
    NSString *requestURLStr = [PP_NEWADDRESS stringByAppendingString:PP_PHP_REQUEST_FINDUSERNAMEBYPHONE_SDKADDRESS];
    NSURL *requestUrl = [NSURL URLWithString:[requestURLStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:requestUrl];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:[requsetBodyData dataUsingEncoding:NSUTF8StringEncoding]];
    
    if (PP_ISNSLOG) {
        NSLog(@"发送的内容：%@",requsetBodyData);
        NSLog(@"请求得url地址requestURLStr--\n%@",requestURLStr);
    }
    [ppRequest sendRequest:request];
    [ppRequest release];

}


/**
 * 通过邮箱找回用户名接口
 * @param email:用户的邮箱
 * @param sign:参数列表经过加密后的参数
 * @return json
 */
- (void)getFindUserNameByEmail:(NSString *)paramEmail Sign:(NSString*)paramSign Time:(NSString *)paramTime
{
    if (PP_ISNSLOG)
    {
        NSLog(@"BEGIN - getFindUserNameByEmail)");
    }
    PPHttpRequest *ppRequest = [[PPHttpRequest alloc] init];
    [ppRequest setDelegate:self];
    

    
    NSString *requsetBodyData = [NSString stringWithFormat:@"{\"email\":\"%@\",\"time\":\"%@\",\"sign\":\"%@\",\"version\":\"%@\"}",
                                 paramEmail,paramTime,paramSign,PP_REQUEST_VERSION];
    
    
    NSString *requestURLStr = [PP_NEWADDRESS stringByAppendingString:PP_PHP_REQUEST_FINDUSERNAMEBYEMAIL_SDKADDRESS];
    NSURL *requestUrl = [NSURL URLWithString:[requestURLStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:requestUrl];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:[requsetBodyData dataUsingEncoding:NSUTF8StringEncoding]];
    
    if (PP_ISNSLOG) {
        NSLog(@"发送的内容：%@",requsetBodyData);
        NSLog(@"请求得url地址requestURLStr--\n%@",requestURLStr);
    }
    [ppRequest sendRequest:request];
    [ppRequest release];
}


/**
 * 通过用户名验证邮箱找回密码接口
 * @param email:用户的邮箱
 * @param sign:参数列表经过加密后的参数
 * @return json
 */
- (void)getFindPassWordByUserName:(NSString *)paramUserName Sign:(NSString*)paramSign Time:(NSString *)paramTime
{
    if (PP_ISNSLOG)
    {
        NSLog(@"BEGIN - getFindUserNameByEmail)");
    }
    PPHttpRequest *ppRequest = [[PPHttpRequest alloc] init];
    [ppRequest setDelegate:self];

    
    NSString *requsetBodyData = [NSString stringWithFormat:@"{\"username\":\"%@\",\"time\":\"%@\",\"sign\":\"%@\",\"version\":\"%@\"}",
                                 paramUserName,paramTime,paramSign,PP_REQUEST_VERSION];
    
    
    NSString *requestURLStr = [PP_NEWADDRESS stringByAppendingString:PP_PHP_REQUEST_FINDPWDBYEMAIL_SDKADDRESS];
    NSURL *requestUrl = [NSURL URLWithString:[requestURLStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:requestUrl];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:[requsetBodyData dataUsingEncoding:NSUTF8StringEncoding]];
    
    if (PP_ISNSLOG) {
        NSLog(@"发送的内容：%@",requsetBodyData);
        NSLog(@"请求得url地址requestURLStr--\n%@",requestURLStr);
    }
    [ppRequest sendRequest:request];
    [ppRequest release];
}

#pragma mark - 用户信息，账号，密码  安全级别 -

- (void)getUserInfoSecuityToFindPassword:(NSString *)paramUserName
{
    if (PP_ISNSLOG) {
        NSLog(@"BEGIN - getUserInfoSecuityToFindPassword)");
    }
    PPHttpRequest *ppRequest = [[PPHttpRequest alloc] init];
    [ppRequest setDelegate:self];

    NSString *requsetBodyData = [NSString stringWithFormat:@"{\"username\":\"%@\",\"uid\":\"%lld\",\"version\":\"%@\"}",
                                 paramUserName,PP_REQUEST_USERID,PP_REQUEST_VERSION];
    
    
    NSString *requsetBodyDataLog = [NSString stringWithFormat:@"{\"username\":\"%@\",\"uid\":\"%lld\",\"version\":\"%@\"}",
                                    paramUserName,PP_REQUEST_USERID,PP_REQUEST_VERSION];
    
    NSString *requestURLStr = [PP_NEWADDRESS stringByAppendingString:PP_PHP_REQUEST_USERINFOSECUITY_SDKADDRESS];
    NSURL *requestUrl = [NSURL URLWithString:[requestURLStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:requestUrl];
    [request setHTTPMethod:@"POST"];
    [request setTimeoutInterval:10];
    [request setHTTPBody:[requsetBodyData dataUsingEncoding:NSUTF8StringEncoding]];
    if (PP_ISNSLOG) {
        NSLog(@"请求得url地址requestURLStr--\n%@",requestURLStr);
        NSLog(@"请求post数据 --\n%@"  ,requsetBodyDataLog);
    }
    [ppRequest sendRequest:request];
    [ppRequest release];

    
}

- (void)getUserInfoSecuity:(NSString *)paramUserName
{
    if (PP_ISNSLOG) {
        NSLog(@"BEGIN - getUserInfoSecuity)");
    }
    PPHttpRequest *ppRequest = [[PPHttpRequest alloc] init];
    [ppRequest setDelegate:self];
    
    NSString *tempStr = [[PPAppPlatformKit sharedInstance] current20MinToken];
    if ([tempStr isEqualToString:@""]) {
        return;
    }
    NSString *requsetBodyData = [NSString stringWithFormat:@"{\"username\":\"%@\",\"token\":\"%@\",\"uid\":\"%lld\",\"version\":\"%@\"}",
                                 paramUserName,tempStr,PP_REQUEST_USERID,PP_REQUEST_VERSION];
    
    
    NSString *requsetBodyDataLog = [NSString stringWithFormat:@"{\"username\":\"%@\",\"uid\":\"%lld\",\"version\":\"%@\"}",
                                    paramUserName,PP_REQUEST_USERID,PP_REQUEST_VERSION];
    
    NSString *requestURLStr = [PP_NEWADDRESS stringByAppendingString:PP_PHP_REQUEST_USERINFOSECUITY_SDKADDRESS];
    NSURL *requestUrl = [NSURL URLWithString:[requestURLStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:requestUrl];
    [request setHTTPMethod:@"POST"];
    [request setTimeoutInterval:10];
    [request setHTTPBody:[requsetBodyData dataUsingEncoding:NSUTF8StringEncoding]];
    if (PP_ISNSLOG) {
        NSLog(@"请求得url地址requestURLStr--\n%@",requestURLStr);
        NSLog(@"请求post数据 --\n%@  --and pwd"  ,requsetBodyDataLog);
    }
    [ppRequest sendRequest:request];
    [ppRequest release];
}

#pragma mark - 检查， 验证，绑定 手机号 -

//获取手机验证码
- (void)getVerificationCode:(NSString *)paramPhone
{
    if (PP_ISNSLOG) {
        NSLog(@"BEGIN - getVerificationCode");
    }
    PPHttpRequest *ppRequest = [[PPHttpRequest alloc] init];
    [ppRequest setDelegate:self];
    
    NSString *tempStr = [[PPAppPlatformKit sharedInstance] current20MinToken];
    if ([tempStr isEqualToString:@""]) {
        return;
    }
    
    
    NSString *requsetBodyData = [NSString stringWithFormat:@"{\"uid\":\"%lld\",\"username\":\"%@\",\"token\":\"%@\",\"phone\":\"%@\",\"version\":\"%@\"}",
                                 PP_REQUEST_USERID,PP_REQUEST_USERNAME,tempStr,paramPhone,PP_REQUEST_VERSION];
    
    
    NSString *requsetBodyDataLog = [NSString stringWithFormat:@"{\"uid\":\"%lld\",\"username\":\"%@\",\"phone\":\"%@\",\"version\":\"%@\"}",
                                    PP_REQUEST_USERID,PP_REQUEST_USERNAME,paramPhone,PP_REQUEST_VERSION];
    
    
    NSString *requestURLStr = [PP_NEWADDRESS stringByAppendingString:PP_PHP_REQUEST_GETPHONECODE_SDKADDRESS];
    NSURL *requestUrl = [NSURL URLWithString:[requestURLStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:requestUrl];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:[requsetBodyData dataUsingEncoding:NSUTF8StringEncoding]];
    [request setTimeoutInterval:10];
    if (PP_ISNSLOG) {
        NSLog(@"请求得url地址requestURLStr--\n%@",requestURLStr);
        NSLog(@"请求post数据 --\n%@  --and pwd"  ,requsetBodyDataLog);
    }
    [ppRequest sendRequest:request];
    [ppRequest release];
}

//修改手机密保验证(新手机和新验证码)
- (void)getChkUserPhone:(NSString *)paramPhone
                   Code:(NSString *)paramCode
{
    if (PP_ISNSLOG) {
        NSLog(@"BEGIN - getBindPhone");
    }
    PPHttpRequest *ppRequest = [[PPHttpRequest alloc] init];
    [ppRequest setDelegate:self];
    
    NSString *tempStr = [[PPAppPlatformKit sharedInstance] current20MinToken];
    if ([tempStr isEqualToString:@""]) {
        return;
    }
    
    
    NSString *requsetBodyData = [NSString stringWithFormat:@"{\"username\":\"%@\",\"token\":\"%@\",\"phone\":\"%@\",\"phone_code\":\"%@\",\"version\":\"%@\"}",
                                 PP_REQUEST_USERNAME,tempStr,paramPhone,paramCode,PP_REQUEST_VERSION];
    
    NSString *requsetBodyDataLog = [NSString stringWithFormat:@"{\"username\":\"%@\",\"phone\":\"%@\"\"phone_code\":\"%@\",\"version\":\"%@\"}",
                                    PP_REQUEST_USERNAME,paramPhone,paramCode,PP_REQUEST_VERSION];
    
    
    NSString *requestURLStr = [PP_NEWADDRESS stringByAppendingString:PP_PHP_REQUEST_GETCHEUSERPHONE_SDKADDRESS];
    NSURL *requestUrl = [NSURL URLWithString:[requestURLStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:requestUrl];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:[requsetBodyData dataUsingEncoding:NSUTF8StringEncoding]];
    [request setTimeoutInterval:10];
    if (PP_ISNSLOG) {
        NSLog(@"请求得url地址requestURLStr--\n%@",requestURLStr);
        NSLog(@"请求post数据 --\n%@  --and pwd"  ,requsetBodyDataLog);
    }
    [ppRequest sendRequest:request];
    [ppRequest release];
}


//绑定手机保护接口
- (void)getBindPhone:(NSString *)paramPhone
                Code:(NSString *)paramCode
            Nextcode:(NSString *)paramNextcode
{
    if (PP_ISNSLOG) {
        NSLog(@"BEGIN - getBindPhone");
    }
    PPHttpRequest *ppRequest = [[PPHttpRequest alloc] init];
    [ppRequest setDelegate:self];
    
    NSString *tempStr = [[PPAppPlatformKit sharedInstance] current20MinToken];
    if ([tempStr isEqualToString:@""]) {
        return;
    }
    
    NSLog(@"%@",paramNextcode);
    NSString *requsetBodyData = [NSString stringWithFormat:@"{\"uid\":\"%lld\",\"username\":\"%@\",\"token\":\"%@\",\"phone\":\"%@\",\"phone_code\":\"%@\",\"nextcode\":\"%@\",\"version\":\"%@\"}",
                                 PP_REQUEST_USERID,PP_REQUEST_USERNAME,tempStr,paramPhone,paramCode,paramNextcode,PP_REQUEST_VERSION];
    
    NSString *requsetBodyDataLog = [NSString stringWithFormat:@"{\"uid\":\"%lld\",\"username\":\"%@\",\"phone\":\"%@\",\"phone_code\":\"%@\",\"nextcode\":\"%@\",\"version\":\"%@\"}",
                                    PP_REQUEST_USERID,PP_REQUEST_USERNAME,paramPhone,paramCode,paramNextcode,PP_REQUEST_VERSION];
    
    
    NSString *requestURLStr = [PP_NEWADDRESS stringByAppendingString:PP_PHP_REQUEST_GETBANDPHONE_SDKADDRESS];
    NSURL *requestUrl = [NSURL URLWithString:[requestURLStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:requestUrl];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:[requsetBodyData dataUsingEncoding:NSUTF8StringEncoding]];
    [request setTimeoutInterval:10];
    if (PP_ISNSLOG) {
        NSLog(@"请求得url地址requestURLStr--\n%@",requestURLStr);
        NSLog(@"请求post数据 --\n%@  --and pwd"  ,requsetBodyDataLog);
    }
    [ppRequest sendRequest:request];
    [ppRequest release];
}


#pragma mark - 检查，验证，绑定 邮箱 -
//验证邮箱
- (void)getEmailCode:(NSString *)paramEmail
{
    if (PP_ISNSLOG) {
        NSLog(@"BEGIN - getEmailCode");
    }
    PPHttpRequest *ppRequest = [[PPHttpRequest alloc] init];
    [ppRequest setDelegate:self];
    
    NSString *tempStr = [[PPAppPlatformKit sharedInstance] current20MinToken];
    if ([tempStr isEqualToString:@""]) {
        return;
    }
    
    
    NSString *requsetBodyData = [NSString stringWithFormat:@"{\"username\":\"%@\",\"token\":\"%@\",\"email\":\"%@\",\"version\":\"%@\"}",
                                 PP_REQUEST_USERNAME,tempStr,paramEmail,PP_REQUEST_VERSION];
    
    
    NSString *requsetBodyDataLog = [NSString stringWithFormat:@"{\"username\":\"%@\",\"email\":\"%@\",\"version\":\"%@\"}",
                                 PP_REQUEST_USERNAME,paramEmail,PP_REQUEST_VERSION];
    
    
    NSString *requestURLStr = [PP_NEWADDRESS stringByAppendingString:PP_PHP_REQUEST_GETEMAILCODE_SDKADDRESS];
    NSURL *requestUrl = [NSURL URLWithString:[requestURLStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:requestUrl];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:[requsetBodyData dataUsingEncoding:NSUTF8StringEncoding]];
    [request setTimeoutInterval:10];
    if (PP_ISNSLOG) {
        NSLog(@"请求得url地址requestURLStr--\n%@",requestURLStr);
        NSLog(@"请求post数据 --\n%@  --and pwd"  ,requsetBodyDataLog);
    }
    [ppRequest sendRequest:request];
    [ppRequest release];
}
//检查
- (void)getChkUserEmail:(NSString *)paramEmail
             Email_Code:(NSString *)paramEmail_Code
{
    if (PP_ISNSLOG) {
        NSLog(@"BEGIN - getChkUserEmailCode");
    }
    PPHttpRequest *ppRequest = [[PPHttpRequest alloc] init];
    [ppRequest setDelegate:self];
    
    NSString *tempStr = [[PPAppPlatformKit sharedInstance] current20MinToken];
    if ([tempStr isEqualToString:@""]) {
        return;
    }
    NSString *requsetBodyData = [NSString stringWithFormat:@"{\"username\":\"%@\",\"token\":\"%@\",\"email\":\"%@\",\"email_code\":\"%@\",\"version\":\"%@\"}",
                                 PP_REQUEST_USERNAME,tempStr,paramEmail,paramEmail_Code,PP_REQUEST_VERSION];
    
    NSString *requsetBodyDataLog = [NSString stringWithFormat:@"{\"username\":\"%@\",\"email\":\"%@\",\"email_code\":\"%@\",\"version\":\"%@\"}",
                                    PP_REQUEST_USERNAME,paramEmail,paramEmail_Code,PP_REQUEST_VERSION];
    
    
    NSString *requestURLStr = [PP_NEWADDRESS stringByAppendingString:PP_PHP_REQUEST_GETCHECKUSEREMAILCODE_SDKADDRESS];
    NSURL *requestUrl = [NSURL URLWithString:[requestURLStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:requestUrl];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:[requsetBodyData dataUsingEncoding:NSUTF8StringEncoding]];
    [request setTimeoutInterval:10];
    if (PP_ISNSLOG) {
        NSLog(@"请求得url地址requestURLStr--\n%@",requestURLStr);
        NSLog(@"请求post数据 --\n%@  --and pwd"  ,requsetBodyDataLog);
    }
    [ppRequest sendRequest:request];
    [ppRequest release];
}
//绑定
- (void)getBindEmail:(NSString *)paramEmail
            Nextcode:(NSString *)paramNextcode
{
    if (PP_ISNSLOG) {
        NSLog(@"BEGIN - getBindEmail");
    }
    PPHttpRequest *ppRequest = [[PPHttpRequest alloc] init];
    [ppRequest setDelegate:self];
    
    NSString *tempStr = [[PPAppPlatformKit sharedInstance] current20MinToken];
    if ([tempStr isEqualToString:@""]) {
        return;
    }
    NSString *requsetBodyData = [NSString stringWithFormat:@"{\"username\":\"%@\",\"token\":\"%@\",\"email\":\"%@\",\"nextcode\":\"%@\",\"version\":\"%@\"}",
                                 PP_REQUEST_USERNAME,tempStr,paramEmail,paramNextcode,PP_REQUEST_VERSION];
    
    NSString *requsetBodyDataLog = [NSString stringWithFormat:@"{\"username\":\"%@\",\"email\":\"%@\",\"nextcode\":\"%@\",\"version\":\"%@\"}",
                                    PP_REQUEST_USERNAME,paramEmail,paramNextcode,PP_REQUEST_VERSION];
    
    
    NSString *requestURLStr = [PP_NEWADDRESS stringByAppendingString:PP_PHP_REQUEST_GETBANDEMAIL_SDKADDRESS];
    NSURL *requestUrl = [NSURL URLWithString:[requestURLStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:requestUrl];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:[requsetBodyData dataUsingEncoding:NSUTF8StringEncoding]];
    [request setTimeoutInterval:10];
    if (PP_ISNSLOG) {
        NSLog(@"请求得url地址requestURLStr--\n%@",requestURLStr);
        NSLog(@"请求post数据 --\n%@  --and pwd"  ,requsetBodyDataLog);
    }
    [ppRequest sendRequest:request];
    [ppRequest release];
}

#pragma mark -  密保问题列表，验证问题，绑定问题 -
- (void)getQuestionList
{
    if (PP_ISNSLOG) {
        NSLog(@"BEGIN - getQuestionList");
    }
    PPHttpRequest *ppRequest = [[PPHttpRequest alloc] init];
    [ppRequest setDelegate:self];
    
    NSString *tempStr = [[PPAppPlatformKit sharedInstance] current20MinToken];
    if ([tempStr isEqualToString:@""]) {
        return;
    }
    NSString *requsetBodyData = [NSString stringWithFormat:@"{\"username\":\"%@\",\"token\":\"%@\",\"version\":\"%@\"}",
                                 PP_REQUEST_USERNAME,tempStr,PP_REQUEST_VERSION];
    
    NSString *requsetBodyDataLog = [NSString stringWithFormat:@"{\"username\":\"%@\",\"version\":\"%@\"}",
                                    PP_REQUEST_USERNAME,PP_REQUEST_VERSION];
    
    
    NSString *requestURLStr = [PP_NEWADDRESS stringByAppendingString:PP_PHP_REQUEST_GETQUESTIONLIST_SDKADDRESS];
    NSURL *requestUrl = [NSURL URLWithString:[requestURLStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:requestUrl];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:[requsetBodyData dataUsingEncoding:NSUTF8StringEncoding]];
    [request setTimeoutInterval:10];
    if (PP_ISNSLOG) {
        NSLog(@"请求得url地址requestURLStr--\n%@",requestURLStr);
        NSLog(@"请求post数据 --\n%@  --and pwd"  ,requsetBodyDataLog);
    }
    [ppRequest sendRequest:request];
    [ppRequest release];
}


- (void)getBindQuestion:(int)paramQuestion_1
             Question_2:(int)paramQuestion_2
               Answer_1:(NSString *)paramAnswer_1
               Answer_2:(NSString *)paramAnswer_2
               NextCode:(NSString *)paramNextcode
{
    if (PP_ISNSLOG) {
        NSLog(@"BEGIN - getBindQuestion");
    }
    PPHttpRequest *ppRequest = [[PPHttpRequest alloc] init];
    [ppRequest setDelegate:self];
    
    NSString *tempStr = [[PPAppPlatformKit sharedInstance] current20MinToken];
    if ([tempStr isEqualToString:@""]) {
        return;
    }
    NSString *requsetBodyData = [NSString stringWithFormat:@"{\"username\":\"%@\",\"token\":\"%@\",\"question_1\":\"%d\",\"question_2\":\"%d\",\"answer_1\":\"%@\",\"answer_2\":\"%@\",\"nextcode\":\"%@\",\"version\":\"%@\"}",
                                 PP_REQUEST_USERNAME,tempStr,paramQuestion_1,paramQuestion_2,paramAnswer_1,paramAnswer_2,paramNextcode,PP_REQUEST_VERSION];
    
    NSString *requsetBodyDataLog = [NSString stringWithFormat:@"{\"username\":\"%@\",\"question_1\":\"%d\",\"question_2\":\"%d\",\"answer_1\":\"%@\",\"answer_2\":\"%@\",\"nextcode\":\"%@\",\"version\":\"%@\"}",
                                    PP_REQUEST_USERNAME,paramQuestion_1,paramQuestion_2,paramAnswer_1,paramAnswer_2,paramNextcode,PP_REQUEST_VERSION];
    
    
    NSString *requestURLStr = [PP_NEWADDRESS stringByAppendingString:PP_PHP_REQUEST_GETBINDQUESTION_SDKADDRESS];
    NSURL *requestUrl = [NSURL URLWithString:[requestURLStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:requestUrl];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:[requsetBodyData dataUsingEncoding:NSUTF8StringEncoding]];
    [request setTimeoutInterval:10];
    if (PP_ISNSLOG) {
        NSLog(@"请求得url地址requestURLStr--\n%@",requestURLStr);
        NSLog(@"请求post数据 --\n%@  --and pwd"  ,requsetBodyDataLog);
    }
    [ppRequest sendRequest:request];
    [ppRequest release];
}

-(void)getChkUserQuestion:(NSDictionary *)paramQuestionDictionary
{
    if (PP_ISNSLOG) {
        NSLog(@"BEGIN - getChkUserQuestion");
    }
    PPHttpRequest *ppRequest = [[PPHttpRequest alloc] init];
    [ppRequest setDelegate:self];
    
    NSString *tempStr = [[PPAppPlatformKit sharedInstance] current20MinToken];
    if ([tempStr isEqualToString:@""]) {
        return;
    }
    NSString *requsetBodyData = [NSString stringWithFormat:@"{\"username\":\"%@\",\"token\":\"%@\",\"question_1\":\"%d\",\"question_2\":\"%d\",\"answer_1\":\"%@\",\"answer_2\":\"%@\",\"version\":\"%@\"}",
                                 PP_REQUEST_USERNAME,tempStr,[[paramQuestionDictionary objectForKey:@"question_1"] intValue] ,[[paramQuestionDictionary objectForKey:@"question_2"] intValue],[paramQuestionDictionary objectForKey:@"answer_1"],[paramQuestionDictionary objectForKey:@"answer_2"],PP_REQUEST_VERSION];
    
    NSString *requsetBodyDataLog = [NSString stringWithFormat:@"{\"username\":\"%@\",\"question_1\":\"%d\",\"question_2\":\"%d\",\"answer_1\":\"%@\",\"answer_2\":\"%@\",\"version\":\"%@\"}",
                                    PP_REQUEST_USERNAME,[[paramQuestionDictionary objectForKey:@"question_1"] intValue] ,[[paramQuestionDictionary objectForKey:@"question_2"] intValue],[paramQuestionDictionary objectForKey:@"answer_1"],[paramQuestionDictionary objectForKey:@"answer_2"],PP_REQUEST_VERSION];
    
    
    NSString *requestURLStr = [PP_NEWADDRESS stringByAppendingString:PP_PHP_REQUEST_GETCHEUSERQUESTION_SDKADDRESS];
    NSURL *requestUrl = [NSURL URLWithString:[requestURLStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:requestUrl];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:[requsetBodyData dataUsingEncoding:NSUTF8StringEncoding]];
    [request setTimeoutInterval:10];
    if (PP_ISNSLOG) {
        NSLog(@"请求得url地址requestURLStr--\n%@",requestURLStr);
        NSLog(@"请求post数据 --\n%@  --and pwd"  ,requsetBodyDataLog);
    }
    [ppRequest sendRequest:request];
    [ppRequest release];

}

#pragma mark - 查询 充值记录以 时间，订单号 -

- (void)getRechargeRecordByTime:(PPOrderStatus)paramOrderStatus
                           Data:(PPOrderData)paramData
                           Page:(int)paramPage
{
    if (PP_ISNSLOG) {
        NSLog(@"BEGIN - getRechargeRecordByTime");
    }
    PPHttpRequest *ppRequest = [[PPHttpRequest alloc] init];
    [ppRequest setDelegate:self];
    
    NSString *tempStr = [[PPAppPlatformKit sharedInstance] current20MinToken];
    if ([tempStr isEqualToString:@""]) {
        return;
    }
    
    NSString *requsetBodyData = [NSString stringWithFormat:@"{\"username\":\"%@\",\"token\":\"%@\",\"uid\":\"%lld\",\"app_id\":\"%d\",\"status\":\"%d\",\"date\":\"%d\",\"page\":\"%d\",\"version\":\"%@\"}",
                                 PP_REQUEST_USERNAME,tempStr,PP_REQUEST_USERID,PP_REQUEST_APPID,paramOrderStatus,paramData,paramPage,PP_REQUEST_VERSION];
    
    
    NSString *requsetBodyDataLog = [NSString stringWithFormat:@"{\"username\":\"%@\",\"uid\":\"%lld\",\"app_id\":\"%d\",\"status\":\"%d\",\"date\":\"%d\",\"page\":\"%d\",\"version\":\"%@\"}",
                                    PP_REQUEST_USERNAME,PP_REQUEST_USERID,PP_REQUEST_APPID,paramOrderStatus,paramData,paramPage,PP_REQUEST_VERSION];
    
    
    NSString *requestURLStr = [PP_ADDRESS stringByAppendingString:PP_PHP_REQUEST_RECHARGERECIRDBYTIME_SDKADDRESS];
    NSURL *requestUrl = [NSURL URLWithString:[requestURLStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:requestUrl];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:[requsetBodyData dataUsingEncoding:NSUTF8StringEncoding]];
    [request setTimeoutInterval:10];
    if (PP_ISNSLOG) {
        NSLog(@"请求得url地址requestURLStr--\n%@",requestURLStr);
        NSLog(@"请求post数据 --\n%@  --and pwd"  ,requsetBodyDataLog);
    }
    [ppRequest sendRequest:request];
    [ppRequest release];
}



- (void)getRechargeRecordByOrderId:(NSString *)paramOrderId
{
    if (PP_ISNSLOG) {
        NSLog(@"BEGIN - getRechargeRecordByOrderId)");
    }
    PPHttpRequest *ppRequest = [[PPHttpRequest alloc] init];
    [ppRequest setDelegate:self];
    
    NSString *tempStr = [[PPAppPlatformKit sharedInstance] current20MinToken];
    if ([tempStr isEqualToString:@""]) {
        return;
    }
    
    NSString *requsetBodyData = [NSString stringWithFormat:@"{\"username\":\"%@\",\"token\":\"%@\",\"uid\":\"%lld\",\"app_id\":\"%d\",\"orderid\":\"%@\",\"version\":\"%@\"}",
                                 PP_REQUEST_USERNAME,tempStr,PP_REQUEST_USERID,PP_REQUEST_APPID,paramOrderId,PP_REQUEST_VERSION];
    
    
    NSString *requsetBodyDataLog = [NSString stringWithFormat:@"{\"username\":\"%@\",\"uid\":\"%lld\",\"app_id\":\"%d\",\"orderid\":\"%@\",\"version\":\"%@\"}",
                                    PP_REQUEST_USERNAME,PP_REQUEST_USERID,PP_REQUEST_APPID,paramOrderId,PP_REQUEST_VERSION];
    
    
    NSString *requestURLStr = [PP_ADDRESS stringByAppendingString:PP_PHP_REQUEST_RECHARGERECIRDBYORDERID_SDKADDRESS];
    NSURL *requestUrl = [NSURL URLWithString:[requestURLStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:requestUrl];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:[requsetBodyData dataUsingEncoding:NSUTF8StringEncoding]];
    [request setTimeoutInterval:10];
    if (PP_ISNSLOG) {
        NSLog(@"请求得url地址requestURLStr--\n%@",requestURLStr);
        NSLog(@"请求post数据 --\n%@  --and pwd"  ,requsetBodyDataLog);
    }
    [ppRequest sendRequest:request];
    [ppRequest release];
}

#pragma mark - 查询 消费记录以 时间，订单号 -

- (void)getConsumptionRecordByTime:(PPOrderStatus)paramOrderStatus
                              Data:(PPOrderData)paramData
                              Page:(int)paramPage
{
    if (PP_ISNSLOG) {
        NSLog(@"BEGIN - getConsumptionRecordByTime)");
    }
    PPHttpRequest *ppRequest = [[PPHttpRequest alloc] init];
    [ppRequest setDelegate:self];
    
    NSString *tempStr = [[PPAppPlatformKit sharedInstance] current20MinToken];
    if ([tempStr isEqualToString:@""]) {
        return;
    }
    
    
    NSString *requsetBodyData = [NSString stringWithFormat:@"{\"username\":\"%@\",\"token\":\"%@\",\"uid\":\"%lld\",\"app_id\":\"%d\",\"status\":\"%d\",\"date\":\"%d\",\"page\":\"%d\",\"version\":\"%@\"}",
                                 PP_REQUEST_USERNAME,tempStr,PP_REQUEST_USERID,PP_REQUEST_APPID,paramOrderStatus,paramData,paramPage,PP_REQUEST_VERSION];
    
    
    NSString *requsetBodyDataLog = [NSString stringWithFormat:@"{\"username\":\"%@\",\"uid\":\"%lld\",\"app_id\":\"%d\",\"status\":\"%d\",\"date\":\"%d\",\"page\":\"%d\",\"version\":\"%@\"}",
                                    PP_REQUEST_USERNAME,PP_REQUEST_USERID,PP_REQUEST_APPID,paramOrderStatus,paramData,paramPage,PP_REQUEST_VERSION];
    
    
    NSString *requestURLStr = [PP_ADDRESS stringByAppendingString:PP_PHP_REQUEST_CONSUMPTIONRECORDBYTIME_SDKADDRESS];
    NSURL *requestUrl = [NSURL URLWithString:[requestURLStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:requestUrl];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:[requsetBodyData dataUsingEncoding:NSUTF8StringEncoding]];
    [request setTimeoutInterval:10];
    if (PP_ISNSLOG) {
        NSLog(@"请求得url地址requestURLStr--\n%@",requestURLStr);
        NSLog(@"请求post数据 --\n%@  --and pwd"  ,requsetBodyDataLog);
    }
    [ppRequest sendRequest:request];
    [ppRequest release];
}


- (void)getConsumptionRecordByOrderId:(NSString *)paramOrderId
{
    if (PP_ISNSLOG) {
        NSLog(@"BEGIN - getConsumptionRecordByOrderId");
    }
    PPHttpRequest *ppRequest = [[PPHttpRequest alloc] init];
    [ppRequest setDelegate:self];
    
    NSString *tempStr = [[PPAppPlatformKit sharedInstance] current20MinToken];
    if ([tempStr isEqualToString:@""]) {
        return;
    }
    
    
    NSString *requsetBodyData = [NSString stringWithFormat:@"{\"username\":\"%@\",\"token\":\"%@\",\"uid\":\"%lld\",\"app_id\":\"%d\",\"orderid\":\"%@\",\"version\":\"%@\"}",
                                 PP_REQUEST_USERNAME,tempStr,PP_REQUEST_USERID,PP_REQUEST_APPID,paramOrderId,PP_REQUEST_VERSION];
    
    
    NSString *requsetBodyDataLog = [NSString stringWithFormat:@"{\"username\":\"%@\",\"uid\":\"%lld\",\"app_id\":\"%d\",\"orderid\":\"%@\",\"version\":\"%@\"}",
                                    PP_REQUEST_USERNAME,PP_REQUEST_USERID,PP_REQUEST_APPID,paramOrderId,PP_REQUEST_VERSION];
    
    
    NSString *requestURLStr = [PP_ADDRESS stringByAppendingString:PP_PHP_REQUEST_CONSUMPTIONRECORDBYORDERID_SDKADDRESS];
    NSURL *requestUrl = [NSURL URLWithString:[requestURLStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:requestUrl];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:[requsetBodyData dataUsingEncoding:NSUTF8StringEncoding]];
    [request setTimeoutInterval:10];
    if (PP_ISNSLOG) {
        NSLog(@"请求得url地址requestURLStr--\n%@",requestURLStr);
        NSLog(@"请求post数据 --\n%@  --and pwd"  ,requsetBodyDataLog);
    }
    [ppRequest sendRequest:request];
    [ppRequest release];
}

#pragma mark - HelpView Request -
/**
 *  获取帮助中心的数据
 */
- (void)getHelpViewJson
{
    if (PP_ISNSLOG) {
        NSLog(@"BEGIN - getHelpViewJson)");
    }
    
    //    id<PPWebViewDataDelegate> delegate = nil;
    //    if (_delegate)
    //        delegate = [_delegate retain];
    
    //    [self cancel];
    
    
    
    PPHttpRequest *ppRequest = [[PPHttpRequest alloc] init];
    [ppRequest setDelegate:self];
    NSString *requestURLStr = [PP_ADDRESS stringByAppendingString:PP_PHP_REQUEST_HELP_SDKADDRESS];
    NSURL *requestUrl = [NSURL URLWithString:[requestURLStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:requestUrl];
    [request setHTTPMethod:@"POST"];
    [request setTimeoutInterval:10];
    if (PP_ISNSLOG) {
        NSLog(@"请求得url地址requestURLStr--\n%@",requestURLStr);
    }
    [ppRequest sendRequest:request];
    [ppRequest release];
}

#pragma mark - 查询余额 -

- (void)ppPPMoneyRequest
{
    if (PP_ISNSLOG) {
        NSLog(@"BEGIN - ppPPMoneyRequest");
    }
    PPHttpRequest *ppRequest = [[PPHttpRequest alloc] init];
    [ppRequest setDelegate:self];
    NSString *requsetBodyData = [NSString stringWithFormat:@"{\"appid\":\"%d\",\"appkey\":\"%@\",\"uid\":\"%llu\",\"uuid\":\"%@\",\"version\":\"%@\"}",
                                 PP_REQUEST_APPID,PP_REQUEST_APPKEY,PP_REQUEST_USERID,
                                 [PPCommon PPUUID],
                                 PP_REQUEST_VERSION];
    NSString *requestURLStr = [PP_ADDRESS stringByAppendingString:PP_PHP_REQUEST_BALANCE_SDKADDRESS];
    NSURL *requestUrl = [NSURL URLWithString:[requestURLStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:requestUrl];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:[requsetBodyData dataUsingEncoding:NSUTF8StringEncoding]];
    [request setTimeoutInterval:10];
    
    if (PP_ISNSLOG) {
        NSLog(@"请求异步查询余额requsetBodyData--\n%@",requsetBodyData);
        NSLog(@"请求异步查询余额得url地址requestURLStr--\n%@",requestURLStr);
    }
    
    [ppRequest sendRequest:request];
    [ppRequest release];
}


#pragma mark - HTTP 回调 -

-(void)ppHttpResponseDidFailWithErrorCallBack:(NSError *)paramError
{
    NSString *string = [paramError localizedDescription];
    if (PP_ISNSLOG) {
        NSLog(@"ppHttpResponseDidFailWithErrorCallBack-%@",string);
    }
    if (_delegate) {
        if ([_delegate respondsToSelector:@selector(ppHttpResponseDidFailWithErrorCallBack:)]) {
            [_delegate ppHttpResponseDidFailWithErrorCallBack:paramError];
        }
    }
    
}


#pragma mark -  所有的HTTP的回调 -

-(void)ppHttpResponseCallBack:(NSDictionary *)paramDic
{
    NSLog(@"paramDic------%@",paramDic);
    id<PPWebViewDataDelegate> delegate = nil;
    if (_delegate) delegate = [_delegate retain];
    
    [self cancel];
    
    if (paramDic == nil) {
        if (delegate) {
            if ([delegate respondsToSelector:@selector(responseDidFailWithErrorCallBack)]) {
                [delegate responseDidFailWithErrorCallBack];
            }
        }
    }

    if (delegate) {
        NSString *getSDKName = [paramDic objectForKey:@"sdk_name"];
        if ([getSDKName isEqualToString:@"getHelp"]) {
            if ([delegate respondsToSelector:@selector(helpViewJsonResponseCallBack:)]) {
                [delegate helpViewJsonResponseCallBack:paramDic];
            }
        }
        else if ([getSDKName isEqualToString:@"getPayOrderByTime"])
        {
            if ([delegate respondsToSelector:@selector(rechargeRecordByTimeJsonResponseCallBack:)]) {
                [delegate rechargeRecordByTimeJsonResponseCallBack:paramDic];
            }
            
        }
        else if ([getSDKName isEqualToString:@"getPayOrderByOrderid"])
        {
            
            if ([delegate respondsToSelector:@selector(rechargeRecordByOrderIdJsonResponseCallBack:)]) {
                [delegate rechargeRecordByOrderIdJsonResponseCallBack:paramDic];
            }
            
        }
        else if ([getSDKName isEqualToString:@"getExchangeOrderByTime"])
        {
            if ([delegate respondsToSelector:@selector(consumptionRecordByTimeJsonResponseCallBack:)]) {
                [delegate consumptionRecordByTimeJsonResponseCallBack:paramDic];
            }
            
        }
        else if ([getSDKName isEqualToString:@"getExchangeOrderByOrderid"])
        {
            
            if ([delegate respondsToSelector:@selector(consumptionRecordByOrderIdJsonResponseCallBack:)]) {
                [delegate consumptionRecordByOrderIdJsonResponseCallBack:paramDic];
            }
            
        }
        else if ([getSDKName isEqualToString:@"safety"])
        {
            
            if ([delegate respondsToSelector:@selector(userInfoSecuityCallBack:)])
            {
                [delegate userInfoSecuityCallBack:paramDic];
            }
            
        }
        else if ([getSDKName isEqualToString:@"getPhoneCode"])
        {
        
            if ([delegate respondsToSelector:@selector(verificationCodeCallBack:)]) {
                [delegate verificationCodeCallBack:paramDic];
            }
        
        }
        else if ([getSDKName isEqualToString:@"bandPhone"])
        {
        
            if ([delegate respondsToSelector:@selector(bindPhoneCallBack:)]) {
                [delegate bindPhoneCallBack:paramDic];
            }
        
        }
        else if ([getSDKName isEqualToString:@"getEmailCode"])
        {
            
            if ([delegate respondsToSelector:@selector(verificationEmailCodeCallBack:)]) {
                [delegate verificationEmailCodeCallBack:paramDic];
            }
            
        }
        else if ([getSDKName isEqualToString:@"chkUserPhone"])
        {
            if ([delegate respondsToSelector:@selector(checkPhoneCallBack:)]) {
                [delegate checkPhoneCallBack:paramDic];
            }
            
        }
        else if ([getSDKName isEqualToString:@"sendBandEmail"])
        {
            if ([delegate respondsToSelector:@selector(bindEmailCallBack:)]) {
                [delegate bindEmailCallBack:paramDic];
            }

        }
        else if ([getSDKName isEqualToString:@"chkUserEmailCode"])
        {
            if ([delegate respondsToSelector:@selector(chkUserEmailCodeCallBack:)]) {
                [delegate chkUserEmailCodeCallBack:paramDic];
            }
        }
        else if ([getSDKName isEqualToString:@"getQuestionList"])
        {
            if ([delegate respondsToSelector:@selector(questionListCallBack:)]) {
                [delegate questionListCallBack:paramDic];
            }
            
        }
        else if ([getSDKName isEqualToString:@"bandQuestion"])
        {
            
            if ([delegate respondsToSelector:@selector(bindQuestionCallBack:)]) {
                [delegate bindQuestionCallBack:paramDic];
            }
        
        }
        else if ([getSDKName isEqualToString:@"findUserNameByPhone"])
        {
        
            if ([delegate respondsToSelector:@selector(findUserNameByPhoneCallBack:)]) {
                [delegate findUserNameByPhoneCallBack:paramDic];
            }
        
        }
        else if ([getSDKName isEqualToString:@"findUserNameByEmail"])
        {
            if ([delegate respondsToSelector:@selector(findUserNameByEmailCallBack:)]) {
                [delegate findUserNameByEmailCallBack:paramDic];
            }
        }
        else if ([getSDKName isEqualToString:@"getPPMoney_sdk"])
        {
            if ([delegate respondsToSelector:@selector(balanceCallBack:)]) {
                [delegate balanceCallBack:paramDic];
            }
        }
        //通过用户名验证邮件密保重置密码
        else if ([getSDKName isEqualToString:@"findPwdByEmail"])
        {
            if ([delegate respondsToSelector:@selector(findPassWordByUserNameCallBack:)]) {
                [delegate findPassWordByUserNameCallBack:paramDic];
            }
        }
        //chkUserQuestion
        else if ([getSDKName isEqualToString:@"chkUserQuestion"])
        {
            if ([delegate respondsToSelector:@selector(checkUserQuestionCallBack:)]) {
                [delegate checkUserQuestionCallBack:paramDic];
            }
        }
        [delegate release];
    }
    
}







@end
