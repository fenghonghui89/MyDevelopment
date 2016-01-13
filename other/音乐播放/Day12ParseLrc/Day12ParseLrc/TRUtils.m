//
//  TRUtils.m
//  Day12ParseLrc
//
//  Created by Tarena on 13-12-17.
//  Copyright (c) 2013年 Tarena. All rights reserved.
//

#import "TRUtils.h"

@implementation TRUtils
+(NSMutableDictionary *)parseLrcByString:(NSString *)lrcString{
    
    NSMutableDictionary *lrcDic = [NSMutableDictionary dictionary];
    NSArray *lines = [lrcString componentsSeparatedByString:@"\n"];//按换行符把歌词文件中的每一行截取出来并放入到数组
    
    //遍历数组，如果为[0开头（以此排除掉歌词开头的垃圾信息），则按]分割字符串，第一部分为时间，第二部分为歌词（e.g:[00:01.14]怒放的生命）
    for (NSString *line in lines) {
        if ([line hasPrefix:@"[0"]) {
            NSArray *arr = [line componentsSeparatedByString:@"]"];
            NSString *timeString = [arr[0] substringFromIndex:1];//截取时间：“[00:01.14” → “00:01.14”
            NSString *text = arr[1];
            
            //把代表时间的字符串转换为秒（float）并用NSNumber封装为对象类型，然后和歌词组成键值对放进字典
            NSArray *times = [timeString componentsSeparatedByString:@":"];
            float time = [times[0]intValue]*60+[times[1]floatValue];
            [lrcDic setObject:text forKey:[NSNumber numberWithFloat:time-1]];
           /*
            00:12.27 对应 曾经多少次跌倒在路上
            */
        }
    }
    return lrcDic;
}
@end
