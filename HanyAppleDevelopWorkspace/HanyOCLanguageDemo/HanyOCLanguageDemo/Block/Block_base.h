//
//  Block_base.h
//  HanyOCLanguageDemo
//
//  Created by 冯鸿辉 on 16/7/5.
//  Copyright © 2016年 MD. All rights reserved.
//
#import <Foundation/Foundation.h>


//block做block的参数
typedef void (^Type_Block)(NSInteger value,void(^block)(void));
typedef void (^Type_BiggerBlock)(NSInteger value,Type_Block block);








@class Block_base;
@protocol BlockDelegate <NSObject>
@optional
-(void)blockDelegate:(Block_base *)vc data:(NSInteger)data finishDownload:(Type_BiggerBlock)block;
@end




@interface Block_base : NSObject
@property(nonatomic,copy)Type_Block blockParama;
@property(nonatomic,copy)Type_BiggerBlock bigBlockParam;
@property(nonatomic,weak)id<BlockDelegate> delegate;
-(void)downloadFile;
@end
