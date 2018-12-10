//
//  TRAddPersonViewController.h
//  Day1Persons
//
//  Created by Tarena on 13-12-2.
//  Copyright (c) 2013年 Tarena. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TRPerson.h"
@interface TRAddPersonViewController : UIViewController

@property (nonatomic, strong)NSMutableArray *persons;//联系人数组
@property (nonatomic)int row;//数组下标

@property (weak, nonatomic) IBOutlet UITextField *nameTF;
@property (weak, nonatomic) IBOutlet UITextField *ageTF;
@property (weak, nonatomic) IBOutlet UIButton *button;

@end
