//
//  TRAlbum.h
//  Day5Photo_my
//
//  Created by HanyFeng on 13-12-9.
//  Copyright (c) 2013年 Hany. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TRAlbum : NSObject
@property(nonatomic,copy)NSString* name;
@property(nonatomic,strong)NSMutableArray* imagePaths;
@end
