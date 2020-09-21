//
//  XXClassInfo.m
//  HanyOCLanguageDemo
//
//  Created by hanyfeng on 2020/9/21.
//  Copyright © 2020 MD. All rights reserved.
//
/*
 iOS底层原理总结 - 探寻Class的本质
 https://www.jianshu.com/p/74db5638f34f
 */

#import "XXClassInfo.h"
#import <objc/runtime.h>

# if __arm64__
#   define ISA_MASK        0x0000000ffffffff8ULL
# elif __x86_64__
#   define ISA_MASK        0x00007ffffffffff8ULL
# endif

#if __LP64__
typedef uint32_t mask_t;
#else
typedef uint16_t mask_t;
#endif
typedef uintptr_t cache_key_t;

struct bucket_t {
    cache_key_t _key;
    IMP _imp;
};

struct cache_t {
    bucket_t *_buckets;
    mask_t _mask;
    mask_t _occupied;
};

struct entsize_list_tt {
    uint32_t entsizeAndFlags;
    uint32_t count;
};

struct method_t {
    SEL name;
    const char *types;
    IMP imp;
};

struct method_list_t : entsize_list_tt {
    method_t first;
};

struct ivar_t {
    int32_t *offset;
    const char *name;
    const char *type;
    uint32_t alignment_raw;
    uint32_t size;
};

struct ivar_list_t : entsize_list_tt {
    ivar_t first;
};

struct property_t {
    const char *name;
    const char *attributes;
};

struct property_list_t : entsize_list_tt {
    property_t first;
};

struct chained_property_list {
    chained_property_list *next;
    uint32_t count;
    property_t list[0];
};

typedef uintptr_t protocol_ref_t;
struct protocol_list_t {
    uintptr_t count;
    protocol_ref_t list[0];
};

struct class_ro_t {
    uint32_t flags;
    uint32_t instanceStart;
    uint32_t instanceSize;  // instance对象占用的内存空间
#ifdef __LP64__
    uint32_t reserved;
#endif
    const uint8_t * ivarLayout;
    const char * name;  // 类名
    method_list_t * baseMethodList;
    protocol_list_t * baseProtocols;
    const ivar_list_t * ivars;  // 成员变量列表
    const uint8_t * weakIvarLayout;
    property_list_t *baseProperties;
};

struct class_rw_t {
    uint32_t flags;
    uint32_t version;
    const class_ro_t *ro;
    method_list_t * methods;    // 方法列表
    property_list_t *properties;    // 属性列表
    const protocol_list_t * protocols;  // 协议列表
    Class firstSubclass;
    Class nextSiblingClass;
    char *demangledName;
};

#define FAST_DATA_MASK          0x00007ffffffffff8UL
struct class_data_bits_t {
    uintptr_t bits;
public:
    class_rw_t* data() { // 提供data()方法进行 & FAST_DATA_MASK 操作
        return (class_rw_t *)(bits & FAST_DATA_MASK);
    }
};

/* OC对象 */
struct xx_objc_object {
    void *isa;
};

/* 类对象 */
struct xx_objc_class : xx_objc_object {
    Class superclass;
    cache_t cache;
    class_data_bits_t bits;
public:
    class_rw_t* data() {
        return bits.data();
    }
    
    xx_objc_class* metaClass() { // 提供metaClass函数，获取元类对象
// 上一篇我们讲解过，isa指针需要经过一次 & ISA_MASK操作之后才得到真正的地址
        return (xx_objc_class *)((long long)isa & ISA_MASK);
    }
};

#pragma mark -

/* Person */
@interface Person_ : NSObject <NSCopying>
{
    @public
    int _age;
}
@property (nonatomic, assign) int height;
- (void)personMethod;
+ (void)personClassMethod;
@end

@implementation Person_
- (void)personMethod {}
+ (void)personClassMethod {}
@end

/* Student */
@interface Student_ : Person_ <NSCoding>
{
    @public
    int _no;
}

@property (nonatomic, assign) int score;
- (void)studentMethod;
+ (void)studentClassMethod;
@end

@implementation Student_
- (void)studentMethod {}
+ (void)studentClassMethod {}
@end

#pragma mark -
@implementation XXClassInfo

-(void)test{
    
    NSObject *object = [[NSObject alloc] init];
    Person_ *person = [[Person_ alloc] init];
    Student_ *student = [[Student_ alloc] init];
    
    //obj.isa->类对象
    xx_objc_class *objectClass = (__bridge xx_objc_class *)[object class];
    xx_objc_class *personClass = (__bridge xx_objc_class *)[person class];
    xx_objc_class *studentClass = (__bridge xx_objc_class *)[student class];
    
    //类对象->data()方法->得到类信息(ro类信息[占据内存、类名、成员变量信息]/对象方法/属性/协议)
    class_rw_t *objectClassData = objectClass->data();
    class_rw_t *personClassData = personClass->data();
    class_rw_t *studentClassData = studentClass->data();
    
    //类对象.isa->元类对象
    xx_objc_class *objectMetaClass = objectClass->metaClass();
    xx_objc_class *personMetaClass = personClass->metaClass();
    xx_objc_class *studentMetaClass = studentClass->metaClass();
    
    //元类对象->data()方法->得到类信息(ro类信息[占据内存、类名、成员变量信息null]/类方法/属性null/协议)
    class_rw_t *objectMetaClassData = objectMetaClass->data();
    class_rw_t *personMetaClassData = personMetaClass->data();
    class_rw_t *studentMetaClassData = studentMetaClass->data();
    
    // 0x00007ffffffffff8
    NSLog(@"%p %p %p %p %p %p",  objectClassData, personClassData, studentClassData,
          objectMetaClassData, personMetaClassData, studentMetaClassData);
}

@end
