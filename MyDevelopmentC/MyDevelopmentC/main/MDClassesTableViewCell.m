//
//  MDClassesTableViewCell.m
//  MyDevelopmentTest
//
//  Created by hanyfeng on 15/2/27.
//  Copyright (c) 2015年 hanyfeng. All rights reserved.
//

#import "MDClassesTableViewCell.h"
@interface MDClassesTableViewCell()

@property (strong, nonatomic) IBOutlet UILabel *descLabel;

@end
@implementation MDClassesTableViewCell

#pragma mark - view lifecycle
- (void)awakeFromNib
{
    [self setSelectionStyle:UITableViewCellSelectionStyleNone];
}


-(void)setDic:(NSDictionary *)dic
{
    _dic = dic;
    [self customInitUI];
    [self customInitContent];
}

-(void)customInitUI
{
    NSArray *sub = [self.dic objectForKey:@"sub"];
    if (sub.count > 0) {
        [self setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
    }else{
        [self setAccessoryType:UITableViewCellAccessoryNone];
    }
}

-(void)customInitContent
{
    NSString *desc = [self.dic objectForKey:@"desc"];
    self.descLabel.text = desc;
}



@end
