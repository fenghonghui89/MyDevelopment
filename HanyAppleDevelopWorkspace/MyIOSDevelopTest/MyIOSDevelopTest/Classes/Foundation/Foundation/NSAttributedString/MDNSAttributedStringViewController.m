//
//  MDNSAttributedStringViewController.m
//  MyDevelopmentTest
//
//  Created by hanyfeng on 15/8/28.
//  Copyright (c) 2015年 hanyfeng. All rights reserved.
//

#import "MDNSAttributedStringViewController.h"
@interface MDNSAttributedStringViewController()

@end
@implementation MDNSAttributedStringViewController
-(void)viewDidLoad
{
    [super viewDidLoad];
    [self stringtest0];
}

//计算富文本字符串所占空间
-(void)stringtest0
{

    NSString *str1 = @"测试测试测试测试测试测试测              试\n测试测试测试测试测试测试测试\n测试测试测试测试测试测试测试\n测试测试测试测试测试测试测试\n测试测试测试测试测试测试测试\n测试测试测试测试测试             测试测试\n测试测试测试测试测试测试测试\n测试测试测试测试测试测试测试\n测试测试测试测试测试测试测试\n结束";
    

    //设置字体和行距
    UIFont *fontBold = [UIFont fontWithName:@"Helvetica" size:14];
    UIFont *fontNormal = [UIFont systemFontOfSize:15];
    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
    style.lineSpacing = 2;
    NSDictionary *dicsum2 = [NSDictionary dictionaryWithObjectsAndKeys:fontNormal,NSFontAttributeName,style,NSParagraphStyleAttributeName, nil];
    
    CGRect rect = [str1 boundingRectWithSize:CGSizeMake(300, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:dicsum2 context:nil];
    
    NSMutableAttributedString *astr = [[NSMutableAttributedString alloc] initWithString:str1];
    [astr addAttributes:dicsum2 range:NSMakeRange(0, str1.length)];//对全部文本设置
//    [astr addAttribute:<#(NSString *)#> value:<#(id)#> range:<#(NSRange)#>];//对部分文本设置
    
    
    UILabel *label = [UILabel new];
    [label setBackgroundColor:[UIColor greenColor]];
    [label setFont:[UIFont systemFontOfSize:15]];
    [label setNumberOfLines:0];
    [self.view addSubview:label];
    [label setAttributedText:astr];
    [label setFrameX:10 y:50 w:rect.size.width h:rect.size.height];
}


@end
