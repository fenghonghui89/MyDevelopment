//
//  MDKVC_View.m
//  MyDevelopmentTest
//
//  Created by 冯鸿辉 on 16/1/29.
//  Copyright © 2016年 hanyfeng. All rights reserved.
//

#import "MDKVO_View.h"
#import "MDStudent.h"
#import "MDDefine.h"
#import "MDTool.h"
@implementation MDKVO_View

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context{

  if ([keyPath isEqualToString:@"student"]) {
    MDStudent *student = [change objectForKey:NSKeyValueChangeNewKey];
    DLog(@"view %@ %@ %@",object,student.bag.brand,context);
  }
  
  if ([keyPath isEqualToString:@"content"]) {
    DLog(@"view %@ %@ %@",object,[change objectForKey:NSKeyValueChangeNewKey],context);
  }
}


@end