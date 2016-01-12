//
//  TRViewController.h
//  my04
//
//  Created by HanyFeng on 13-11-11.
//  Copyright (c) 2013年 Hany. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TRTableViewController.h"
@interface TRViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>//方法2、3：根vc继承自uivc，并遵守协议

@property(strong,nonatomic)TRTableViewController* tableViewController;
@property (weak, nonatomic) IBOutlet UIButton *guyftrs;

@end
