//
//  TRAlbum.m
//  Day5Photo_my
//
//  Created by HanyFeng on 13-12-9.
//  Copyright (c) 2013年 Hany. All rights reserved.
//

#import "TRAlbum.h"

@implementation TRAlbum
- (id)init
{
    self = [super init];
    if (self) {
        self.imagePaths = [NSMutableArray array];
    }
    return self;
}
@end
