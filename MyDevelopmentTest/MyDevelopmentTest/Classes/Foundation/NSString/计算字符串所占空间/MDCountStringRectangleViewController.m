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


-(void)stringtest2
{
    NSString *str1 = @"测试测试测试测试测试测试测试\n测试测试测试测试测试测试测试\n测试测试测试测试测试测试测试\n测试测试测试测试测试测试测试\n测试测试测试测试测试测试测试\n测试测试测试测试测试测试测试\n测试测试测试测试测试测试测试\n测试测试测试测试测试测试测试\n测试测试测试测试测试测试测试\n结束";
//    NSString *str1 = @"测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试结束";
    

    UIFont *fontBold = [UIFont fontWithName:@"Helvetica Bold Oblique" size:14];
    UIFont *fontNormal = [UIFont systemFontOfSize:14];
    NSDictionary *dic = @{NSFontAttributeName:fontBold};
    
    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
    style.lineSpacing = 10;
    NSDictionary *dic1 = @{NSParagraphStyleAttributeName:style};
    
//    NSDictionary *dicsum1 = [NSDictionary dictionaryWithObjects:@[fontBold,style] forKeys:@[NSFontAttributeName,NSParagraphStyleAttributeName]];
    NSDictionary *dicsum2 = [NSDictionary dictionaryWithObjectsAndKeys:fontBold,NSFontAttributeName,style,NSParagraphStyleAttributeName, nil];
    
    
    CGSize sizeedit = CGSizeMake(300, MAXFLOAT);
//    CGSize size = [self getStringSizeWithString:str1 andFont:14 andWidth:300 andHeight:0];
    CGRect rect = [str1 boundingRectWithSize:sizeedit options:NSStringDrawingUsesLineFragmentOrigin attributes:dicsum2 context:nil];

    
    
    NSMutableAttributedString *astr = [[NSMutableAttributedString alloc] initWithString:str1];
    [astr addAttributes:dicsum2 range:NSMakeRange(0, str1.length)];
    
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 50, rect.size.width,rect.size.height)];
    [label setBackgroundColor:[UIColor greenColor]];
    [label setFont:fontBold];
//    [label setVerticalAlignment:VerticalAlignmentTop];
    [label setNumberOfLines:0];
//    [label setText:str1];
    [label setAttributedText:astr];
    [self.view addSubview:label];
    
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
