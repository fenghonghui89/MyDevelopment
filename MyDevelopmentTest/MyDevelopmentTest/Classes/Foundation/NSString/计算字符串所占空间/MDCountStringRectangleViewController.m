//
//  MDCountStringRectangleViewController.m
//  MyDevelopmentTest
//
//  Created by hanyfeng on 15/2/27.
//  Copyright (c) 2015年 hanyfeng. All rights reserved.
//

#import "MDCountStringRectangleViewController.h"
#import "myUILabel.h"

@interface MDCountStringRectangleViewController ()

@end

@implementation MDCountStringRectangleViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    [self stringtest2];
}

-(void)stringtest1
{
    NSString *txt= @"dffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffaa";
    
    //不限制行号 自适应
    UILabel *testLabel1 = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 200, 20)];
    [testLabel1 setBackgroundColor:[UIColor redColor]];
    testLabel1.numberOfLines = 0; ///相当于不限制行数
    testLabel1.text = txt;
    [testLabel1 sizeToFit];
    [self.view addSubview:testLabel1];
    
    //IOS6下
    UILabel *testLabel2 = [[UILabel alloc] initWithFrame:CGRectMake(10, 150, 200, 21)];
    [testLabel2 setBackgroundColor:[UIColor blueColor]];
    testLabel2.numberOfLines = 8;
    testLabel2.text = txt;
    
    CGSize labelSize2 = [self getStringRect_IOS6:txt andFont:testLabel2.font];
    testLabel2.frame = CGRectMake(testLabel2.frame.origin.x, testLabel2.frame.origin.y, 200, labelSize2.height);
    NSLog(@"%@",NSStringFromCGRect(testLabel2.frame));
    
    [self.view addSubview:testLabel2];
    
    //IOS7 - label默认字体大小为17号字
    UILabel *testLabel3 = [[UILabel alloc] initWithFrame:CGRectMake(10, 300, 200, 21)];
    [testLabel3 setBackgroundColor:[UIColor greenColor]];
    testLabel3.numberOfLines = 8;
    testLabel3.text = txt;
    
    CGSize labelSize3 = [self getStringRect_IOS7:txt andFont:[UIFont systemFontOfSize:17]];
    testLabel3.frame = CGRectMake(testLabel3.frame.origin.x, testLabel3.frame.origin.y, labelSize3.width, labelSize3.height);
    NSLog(@"%@",NSStringFromCGRect(testLabel3.frame));
    [self.view addSubview:testLabel3];
    
}

//计算字符串所占空间
-(void)stringtest2
{
    
    UILabel *label = [UILabel new];
    [label setBackgroundColor:[UIColor greenColor]];
    [label setFont:[UIFont systemFontOfSize:15]];
//    [label setVerticalAlignment:VerticalAlignmentTop];
    [label setNumberOfLines:0];
    [self.view addSubview:label];
    
    NSString *str1 = @"测试测试测试测试测试测试测              试\n测试测试测试测试测试测试测试\n测试测试测试测试测试测试测试\n测试测试测试测试测试测试测试\n测试测试测试测试测试测试测试\n测试测试测试测试测试             测试测试\n测试测试测试测试测试测试测试\n测试测试测试测试测试测试测试\n测试测试测试测试测试测试测试\n结束";

//    UIFont *fontBold = [UIFont fontWithName:@"Helvetica" size:14];
    UIFont *fontNormal = [UIFont systemFontOfSize:15];
    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
    style.lineSpacing = 2;
    NSDictionary *dicsum2 = [NSDictionary dictionaryWithObjectsAndKeys:fontNormal,NSFontAttributeName,style,NSParagraphStyleAttributeName, nil];
    
    CGRect rect = [str1 boundingRectWithSize:CGSizeMake(300, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:dicsum2 context:nil];

    NSMutableAttributedString *astr = [[NSMutableAttributedString alloc] initWithString:str1];
    [astr addAttributes:dicsum2 range:NSMakeRange(0, str1.length)];
    

    [label setAttributedText:astr];
    [label setFrameX:10 y:50 w:rect.size.width h:rect.size.height];
}

#pragma mark - < 工具 > -
-(CGSize)getStringSizeWithString:(NSString *)content andFont:(float)fontSize andWidth:(float)width andHeight:(float)height
{
    float twidth = (width == 0?MAXFLOAT:width);
    float theight = (height == 0?MAXFLOAT:height);
    UIFont *font = [UIFont systemFontOfSize:fontSize];
    
    if ([[[UIDevice currentDevice] systemVersion] floatValue] < 7.0) {
        //获取字符串的大小  ios6
        CGSize size = [content sizeWithFont:font constrainedToSize:CGSizeMake(twidth, theight) lineBreakMode:NSLineBreakByCharWrapping];
        return size;
        
    }else{
        
        //获取字符串的大小  ios7s
        NSDictionary *attribute_dic = @{NSFontAttributeName: font};
        
        //Helvetica字体默认大小：12号字（点击NSFontAttributeName，旁边绿色的注释有写）
        //    NSAttributedString* atrString = [[NSAttributedString alloc] initWithString:aString];
        //    NSRange range = NSMakeRange(0, atrString.length);
        //    NSDictionary *dic = [atrString attributesAtIndex:0 effectiveRange:&range];
        
        CGRect rect = [content boundingRectWithSize:CGSizeMake(twidth, theight)  options:NSStringDrawingUsesLineFragmentOrigin attributes:attribute_dic context:nil];
        
        return  rect.size;
    }
    
    return CGSizeZero;
}


//获取字符串的大小  ios6
- (CGSize)getStringRect_IOS6:(NSString *)aString andFont:(UIFont *)aFont
{
    CGSize size = [aString sizeWithFont:aFont constrainedToSize:CGSizeMake(200, MAXFLOAT) lineBreakMode:NSLineBreakByCharWrapping];
    
    return size;
}

//获取字符串的大小  ios7
- (CGSize)getStringRect_IOS7:(NSString*)aString andFont:(UIFont *)aFont
{
    NSDictionary *attribute_dic = @{NSFontAttributeName: aFont};
    
    //Helvetica字体默认大小：12号字（点击NSFontAttributeName，旁边绿色的注释有写）
    //    NSAttributedString* atrString = [[NSAttributedString alloc] initWithString:aString];
    //    NSRange range = NSMakeRange(0, atrString.length);
    //    NSDictionary *dic = [atrString attributesAtIndex:0 effectiveRange:&range];
    
    CGRect rect = [aString boundingRectWithSize:CGSizeMake(200, MAXFLOAT)  options:NSStringDrawingUsesLineFragmentOrigin attributes:attribute_dic context:nil];
    
    return  rect.size;
}

@end
