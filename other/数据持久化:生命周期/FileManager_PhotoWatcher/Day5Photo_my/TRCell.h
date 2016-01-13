//
//  TRCell.h
//  Day5Photo_my
//
//  Created by HanyFeng on 13-12-10.
//  Copyright (c) 2013年 Hany. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TRAlbum.h"
@interface TRCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *myImageView;
@property (weak, nonatomic) IBOutlet UILabel *mainLabel;
@property (weak, nonatomic) IBOutlet UILabel *subLabel;
@property(nonatomic,strong)TRAlbum* album;
@end
