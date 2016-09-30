//
//  MD_NSRange_VC.m
//  MyIOSDevelopTest
//
//  Created by 冯鸿辉 on 2016/9/30.
//  Copyright © 2016年 hanyfeng. All rights reserved.
//

#import "MD_NSRange_VC.h"


@interface MD_NSRange_VC ()

@end
@implementation MD_NSRange_VC
#pragma mark - < vc lifecycle > -
-(void)viewDidLoad{

  [super viewDidLoad];
  [self kl_3];
}


#pragma mark - < kl > -

-(void)kl_0{
  
  //共29字符
  NSString *homebrew = @"Imperial India Pale Ale (IPA)";
  
  // Starting at position 25, get 3 characters
  NSRange range = NSMakeRange (25, 3);
  
  // This would also work:
  // NSRange range = {25, 3};
  
  NSLog (@"Beer shortname: %@", [homebrew substringWithRange:range]);//IPA
}

-(void)kl_1{
  
  NSString *homebrew = @"Imperial India Pale Ale (IPA)";
  
  NSRange range = [homebrew rangeOfString:@"IPA"];
  
  // Did we find the string "IPA" ?
  if (range.length > 0)
    NSLog(@"Range is: %@", NSStringFromRange(range));//{25,3}
}

//反向搜索
-(void)kl_2{

  NSString *homebrew = @"Imperial India Pale Ale (IPA)";
  
  // Search for the "ia" starting at the end of string
  NSRange range = [homebrew rangeOfString:@"ia" options:NSBackwardsSearch];
  
  // What did we find
  if (range.length > 0)
    NSLog(@"Range is: %@", NSStringFromRange(range));//{12,2}
}

-(void)kl_3{

  NSArray *arr = @[@"1",@"2",@"3",@"4",@"5",@"6",@"7"];
  NSRange range = NSMakeRange(0, 5);
  NSArray *subArray = [arr subarrayWithRange:range];
  NSLog(@"arr:%@",subArray);//1,2,3,4,5
}
@end
