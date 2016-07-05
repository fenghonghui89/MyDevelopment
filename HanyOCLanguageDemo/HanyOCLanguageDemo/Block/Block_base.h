//
//  Block_base.h
//  HanyOCLanguageDemo
//
//  Created by 冯鸿辉 on 16/7/5.
//  Copyright © 2016年 MD. All rights reserved.
//
#import <Foundation/Foundation.h>



typedef void (^Block_base_block)(BOOL b);



typedef void (^retryblock)(BOOL b);
typedef void (^Block_base_retryBlock)(BOOL a,retryblock reb);//把retryblock放到外面定义





@class Block_base;
@protocol Block_base_Delegate <NSObject>

@optional
-(void)blockDelegate:(Block_base *)vc block:(Block_base_block)block;

@end



@interface Block_base : NSObject
@property(nonatomic,copy)Block_base_block block;//block做属性
@property(nonatomic,weak)id<Block_base_Delegate> delegate;
-(void)retryBlockMethod:(Block_base_retryBlock)block;


-(void)root_Block_base;
@end
