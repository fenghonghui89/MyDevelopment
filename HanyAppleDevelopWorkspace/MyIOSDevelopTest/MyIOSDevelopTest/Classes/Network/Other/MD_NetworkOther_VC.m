//
//  MD_NetworkOther_VC.m
//  MyDevelopmentTest
//
//  Created by 冯鸿辉 on 16/6/15.
//  Copyright © 2016年 hanyfeng. All rights reserved.
//


#import "MD_NetworkOther_VC.h"
#import <resolv.h>
#include <arpa/inet.h>
#include <netdb.h>
#include <sys/types.h>
#include <sys/socket.h>
#include <ifaddrs.h>
#include <net/if.h>
@interface MD_NetworkOther_VC ()

@end
@implementation MD_NetworkOther_VC

#pragma mark - ******** override ********
#pragma mark - < vc lifecycle >
-(void)viewDidLoad{

  [super viewDidLoad];
  
  [self dns_resolving];
}

#pragma mark - ******** method ********

#pragma mark - < dns解析 >
-(void)dns_resolving{

  unsigned char auResult[512];
  int nBytesRead = 0;
  
  nBytesRead = res_query("www.baidu.com", ns_c_in, ns_t_a, auResult, sizeof(auResult));
  
  ns_msg handle;
  ns_initparse(auResult, nBytesRead, &handle);
  
  NSMutableArray *ipList = nil;
  int msg_count = ns_msg_count(handle, ns_s_an);
  if (msg_count > 0) {
    ipList = [[NSMutableArray alloc] initWithCapacity:msg_count];
    for(int rrnum = 0; rrnum < msg_count; rrnum++) {
      ns_rr rr;
      if(ns_parserr(&handle, ns_s_an, rrnum, &rr) == 0) {
        //ip
        char ip1[16];
        strcpy(ip1, inet_ntoa(*(struct in_addr *)ns_rr_rdata(rr)));
        NSString *ipString = [[NSString alloc] initWithCString:ip1 encoding:NSASCIIStringEncoding];
        NSLog(@"%s %@",ip1,ipString);
        
        //将提取到的IP地址放到数组中
        if (![ipString isEqualToString:@""]) {
          [ipList addObject:ipString];
        }
      }
    }
  }

}

-(void)dns_resolving1{
  
  struct hostent *host = gethostbyname("tpages.cn");
  
  struct in_addr **list = (struct in_addr **)host->h_addr_list;
  NSString *ip= [NSString stringWithCString:inet_ntoa(*list[0]) encoding:NSUTF8StringEncoding];
  NSLog(@"ip address is : %@",ip);

}

-(void)dns_resolving2{
  
  Boolean result,bResolved;
  CFHostRef hostRef;
  CFArrayRef addresses = NULL;
  
  CFStringRef hostNameRef = CFStringCreateWithCString(kCFAllocatorDefault, "www.google.com.hk", kCFStringEncodingASCII);
  
  hostRef = CFHostCreateWithName(kCFAllocatorDefault, hostNameRef);
  if (hostRef) {
    result = CFHostStartInfoResolution(hostRef, kCFHostAddresses, NULL);
    if (result == TRUE) {
      addresses = CFHostGetAddressing(hostRef, &result);
    }
  }
  bResolved = result == TRUE ? true : false;
  
  if(bResolved)
  {
    struct sockaddr_in* remoteAddr;
    for(int i = 0; i < CFArrayGetCount(addresses); i++)
    {
      CFDataRef saData = (CFDataRef)CFArrayGetValueAtIndex(addresses, i);
      remoteAddr = (struct sockaddr_in*)CFDataGetBytePtr(saData);
      
      if(remoteAddr != NULL)
      {
        //获取IP地址
        char ip[16];
        strcpy(ip, inet_ntoa(remoteAddr->sin_addr));
        NSLog(@"ip:%s",ip);
      }
    }
  }
  CFRelease(hostNameRef);
  CFRelease(hostRef);
  
  
}
@end
