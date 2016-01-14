//
//  PPGameVersion.m
//  SDKDemoForFramework
//
//  Created by Seven on 13-12-5.
//  Copyright (c) 2013年 Server. All rights reserved.
//

#import "PPGameVersion.h"

@implementation PPGameVersion
- (id)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (void)dealloc
{
    
    [_version release];
    _version = nil;
    
    [_artWorkUrl release];
    _artWorkUrl = nil;
    
    [_artWorkUrl108 release];
    _artWorkUrl108 = nil;
    
    [_downloadUrl release];
    _downloadUrl = nil;
    
    [_historyVersionArray release];
    _historyVersionArray = nil;
    
    [_newestIpaDescription release];
    _newestIpaDescription = nil;
    
    [super dealloc];
}

@end
