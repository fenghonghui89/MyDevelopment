//
//  MDStringNormalViewController.m
//  MyDevelopmentTest
//
//  Created by hanyfeng on 15/3/10.
//  Copyright (c) 2015年 hanyfeng. All rights reserved.
//

#import "MDStringNormalViewController.h"
#import "TRStudent.h"
#import "MD_String_CustomView.h"

@interface MDStringNormalViewController ()

@end

@implementation MDStringNormalViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self string8];
}

#pragma mark - < action > -
#pragma mark 字符串的创建
/**
 *  字符串的创建
 */
-(void)string1
{
    //存放在代码区，一个字符串对象一旦创建不可改变，不可改变的对象可以重复使用，相同值的字符串对象一般不会创建多个
    NSLog(@"相同值的对象一般不会创建多个");
    //NSString* str1  = [NSString stringWithString:@"hello"];//和下面的声明方法效果一样，所有系统会提示多余
    NSString* str1 = @"hello";
    NSString* str2 = @"hello";
    NSLog(@"str1 address:%p value:%@",str1,str1);
    NSLog(@"str2 address:%p value:%@",str2,str2);
    printf("\n");
    
    //按照格式创建（把后面的字符接在前面字符的占位符标识位置）
    NSLog(@"按照格式创建字符串");
    NSString* str3 = [NSString stringWithFormat:@"World%@",@"Hello"];//类方法创建
    NSLog(@"str3:%@",str3);
    NSString* str4 = [[NSString alloc]initWithFormat:@"%@World%@",@"Hello",@"~~" ];//实例方法创建
    NSLog(@"str4:%@",str4);
    printf("\n");
    
    //空字符串
    NSLog(@"空字符串");
    NSString* str5 = [NSString new];
    NSString* str6 = [NSString string];
    NSLog(@"str5:%p",str5);
    NSLog(@"str6:%p",str6);
    printf("\n");
    
    //创建存放在堆内存的字符串
    NSLog(@"创建存放在堆内存的字符串");
    NSString* str7 = [NSString stringWithFormat:@"%@%@",@"Hello",@"World"];
    NSLog(@"str7 address:%p value:%@",str7,str7);
    printf("\n");
    
    //通过文件内容创建字符串
    //用终端touch命令创建的文档比较干净，encoding参数是需要输出中文时所需要的字符集
    NSLog(@"通过文件内容创建字符串");
    NSString* str8 = [NSString stringWithContentsOfFile:@"/Users/apple/Documents/Foundation/20131025/my06/abc.txt" encoding:NSUTF8StringEncoding error:nil];
    NSLog(@"str8 value:%@",str8);
    printf("\n");

}

#pragma mark 比较两个字符串是否一样或者谁大谁小
/**
 *  比较两个字符串是否一样或者谁大谁小
 */
-(void)string2
{
    //比较两个字符串是否完全一样
    NSLog(@"比较两个字符串是否完全一样");
    NSString* str1 = @"abc";
    NSString* str2 = @"aBC";
    NSLog(@"str1:%@ str2:%@",str1,str2);
    BOOL b = [str1 isEqualToString:str2];
    if (b) {
        NSLog(@"一样");
    }else{
        NSLog(@"不一样");
    }
    printf("\n");
    
    //可按command键查看下面参数为枚举类型，前一个元素比上一个值+1
    NSLog(@"查看Ascending、Same、Descending的值");
    NSLog(@"NSOrderedAscending:%ld",NSOrderedAscending);//前<后
    NSLog(@"NSOrderedSame:%ld",NSOrderedSame);//前=后
    NSLog(@"NSOrderedDescending:%ld",NSOrderedDescending);//前>后
    printf("\n");
    
    //区分大小写比较两个字符串
    //如果彼此的第一个字符可以比较出大小，就会得出结果，不管后面的字符如何，如果第一个个字符一样，则比较第二个，直到有字符比较出大小
    NSLog(@"区分大小写比较两个字符串");
    NSString* str3 = @"acc";
    NSString* str4 = @"dab";
    NSLog(@"str3:%@ str4:%@",str3,str4);
    if ([str3 compare:str4]==NSOrderedSame) {
        NSLog(@"一样");
    }else if ([str3 compare:str4]==NSOrderedAscending){
        NSLog(@"前者比后者小");
    }else{
        NSLog(@"前者比后者大");
    }
    printf("\n");
    
    //忽略大小写比较两个字符串(原理同上)，在验证码功能的时候，会用到此方法
    //如果字符串之中含有中文，则用UTF8字符集比较？
    NSLog(@"忽略大小写比较两个字符串");
    NSString* str5 = @"a你b";
    NSString* str6 = @"A我C";
    NSLog(@"str5:%@ str6:%@",str5,str6);
    if ([str5 caseInsensitiveCompare:str6]==NSOrderedSame) {
        NSLog(@"一样");
    }else if ([str5 caseInsensitiveCompare:str6]==NSOrderedAscending){
        NSLog(@"前者比后者小");
    }else{
        NSLog(@"前者比后者大");
    }
    printf("\n");

}

#pragma mark 字符串与基本类型、引用类型的互相转换（重写description方法）、字母的大小写转换
/**
 *  字符串与基本类型、引用类型的互相转换（重写description方法）、字母的大小写转换
 */
-(void)string3
{
    //基本类型与字符串类型的互相转换
    NSLog(@"字符串转为基本类型");
    NSString* s1 = @"123";
    NSString* s2 = @"3.14";
    NSString* s3 = @"YES";
    int i1 = [s1 intValue];
    float f2 = [s2 floatValue];
    BOOL b3 = [s3 boolValue];
    NSLog(@"i1:%d,f2:%.3g,b3:%d",i1,f2,b3);
    printf("\n");
    
    NSLog(@"基本类型转为字符串");
    int i4 = 99;
    float f5 = 9.99;
    BOOL b6 = YES;
    NSString* s4 = [NSString stringWithFormat:@"%d",i4];
    NSString* s5 = [NSString stringWithFormat:@"%.3f",f5];
    NSString* s6 = [NSString stringWithFormat:@"%d",b6];
    NSLog(@"s4:%@,s5:%@,s6:%@",s4,s5,s6);
    printf("\n");
    
    //引用数据类型的转换
    //重写description方法，返回对象的内容
    NSLog(@"引用数据类型的转换");
    TRStudent* student = [TRStudent new];
    student.age = 18;
    NSLog(@"student :%p",student);//输出地址
    NSLog(@"student :%@",student);//输出实例变量（如不重写方法，默认输出对象名+地址）
    printf("\n");
    
    //字符串的大小写转换
    NSLog(@"字符串的大小写转换");
    NSString* str4 = @"a我c";//中文按原样输出
    NSString* str5 = @"ABC";
    NSString* str6 = @"aBC";
    NSLog(@"%@",[str4 uppercaseString]);//全部变大写
    NSLog(@"%@",[str5 lowercaseString]);//全部变小写
    NSLog(@"%@",[str6 capitalizedString]);//首字母大写
    printf("\n");

}

#pragma mark 截取字符串的某部分、字符串拼接、如果字符串是文件名，得到前缀后缀
/**
 *  截取字符串的某部分、字符串拼接、如果字符串是文件名，得到前缀后缀
 */
-(void)string4
{
    NSString* str1 = @"abcdefg";
    NSLog(@"str1:%@",str1);

    //从指定下标开始到最后(包含开始位置截取字符串)
    NSString* str2 = [str1 substringFromIndex:2];
    NSLog(@"str2:%@",str2);
    
    //从0开始到指定位置(不包含指定位置)
    NSString* str3 = [str1 substringToIndex:3];
    NSLog(@"str3:%@",str3);

    //指定范围截取字符串，{开始位置（下标），截取的字符数}
    NSRange abc = {3,2};//按command可知NSRange是结构体
    NSString* str4 = [str1 substringWithRange:abc];
    NSLog(@"str4:%@",str4);
    
    //将后字符串追加到前字符串后创建新的字符串(可用原指针指向，但空间已经不同)
    NSString* str5 = @"Hello";
    NSLog(@"str5:%@",str5);
    NSString* str6 = [str5 stringByAppendingString:@"World"];
    NSLog(@"str6:%@",str6);
    
    //将后字符串（可以由多个字符串按照一定格式）加到前字符串后创建新的字符串（同上）
    NSString* str7 = [str5 stringByAppendingFormat:@"%d%g",10,10.1];
    NSLog(@"str7:%@",str7);
    
    //得到字符串的前缀与后缀
    NSString* str8 = @"TRStudent.h";
    BOOL b1 = [str8 hasPrefix:@"TR"];
    BOOL b2 = [str8 hasSuffix:@".h"];
    NSLog(@"b1:%d b2:%d",b1,b2);
    
    
    
    NSString *str0 = @"中文my name is xuanyusong";
    NSString *temp = @"中文";
    NSRange rang = [str0 rangeOfString:temp];
    
    NSLog(@"搜索的字符串在str0中起始点的index 为 %ld", rang.location);
    NSLog(@"搜索的字符串在str0中结束点的index 为 %ld", rang.location + rang.length);
    
    //将搜索中的字符串替换成为一个新的字符串
    NSString *str = [str0 stringByReplacingCharactersInRange:rang withString:@"哇咔咔卡卡咔"];
    NSLog(@"替换后字符串为：%@", str);
    
    //将字符串中" " 全部替换成 *
    str = [str0 stringByReplacingOccurrencesOfString :@" " withString:@"*"];
    NSLog(@"替换后字符串为：%@", str);
}

#pragma mark NSMutableString初始化
/**
 *  NSMutableString初始化
 */
-(void)string5
{
    //初始化（基本上和NSString一样）
    //NSMutableString* str = [NSMutableString new];
    //str = @"abcd";
    //NSMutableString* str = @"abcd";//以上两种声明方法可以输出，但对该对象用方法可能会出错
    NSMutableString* str = [NSMutableString stringWithString:@"abcdefg"];
    NSLog(@"str:%@",str);
}

#pragma mark NSMutableString字符串拼接
/**
 *  NSMutableString字符串拼接
 */
-(void)string6
{
    //可以在指定位置插入字符串，而不用新建字符串(空间一样)
    NSLog(@"可以在指定位置插入字符串，而不用新建字符串");
    NSMutableString* str1 = [NSMutableString stringWithString:@"abcdefg"];
    [str1 insertString:@"123" atIndex:1];//参数：插入的内容/插入的位置下标
    NSLog(@"str1new:%@",str1);
    printf("\n");
    
    //可以替换指定位置的字符串(空间一样)
    NSLog(@"可以替换指定位置的字符串");
    NSMutableString* str2 = [NSMutableString stringWithString:@"abcdefg"];
    NSRange range = {0,4};//参数：插入的位置下标/插入位置后面的需要消除的字符个数，0-不消除只插入
    [str2 replaceCharactersInRange:range withString:@"1234"];
    NSLog(@"str2new:%@",str2);
    printf("\n");
    
    //删除指定位置的字符串，后面字符串会向前补齐(空间一样)
    NSLog(@"删除指定位置的字符串，后面字符串会向前补齐");
    NSMutableString* str3 = [NSMutableString stringWithString:@"abcdefg"];
    NSRange range1 = {1,2};//参数：删除起始位置的下标/要删除的字符数
    [str3 deleteCharactersInRange:range1];
    NSLog(@"str3new:%@",str3);
    printf("\n");
    
    //将后字符串追加到前字符串后创建新的字符串(和NSString一样，空间不一样)
    NSLog(@"将后字符串追加到前字符串后创建新的字符串");
    NSMutableString* str4 = [NSMutableString stringWithString:@"abcdefg"];
    NSMutableString* str5 = [NSMutableString stringWithString:@"abcdefg"];
    str5 = [str4 stringByAppendingString:@"123"];//该方法返回字符串值，所以要有指针变量接收；可以输出，但会有警告
    NSLog(@"str4:%@",str4);
    NSLog(@"str5:%@",str5);
    printf("\n");
    
    ////将后字符串（可以由多个字符串按照一定格式）加到前字符串后创建新的字符串(和NSString一样，空间不一样)
    NSLog(@"将后字符串（可以由多个字符串按照一定格式）加到前字符串后创建新的字符串");
    NSMutableString* str6 = [NSMutableString stringWithString:@"abcdefg"];
    NSMutableString* str7 = [NSMutableString stringWithString:@"abcdefg"];
    str7 = [str6 stringByAppendingFormat:@"%d%@",10,@"ABC"];//该方法返回字符串值，所以要有指针变量接收；可以输出，但会有警告
    NSLog(@"str6:%@",str6);
    NSLog(@"str7:%@",str7);
    printf("\n");
}

#pragma mark drawRect字符串
-(void)string7
{
    MD_String_CustomView *v = [[MD_String_CustomView alloc] initWithFrame:CGRectMake(10, 10, viewW - 20, viewH - 20)];
    [self.view addSubview:v];
}

#pragma mark 去除两边空格
-(void)string8
{
  //去除两边空格
  NSString *str = @"    ss sss    ";
  str = [str stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
  NSLog(@"str:%@",str);
  
  //9.按符号将字符串的内容拆开并转换成数组
  str = @"a.b.c.d.e.f";
  NSArray* array = [str componentsSeparatedByString:@"."];
  NSLog(@"array:%@",array);
}
@end
