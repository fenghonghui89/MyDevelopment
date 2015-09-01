//
//  TRViewController.h
//  homework2
//
//  Created by HanyFeng on 13-11-19.
//  Copyright (c) 2013年 Hany. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TRViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *textField;
@property(nonatomic,assign)BOOL fromMe;
@property(nonatomic,copy)NSString* message;
@property(nonatomic,strong)UIImage* messageImage;

@end
