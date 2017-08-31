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
  

  [self labelTest3];
}

-(void)labeltest
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
  
  NSRange range = NSMakeRange(0, [str length]);
  [str addAttribute:NSUnderlineStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleSingle] range:range];
  
  UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(50, 50, 200, 20)];
  [label setLineBreakMode:NSLineBreakByCharWrapping];//自动折行设置
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

-(void)labelTest3{

    NSString *str1 = @"$ 测试测试测试测试测试测试测              试\n测试测试测试测试测试测试测试\n测试测试测试测试测试测试测试\n测试测试测试测试测试测试测试\n测试测试测试测试测试测试测试\n测试测试测试测试测试             测试测试\n测试测试测试测试测试测试测试\n测试测试测试测试测试测试测试\n测试测试测试测试测试测试测试\n结束";
    
    
    //设置字体和行距
    UIFont *fontNormal = [UIFont systemFontOfSize:15];
    
    NSMutableParagraphStyle*style = [[NSMutableParagraphStyle alloc] init];
    style.lineSpacing = 2;
    style.paragraphSpacing = 30;
    
    NSDictionary *dicsum2 = [NSDictionary dictionaryWithObjectsAndKeys:fontNormal,NSFontAttributeName,style,NSParagraphStyleAttributeName, nil];
    
    NSMutableAttributedString *astr = [[NSMutableAttributedString alloc] initWithString:str1];
    [astr addAttributes:dicsum2 range:NSMakeRange(0, str1.length)];
    [astr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:22] range:NSMakeRange(0, 1)];
    [astr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:12] range:NSMakeRange(2, str1.length-2)];

    
    MDXXCustomLabel *titleLabel    = [[MDXXCustomLabel alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 100.f, 24.0f)];
    titleLabel.backgroundColor = [UIColor redColor];
    titleLabel.textColor       = [UIColor blackColor];
    titleLabel.font            = [UIFont systemFontOfSize:12.0f];
    titleLabel.textInsets      = UIEdgeInsetsMake(0.f, 15.f, 0.f, 0.f); // 设置左内边距
    titleLabel.attributedText = astr;
    [self.view addSubview:titleLabel];
}
@end

@implementation MDXXCustomLabel

- (instancetype)init {
    if (self = [super init]) {
        _textInsets = UIEdgeInsetsZero;
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        _textInsets = UIEdgeInsetsZero;
    }
    return self;
}

- (void)drawTextInRect:(CGRect)rect {
    [super drawTextInRect:UIEdgeInsetsInsetRect(rect, _textInsets)];
}

@end
