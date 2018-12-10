//
//  XTJLocKey_Root.h
//  XTJMall
//
//  Created by hanyfeng on 2017/8/7.
//  Copyright © 2017年 hanyfeng. All rights reserved.
//

#ifndef XTJLocKey_Root_h
#define XTJLocKey_Root_h



//对应模块的本地化字符串
#define XTJLoclizedString(content) NSLocalizedString(content,content)

#define XTJLocalizableString_MemberCenter(content) NSLocalizedStringFromTable(content, @"XTJLoc_MemberCenter", content)
#define XTJLocalizableString_Common(content) NSLocalizedStringFromTable(content, @"XTJLoc_Common", content)
#define XTJLocalizableString_Cart(content) NSLocalizedStringFromTable(content, @"XTJLoc_Cart", content)
#define XTJLocalizableString_GoodsInfo(content) NSLocalizedStringFromTable(content, @"XTJLoc_GoodsInfo", content)
#define XTJLocalizableString_Home(content) NSLocalizedStringFromTable(content, @"XTJLoc_Home", content)

#import "XTJLocKey_Common.h"
#import "XTJLocKey_MemberCenter.h"
#import "XTJLocKey_Cart.h"
#import "XTJLocKey_GoodsInfo.h"
#import "XTJLocKey_Home.h"

#endif /* XTJLocKey_Root */
