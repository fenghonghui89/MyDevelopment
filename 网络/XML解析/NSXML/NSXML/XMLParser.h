//
//  XMLParser.h
//  NSXML
//
//  Created by hanyfeng on 14-6-23.
//  Copyright (c) 2014年 hanyfeng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XMLParser : NSObject<NSXMLParserDelegate>

@property(nonatomic,strong)NSMutableArray *notes;
@property(nonatomic,copy)NSString *currentTagName;

-(void)start;
@end
