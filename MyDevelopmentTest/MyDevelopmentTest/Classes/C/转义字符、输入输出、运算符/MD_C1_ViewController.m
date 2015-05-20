//
//  MD_C1_ViewController.m
//  MyDevelopmentTest
//
//  Created by hanyfeng on 15/4/24.
//  Copyright (c) 2015年 hanyfeng. All rights reserved.
//

#import "MD_C1_ViewController.h"
@interface MD_C1_ViewController()
@end
@implementation MD_C1_ViewController
-(void)viewDidLoad
{
    [super viewDidLoad];
    [self ctest2];
}

#pragma mark - 运算符 优先级 结合序

//TODO:算术运算符：+-*&%
-(void)ctest1
{
    printf("7+3=%d\n",7+3);
    printf("7-3=%d\n",7-3);
    printf("7*3=%d\n",7*3);
    printf("7/3=%d\n",7/3);
    printf("7%%3=%d\n",7%3);//转义字符
    
    //printf("7/0=%d\n",7/0);
    //printf("7%%0=%d\n",7%0);0不能被/或%
    
    printf("7/0.0=%f\n",7/0.0f);//0.0可以/，但输出结果为inf
    //printf("7%%0.0=%f\n",7/0.0);0.0不能%
    
    //%的结果符号与被除数相同;如果除数于被除数任一带负号，则/的结果带负号
    printf("-7/3=%d\n",-7/3);
    printf("7/-3=%d\n",7/-3);
    printf("-7%%3=%d\n",-7%3);
    printf("7%%-3=%d\n",7%-3);
}

//TODO:复合赋值、输入输出
-(void)ctest2
{
    int i=0,j=0;
    printf("输入i：");
    scanf("%d",&i);
    printf("i+=3:%d\nj-=3:%d\n",i+=3,j-=3);
    
    /*
     oc项目用scanf会无法输入，可用以下方法解决
     
     方法1：（已验证）
     把scanf去掉，在第二个printf前打断点
     运行到断点时 控制台输入 expr i=你输入数字
     继续运行
     
     方法2：（未验证，涉及重定向）
     //    FILE *freopen(const char *path,const char *mode,FILE *stream);
     //    freopen("in.txt","r",stdin);
     */
}

//TODO:运算符优先级与结合序
-(void)ctest3
{
    int i=5;
    printf("i++:%d\n",i++);
    printf("i:%d\n",i);
    
    int j=5;
    printf("++j:%d\n",++j);
    
    
    int k=5,r=0;
    r= k++ + k++ - ++k + ++k;
    printf("r:%d",r);
    //先运算优先级较高的，同一优先级的按照结合性顺序运算
    //不要运用太多自加自减，对程序有一定危害性，不一定正确
    
    printf("r=%d,i=%d",r,k);
}

//TODO:逻辑运算符
-(void)ctest4
{
    /*
     逻辑运算符 与或非
     只要条件的值为非0，则为真
     */
    int a=11,b=9;
    
    printf("a=%d,b=%d\n",a,b);
    if (a>10&&b>10) {
        printf("a>10&&b>10成立\n");
    }
    
    if (a>10||b>10) {
        printf("a>10||b>10成立\n");
    }
    
    printf("a>10&&b>10的值：%d\n",a>10&&b>10);
    printf("a>10||b>10的值：%d\n",a>10||b>10);
    
    if (!(a>=10)) {//只要条件的值为非0，则为真
        printf("if语句执行了输出\n");
    }
}

//TODO:取地址与间接寻址：& 、*(&i)
-(void)ctest5
{
    int i=99;
    printf("i address:%p\n",&i);
    printf("i value:%d\n",*(&i));
}

//TODO:数据类型转换
-(void)ctest6
{
    char c = 127;
    int i = 200;
    printf("c:%d\n",c+2);
    
    //正常来讲高精度赋值给低精度 有可能出现溢出
    //C语言中不会报错
    c = (char)i;//强制类型转换(推荐)
    printf("c:%d\n",c);
    printf("i:%d\n",i);
}

//TODO:逗号运算符
-(void)ctest7
{
    int a=2,b=3,c=4,x,y;
    y=(x=a+b,x=b+c,a+b+c);//取最后的表达式的值
    printf("a=%d b=%d c=%d\n",a,b,c);
    printf("x=%d y=%d",x,y);
}
@end
