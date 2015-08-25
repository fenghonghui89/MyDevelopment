//
//  MDUILabelViewController.m
//  MyDevelopmentTest
//
//  Created by hanyfeng on 15/2/27.
//  Copyright (c) 2015年 hanyfeng. All rights reserved.
//

#import "MDUILabelViewController.h"

@interface MDUILabelViewController ()

@end

@implementation MDUILabelViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
//    [self customInitUI];
    [self labeltest1];
}

-(void)customInitUI
{
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:@"Using NSAttributed String"];
    
    //颜色
    //NSMakeRange(0,5) 起始位置，长度，空格算1
    [str addAttribute:NSForegroundColorAttributeName value:[UIColor blueColor] range:NSMakeRange(0,5)];
    [str addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(6,12)];
    [str addAttribute:NSForegroundColorAttributeName value:[UIColor greenColor] range:NSMakeRange(19,6)];
    
    //字号
    [str addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"Arial-BoldItalicMT" size:15.0] range:NSMakeRange(0, 5)];
    [str addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"HelveticaNeue-Bold" size:15.0] range:NSMakeRange(6, 12)];
    [str addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"Courier-BoldOblique" size:15.0] range:NSMakeRange(19, 6)];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(50, 50, 200, 20)];
    [label setAttributedText:str];
    [self.view addSubview:label];
}

-(void)labeltest1
{
    NSString *txt= @"dffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffaa";
    
    //IOS7 - 改变label字体为Helvetica，大小为12号字
    UILabel *testLabel3      = [[UILabel alloc] initWithFrame:CGRectMake(10, 300, 200, 21)];
    [testLabel3 setBackgroundColor:[UIColor greenColor]];
    testLabel3.numberOfLines = 0;
    testLabel3.text          = txt;
    
    //字体名称：点击NSFontAttributeName，旁边绿色的注释有写  字体大小
    [testLabel3 setFont:[UIFont fontWithName:@"Helvetica" size:12.0]];
    CGSize labelSize3        = [self getStringSizeWithString:txt andFont:12 andWidth:200 andHeight:0];
    testLabel3.frame         = CGRectMake(testLabel3.frame.origin.x, testLabel3.frame.origin.y, labelSize3.width, labelSize3.height);
    NSLog(@"%@",NSStringFromCGRect(testLabel3.frame));
    [self.view addSubview:testLabel3];

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
@end
