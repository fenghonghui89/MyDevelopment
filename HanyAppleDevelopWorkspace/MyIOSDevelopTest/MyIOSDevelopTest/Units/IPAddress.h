//
//  IPAddress.h
//  MyDevelopmentTest
//
//  Created by 冯鸿辉 on 16/3/25.
//  Copyright © 2016年 hanyfeng. All rights reserved.
//

#ifndef IPAddress_h
#define IPAddress_h

#include <stdio.h>



#define MAXADDRS 32

extern char *if_names[MAXADDRS];
extern char *ip_names[MAXADDRS];
extern char *hw_addrs[MAXADDRS];
extern unsigned long ip_addrs[MAXADDRS];

void InitAddresses();
void FreeAddresses();
void GetIPAddresses();
void GetHWAddresses();


#endif /* IPAddress_h */
