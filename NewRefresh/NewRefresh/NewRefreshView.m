//
//  NewRefreshView.m
//  NewRefresh
//
//  Created by 冯鸿辉 on 16/3/10.
//  Copyright © 2016年 DGC. All rights reserved.
//
static void * NewRefreshViewUIRecover = &NewRefreshViewUIRecover;

#import "NewRefreshView.h"
@interface NewRefreshView()

@end
@implementation NewRefreshView

-(void)awakeFromNib{
  [self customInitUI];
}

-(void)customInitUI{
  self.titleLabel.text = @"下拉可以刷新";
}

-(void)readyUpload{
  self.titleLabel.text = @"松手立即刷新";
}

-(void)uploading:(void(^)(void))block{
  self.titleLabel.text = @"正在刷新";
  block();
}


-(void)finish:(void(^)(void))block{
  self.titleLabel.text = @"刷新完成";
}

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context{
  if ([keyPath isEqualToString:@"webview.scrollView.contentOffset"]) {
//    NSLog(@"=======%@",NSStringFromCGPoint(self.webview.scrollView.contentOffset));
  }
}

@end
