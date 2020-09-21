//
//  ObjcTest.m
//  HanyOCLanguageDemo
//
//  Created by hanyfeng on 2020/9/21.
//  Copyright © 2020 MD. All rights reserved.
//
/*
 iOS底层原理
 
 探寻Class的本质
 https://www.jianshu.com/p/74db5638f34f
 */

#import "ObjcTest.h"
#import <objc/runtime.h>

#import "Person.h"
#import "Student3.h"

@implementation ObjcTest

-(void)test30{

    /*
     我们可以总结内存对齐为两个原则：
     原则 1. 前面的地址必须是后面的地址正数倍,不是就补齐。
     原则 2. 整个Struct的地址必须是最大字节的整数倍。
     
     我们发现只要是继承自NSObject的对象，那么底层结构体内一定有一个isa指针。
     那么他们所占的内存空间是多少呢？单纯的将指针和成员变量所占的内存相加即可吗？上述代码实际打印的内容是16 16，也就是说，person对象和student对象所占用的内存空间都为16个字节。
     其实实际上person对象确实只使用了12个字节。但是因为内存对齐的原因。使person对象也占用16个字节。

     编译器在给结构体开辟空间时，首先找到结构体中最宽的基本数据类型，然后寻找内存地址能是该基本数据类型的整倍的位置，作为结构体的首地址。将这个最宽的基本数据类型的大小作为对齐模数。
     为结构体的一个成员开辟空间之前，编译器首先检查预开辟空间的首地址相对于结构体首地址的偏移是否是本成员的整数倍，若是，则存放本成员，反之，则在本成员和上一个成员之间填充一定的字节，以达到整数倍的要求，也就是将预开辟空间的首地址后移几个字节。
     
     我们可以总结内存对齐为两个原则：
     原则 1. 前面的地址必须是后面的地址正数倍,不是就补齐。
     原则 2. 整个Struct的地址必须是最大字节的整数倍。
     
     通过上述内存对齐的原则我们来看，person对象的第一个地址要存放isa指针需要8个字节，第二个地址要存放_age成员变量需要4个字节，根据原则一，8是4的整数倍，符合原则一，不需要补齐。然后检查原则2，目前person对象共占据12个字节的内存，不是最大字节数8个字节的整数倍，所以需要补齐4个字节，因此person对象就占用16个字节空间。

     而对于student对象，我们知道sutdent对象中，包含person对象的结构体实现，和一个int类型的_no成员变量，同样isa指针8个字节，_age成员变量4个字节，_no成员变量4个字节，刚好满足原则1和原则2，所以student对象占据的内存空间也是16个字节。
     */
    Person *p = Person.new;
    p.age = 12;
    
    Student3 *s = Student3.new;
    s.age = 12;
    s.shengao = 12;
    NSLog(@"%zd,%zd,%zd", class_getInstanceSize([NSObject class]) ,class_getInstanceSize([Person class]),class_getInstanceSize([Student3 class]));
        
    /*
     8,16,16
     */
}

- (void)test3{
    
    Student3 *p = Student3.new;//对象
    Student3 *p1 = Student3.new;//对象
    
    //class对象：每一个类在内存中有且只有一个class对象
    Class pc = [Student3 class];
    Class pc_ = object_getClass(p);//runtime
    Class pc1_ = object_getClass(p1);
    NSLog(@"class:%p %p %p", pc,pc_,pc1_);
    NSLog(@"class:%@ %@ %@", pc,pc_,pc1_);
    
    //类的元对象：每个类在内存中有且只有一个元对象，不同类的元类对象不同
    Class pcm1 = object_getClass([Student3 class]);
    Class pcm2 = object_getClass(pc1_);
    NSLog(@"meta:%p %p",pcm1,pcm2);
    NSLog(@"meta:%@ %@",pcm1,pcm2);//输出是Student
    
    //类的元对象的isa，最终指向基类的元对象
    Class c1 = object_getClass(pcm1);
    Class c2 = object_getClass(pcm2);
    NSLog(@"meta.meta:%p %p",c1,c2);
    NSLog(@"meta.meta:%@ %@",c1,c2);
    
    //基类的元对象
    Class ncm = object_getClass([NSObject class]);
    NSLog(@"NSObject.meta:%p %@",ncm,ncm);
    
    //基类的元对象的isa，最终指向自己
    Class ncmm = object_getClass(ncm);
    NSLog(@"NSObject.meta->isa:%p %@",ncmm,ncmm);
    
    /*
     instance对象的isa指针指向class对象:
     2020-09-15 19:08:00.277491+0800 TestProjectWithOCNoSB[16094:4322231] class:0x100e89288 0x100e89288 0x100e89288
     2020-09-15 19:08:00.277681+0800 TestProjectWithOCNoSB[16094:4322231] class:Student Student Student
     
     class对象的isa指针指向meta-class对象:
     2020-09-15 19:08:00.277781+0800 TestProjectWithOCNoSB[16094:4322231] meta:0x100e89260 0x100e89260
     2020-09-15 19:08:00.277860+0800 TestProjectWithOCNoSB[16094:4322231] meta:Student Student
     
     meta-class对象的isa指针指向基类的meta-class对象:
     2020-09-15 19:08:00.277921+0800 TestProjectWithOCNoSB[16094:4322231] meta.meta:0x1d57a21f0 0x1d57a21f0
     2020-09-15 19:08:00.277983+0800 TestProjectWithOCNoSB[16094:4322231] meta.meta:NSObject NSObject
     
     基类的meta-class对象:
     2020-09-15 19:08:00.278691+0800 TestProjectWithOCNoSB[16094:4322231] NSObject.meta:0x1d57a21f0 NSObject

     基类的meta-class对象的isa指针，指向自己。
     2020-09-15 19:49:18.102946+0800 TestProjectWithOCNoSB[16141:4331960] NSObject.meta->isa:0x1d57a21f0 NSObject
     */
    
}

-(void)test4{
    
    /*
     我们发现object->isa与objectClass的地址不同，这是因为从64bit开始，isa需要进行一次位运算，才能计算出真实地址。而位运算的值我们可以通过下载objc源代码找到。
     源码地址：https://opensource.apple.com/tarballs/objc4/
     位运算值ISA_MASK:0x0000000ffffffff8
     */
    NSObject *object = [[NSObject alloc] init];
    Class objectClass = [NSObject class];
    Class objectMetaClass = object_getClass([NSObject class]);
            
    NSLog(@"%p %p %p", object, objectClass, objectMetaClass);
    
    /*
     (lldb) p/x object->isa
     (Class) $6 = 0x000001a1d57a2219 NSObject
     
     (lldb) p/x objectClass
     (Class) $7 = 0x00000001d57a2218 NSObject
     
     (lldb) p/x 0x0000000ffffffff8 & 0x000001a1d57a2219
     (long) $9 = 0x00000001d57a2218
     (lldb)
     */
}

-(void)test5{
    
    /*
     当我们以同样的方式打印objectClass->isa指针时，发现无法打印
     同时也发现左边objectClass对象中并没有isa指针。我们来到Class内部看一下
     为了拿到isa指针的地址，我们自己创建一个同样的结构体并通过强制转化拿到isa指针。
     */
    struct xx_cc_objc_class{
        Class isa;
    };

    Class objectClass = [NSObject class];
    struct xx_cc_objc_class *objectClass2 = (__bridge struct xx_cc_objc_class *)(objectClass);
    
    Class objectMetaClass = object_getClass([NSObject class]);
    
    NSLog(@"%p %p %p",objectClass,objectClass2,objectMetaClass);
    
    /*
     文章：objectClass2的isa指针经过位运算之后的地址是meta-class的地址。
     实际：无需经过位运算也能得出
     
     (lldb) p/x objectClass2->isa
     (Class) $6 = 0x00000001d57a21f0
     
     (lldb) p/x objectMetaClass
     (Class) $7 = 0x00000001d57a21f0
     
     (lldb) p/x 0x0000000ffffffff8 & 0x00000001d57a21f0
     (long) $8 = 0x00000001d57a21f0
     */
}
@end
