//
//  TRViewController.m
//  Day1ArchiverPerson
//
//  Created by Tarena on 13-12-2.
//  Copyright (c) 2013年 Tarena. All rights reserved.
//

#import "TRViewController.h"
#import "TRPerson.h"
@interface TRViewController ()

@end

@implementation TRViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
#pragma mark 归档
    //1.准备要归档的对象（该对象遵守NSCoding协议）
    TRPerson *p = [[TRPerson alloc]init];
    p.name = @"张三";
    p.age = 20;
    
    //2.准备一个可变长度的data
    NSMutableData *data = [NSMutableData data];
    
    //3.创建一个归档的对象
    NSKeyedArchiver *arch = [[NSKeyedArchiver alloc]initForWritingWithMutableData:data];
    
    //4.把person 编码进去
    [arch encodeObject:p forKey:@"person"];
    
    //5.完成编码
    [arch finishEncoding];
    NSLog(@"%ld",data.length);
    [data writeToFile:@"/Users/hanyfeng/Desktop/person" atomically:YES];
    
#pragma mark 反归档
    //1.把文件转成data并加入到内存当中
    NSData *personData = [NSData dataWithContentsOfFile:@"/Users/hanyfeng/Desktop/person"];
    
    //创建一个反归档的对象
    NSKeyedUnarchiver *unArch = [[NSKeyedUnarchiver alloc]initForReadingWithData:personData];
    
    //3.解码对象并用对应类型的新对象接收
    TRPerson *unp = [unArch decodeObjectForKey:@"person"];
    
    //4.完成解码
    [unArch finishDecoding];
    NSLog(@"%@   age = %d",unp.name,unp.age);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
