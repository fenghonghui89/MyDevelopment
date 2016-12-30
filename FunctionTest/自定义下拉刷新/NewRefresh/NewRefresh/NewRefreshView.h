//
//  NewRefreshView.h
//  NewRefresh
//
//  Created by 冯鸿辉 on 16/3/10.
//  Copyright © 2016年 DGC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NewRefreshView : UIView
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
-(void)uploading:(void(^)(void))block;
-(void)readyUpload;
-(void)customInitUI;
-(void)finish:(void(^)(void))block;
@property(nonatomic,strong)UIWebView *webview;
@end
