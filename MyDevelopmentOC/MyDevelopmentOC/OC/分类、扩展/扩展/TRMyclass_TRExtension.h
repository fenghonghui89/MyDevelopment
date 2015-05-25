//
//  TRMyclass_TRExtension.h
//  my01
//
//  Created by apple on 13-10-24.
//  Copyright (c) 2013年 Hany. All rights reserved.
//

//创建扩展类的方法2：
#import "TRMyclass.h"

@interface TRMyclass ()

//可以在扩展类中声明属性和实例变量，但是私有的，只能类里面调用
//方法也是私有的，但main可以手动输入方法名使用
@property int age;
-(void)methodExtension;

@end
