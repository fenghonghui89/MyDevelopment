//
//  MD_C_Memory_CFile.c
//  MyDevelopmentTest
//
//  Created by hanyfeng on 15/5/18.
//  Copyright (c) 2015年 hanyfeng. All rights reserved.
//

#include "MD_C_Memory_CFile.h"
#include <stdlib.h>
#include <malloc/malloc.h>
void cMemoryTest0();



void cMemoryTest()
{
    cMemoryTest0();
}



void cMemoryTest0()
{
    //malloc分配内存
    int const *p0 = malloc(sizeof(int)*20);
    printf("p0's address:%p size:%lu\n",p0,malloc_size(p0));
    
    
    
    
    
    //calloc分配内存+清零
    int *p = calloc(3, sizeof(int));
    printf("p's address:%p size:%lu\n",p,malloc_size(p));
    
    //realloc调整空间，如果之前的不够，会开辟新空间，把值赋值过去，并释放旧空间
    int *p_new = realloc(p, 5*sizeof(int));
    printf("p_new's address:%p size:%lu\n",p_new,malloc_size(p_new));
    
    if (p_new) {
        p = p_new;//如果realloc分配成功，把新地址赋值给旧地址，这样旧空间就能保证可以再次被正常使用，因为free旧地址就不会影响旧空间
    }
    
    printf("p's address:%p size:%lu\n",p,malloc_size(p));
    printf("p_new's address:%p size:%lu\n",p_new,malloc_size(p_new));
    
    if (p) {
        for (int i=0; i<4; i++) {
            printf("请输入第%d个数：\n",i+1);
            scanf("%d",p+i);
        }
        for (int i=0; i<4; i++) {
            printf("第%d个数：%d\t",i+1,*(p+i));
            printf("%p\n",p+i);
        }
    }
    
    printf("\n");
    
    //free释放内存（指针）
    free(p);
    p = NULL;
    for (int i=0; i<4; i++) {
//        printf("第%d个数：%d\t",i+1,*(p+i));//数据可能没有立即被清空，只是标识可以被重新使用，系统有自己的算法清理
        printf("%p\n",p+i);
    }

}
