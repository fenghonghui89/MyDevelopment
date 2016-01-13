//
//  TRBigImageViewController.h
//  Day5Photo_my
//
//  Created by HanyFeng on 13-12-10.
//  Copyright (c) 2013年 Hany. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TRAlbum.h"
@interface TRBigImageViewController : UIViewController
@property(nonatomic,strong)TRAlbum* album;
@property(nonatomic,assign)int index;
@end
