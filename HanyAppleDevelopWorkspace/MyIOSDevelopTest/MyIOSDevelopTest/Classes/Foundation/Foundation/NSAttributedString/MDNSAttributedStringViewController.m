//
//  MDNSAttributedStringViewController.m
//  MyDevelopmentTest
//
//  Created by hanyfeng on 15/8/28.
//  Copyright (c) 2015年 hanyfeng. All rights reserved.
//

#import "MDNSAttributedStringViewController.h"
#import "Masonry.h"
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
    //原始字符串
    NSString *str1 = @"$ 测试测试测试测试测试测试测              试\n测试测试测试测试测试测试测试\n测试测试测试测试测试测试测试\n测试测试测试测试测试测试测试\n测试测试测试测试测试测试测试\n测试测试测试测试测试             测试测试\n测试测试测试测试测试测试测试\n测试测试测试测试测试测试测试\n测试测试测试测试测试测试测试\n结束";
    str1 = @"￥ 9999";

    //显示特性
    UIFont *fontNormal = [UIFont systemFontOfSize:50];
    
    NSMutableParagraphStyle*style = [[NSMutableParagraphStyle alloc] init];
    style.lineSpacing = 0;
    style.paragraphSpacing = 0;
    
    
    
    //attr string
    NSMutableAttributedString *astr = [[NSMutableAttributedString alloc] initWithString:str1];
//    [astr addAttribute:NSFontAttributeName value:fontNormal range:NSMakeRange(0, str1.length)];
//    [astr addAttribute:NSParagraphStyleAttributeName value:style range:NSMakeRange(0, str1.length)];
    [astr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:50] range:NSMakeRange(0, 1)];
    [astr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:50] range:NSMakeRange(2, str1.length-2)];
    
//    NSRange range = NSMakeRange(0, astr.length);
//    NSDictionary *dicsum = [NSDictionary dictionaryWithObjectsAndKeys:fontNormal,NSFontAttributeName,style,NSParagraphStyleAttributeName, nil];
//    [astr addAttributes:dicsum range:NSMakeRange(0, str1.length)];
//    dicsum = [astr attributesAtIndex:0 effectiveRange:&range];
    
    //计算
    NSDictionary *attribute_dic = @{NSFontAttributeName: fontNormal};
    CGRect rect = [str1 boundingRectWithSize:CGSizeMake(300, MAXFLOAT)
                                     options:NSStringDrawingUsesFontLeading
                                  attributes:attribute_dic
                                     context:nil];
    
    
    
    
    //add subview
    UILabel *label0 = [UILabel new];
    [label0 setBackgroundColor:[UIColor greenColor]];
    label0.text = @"xxxx";
    [self.view addSubview:label0];
    [label0 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).with.offset(10);
        make.bottom.equalTo(self.view.mas_bottom).with.offset(-10);
    }];
    
    UILabel *label = [UILabel new];
    [label setBackgroundColor:[UIColor greenColor]];
    [label setNumberOfLines:0];
    [label setAttributedText:astr];
//    [label setFrameX:10 y:50 w:rect.size.width h:rect.size.height];
    [self.view addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(label0.mas_right).with.offset(10);
        make.baseline.equalTo(label0.mas_baseline).with.offset(0);
    }];
}


@end
