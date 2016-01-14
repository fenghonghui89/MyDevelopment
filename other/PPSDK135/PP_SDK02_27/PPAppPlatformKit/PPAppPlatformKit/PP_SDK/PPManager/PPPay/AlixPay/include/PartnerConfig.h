//
//  PartnerConfig.h
//  AlipaySdkDemo
//
//  Created by ChaoGanYing on 13-5-3.
//  Copyright (c) 2013年 RenFei. All rights reserved.
//

#ifndef MQPDemo_PartnerConfig_h
#define MQPDemo_PartnerConfig_h


//======充值到铁人=======
//合作商户ID。用签约支付宝账号登录ms.alipay.com后，在账户信息页面获取。
#define PartnerID @"2088901940597149"
//账户ID。用签约支付宝账号登录ms.alipay.com后，在账户信息页面获取。
#define SellerID  @"2088901940597149"

//安全校验码（MD5）密钥  用签约支付宝账号登录ms.alipay.com后，在密钥管理页面获取
//#define MD5_KEY @"uxt01uurwxvstkxpmleeok76ezicp8k4"

//NSString *key =@"";

//商户私钥，自助生成
#define PartnerPrivKey @"MIICdwIBADANBgkqhkiG9w0BAQEFAASCAmEwggJdAgEAAoGBALY6YoHwtXMAfHOJ\
sBM2oDVQjjeDT6DlznKXVVOGR8awrj3r3nlbqzSANaSx/hUwuoe+OFxplC1KQIJa\
1Y6cW8HDFarq0L5gDVlfp4vfAKT2hnsjHXnVVsD6FAksJsog/MnDpvE6BLtBWWe+\
1JgMNCElLGkG/lE5C7oeGY4JmQO7AgMBAAECgYBlqMKlvPRs+Lt09T4eKd5Mf+km\
/QFiQHHgqZ43X3URWiWKc9iEGWi0fEXw4D9f8PROoAbvPxMkBQVh82yqB36D87C2\
Cvd2LT1olM5QRUK11j3F91t+8okbrmzGTmpZLPl56njQ79k57nNzFUW5XZtSHmUd\
cMB0mv8Gpk5rTYfMuQJBAOEYsLVc92rhWsaDZybekfGIVNjUFq05THXTzTRC1sOv\
O54+cPxBykwcQOvU2jLJGcrGJDDR/JdyGNGTMyMRz18CQQDPPwdx4D59qihidpzH\
SuUvTTNedpN6LZYSzSa8p+zmPIb0l5fwOGFZaez5xTiwpAGCKYVOD+SaZ5bbS4i3\
BNUlAkEAspE5rcagaGN59b1MWWN7d5ZlaNVnX+fypg5t3aWgZgBfVTvHufYfG53W\
Sr/CkUNDeL8S+r+6mBHlamxRxuJcFQJAdRYk/J82bwTNYCOnG6kipoC1Pu87DtHm\
caTZ98ffvYwAqvtiaeNQjJWdvtc/2fwupf0TRTERdHKF9ktMaCogyQJBAL5aWO1j\
AHr0eMlXzs0yVebpCjyk957yWBLF4ksaJ13cDHtidak1gBMY5o5oq9/xDV+y2n3q\
hpt4QJCQJ5TSFCM="



//======充值到爱禾=======

//合作商户ID。用签约支付宝账号登录ms.alipay.com后，在账户信息页面获取。
#define PartnerID_AiHe @"2088211680141219"
//账户ID。用签约支付宝账号登录ms.alipay.com后，在账户信息页面获取。
#define SellerID_AiHe  @"2088211680141219"

//安全校验码（MD5）密钥  用签约支付宝账号登录ms.alipay.com后，在密钥管理页面获取
//#define MD5_KEY @"uxt01uurwxvstkxpmleeok76ezicp8k4"

//NSString *key =@"";

//商户私钥，自助生成
#define PartnerPrivKey_AiHe @"MIICdwIBADANBgkqhkiG9w0BAQEFAASCAmEwggJdAgEAAoGBALY6YoHwtXMAfHOJ\
sBM2oDVQjjeDT6DlznKXVVOGR8awrj3r3nlbqzSANaSx/hUwuoe+OFxplC1KQIJa\
1Y6cW8HDFarq0L5gDVlfp4vfAKT2hnsjHXnVVsD6FAksJsog/MnDpvE6BLtBWWe+\
1JgMNCElLGkG/lE5C7oeGY4JmQO7AgMBAAECgYBlqMKlvPRs+Lt09T4eKd5Mf+km\
/QFiQHHgqZ43X3URWiWKc9iEGWi0fEXw4D9f8PROoAbvPxMkBQVh82yqB36D87C2\
Cvd2LT1olM5QRUK11j3F91t+8okbrmzGTmpZLPl56njQ79k57nNzFUW5XZtSHmUd\
cMB0mv8Gpk5rTYfMuQJBAOEYsLVc92rhWsaDZybekfGIVNjUFq05THXTzTRC1sOv\
O54+cPxBykwcQOvU2jLJGcrGJDDR/JdyGNGTMyMRz18CQQDPPwdx4D59qihidpzH\
SuUvTTNedpN6LZYSzSa8p+zmPIb0l5fwOGFZaez5xTiwpAGCKYVOD+SaZ5bbS4i3\
BNUlAkEAspE5rcagaGN59b1MWWN7d5ZlaNVnX+fypg5t3aWgZgBfVTvHufYfG53W\
Sr/CkUNDeL8S+r+6mBHlamxRxuJcFQJAdRYk/J82bwTNYCOnG6kipoC1Pu87DtHm\
caTZ98ffvYwAqvtiaeNQjJWdvtc/2fwupf0TRTERdHKF9ktMaCogyQJBAL5aWO1j\
AHr0eMlXzs0yVebpCjyk957yWBLF4ksaJ13cDHtidak1gBMY5o5oq9/xDV+y2n3q\
hpt4QJCQJ5TSFCM="




//支付宝公钥，用签约支付宝账号登录b.alipay.com后获取。
#define AlipayPubKey   @"MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQDDI6d306Q8fIfCOaTXyiUeJHkrIvYISRcc73s3vF1ZT7XN8RNPwJxo8pWaJMmvyTn9N4HQ632qJBVHf8sxHi/fEsraprwCtzvzQETrNRwVxLO5jVmRGi60j8Ue1efIlzPXV9je9mkjzOmdssymZkh2QhUrCmZYI/FCEa3/cNMW0QIDAQAB"

#define AlipayPubKey1  @"MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQC2OmKB8LVzAHxzibATNqA1UI43\
g0+g5c5yl1VThkfGsK496955W6s0gDWksf4VMLqHvjhcaZQtSkCCWtWOnFvBwxWq\
6tC+YA1ZX6eL3wCk9oZ7Ix151VbA+hQJLCbKIPzJw6bxOgS7QVlnvtSYDDQhJSxp\
Bv5ROQu6HhmOCZkDuwIDAQAB"

#define AlipayPubKey2  @"MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQDDI6d306Q8fIfCOaTXyiUeJHkrIvYISRcc73s3vF1ZT7XN8RNPwJxo8pWaJMmvyTn9N4HQ632qJBVHf8sxHi/fEsraprwCtzvzQETrNRwVxLO5jVmRGi60j8Ue1efIlzPXV9je9mkjzOmdssymZkh2QhUrCmZYI/FCEa3/cNMW0QIDAQAB"





#endif
