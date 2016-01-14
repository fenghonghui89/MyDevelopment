//
//  Weibo.m
//  MyWeiboClient
//
//  Created by hanyfeng on 14-9-2.
//  Copyright (c) 2014年 hanyfeng. All rights reserved.
//

#import "Weibo.h"
#import "RTLabel.h"
#import "UIViewExt.h"
@implementation Weibo

//计算cell所占高度
-(float)getWeiboCellHeight
{
    //原微博内容高度
    float mainTextHeight = [HFCommon getTextHeightWithFontSize:14 andWidth:256 andText:_text];

    //转发微博内容高度
    float retTextHeight = 0;
    if (_retweeted_status) {
        NSString *retText = [NSString stringWithFormat:@"@%@:%@",_retweeted_status.weiboUserInfo.screen_name,_retweeted_status.text];
        retTextHeight = [HFCommon getTextHeightWithFontSize:13 andWidth:248 andText:retText];
    }
    
    //图片高度
    float picsHeight = 0;
    if (_pic_urls) {
        int picsCount = _pic_urls.count;
        picsHeight = (picsCount/3 + (picsCount%3==0?0:1))*80 + (picsCount/3 + (picsCount%3==0?0:1) -1)*4;
    }
    if (_retweeted_status.pic_urls) {
        int picsCount = _retweeted_status.pic_urls.count;
        picsHeight = (picsCount/3 + (picsCount%3==0?0:1))*70 + (picsCount/3 + (picsCount%3==0?0:1) -1)*4;
    }

    //其他控件高度-间距、label等
    float otherHeight = 0;
    if (_retweeted_status) {
        if (_retweeted_status.pic_urls) {
            otherHeight = 92;
        }else{
            otherHeight = 88;
        }
    }else{
        if (_pic_urls) {
            otherHeight = 64;
        }else{
            otherHeight = 60;
        }
    }
    
    return mainTextHeight + retTextHeight + picsHeight + otherHeight;
}

@end
