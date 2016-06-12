//
//  MDPickerViewViewController.h
//  MyDevelopmentTest
//
//  Created by hanyfeng on 15/2/28.
//  Copyright (c) 2015年 hanyfeng. All rights reserved.
//

#import "MDBaseViewController.h"

@interface MDPickerViewViewController : MDBaseViewController<UIPickerViewDelegate, UIPickerViewDataSource>
@property (weak, nonatomic) IBOutlet UIPickerView *pickerView;
@property (weak, nonatomic) IBOutlet UILabel *label;

@property (nonatomic, strong)  NSDictionary  *pickerData; //保存全部数据
@property (nonatomic, strong)  NSArray  *pickerProvincesData;//当前的省数据
@property (nonatomic, strong)  NSArray  *pickerCitiesData;//当前的省下面的市数据


- (IBAction)onclick:(id)sender;
@end
