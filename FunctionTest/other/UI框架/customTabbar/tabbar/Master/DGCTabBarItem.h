//
//  DGCTabBarItem.h
//  Tpages.Mall
//
//  Created by 冯鸿辉 on 16/5/5.
//  Copyright © 2016年 GoTravel. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DGCTabBarItem : UIButton
- (id)initWithImage:(UIImage *)image
      selectedImage:(UIImage *)selectedImage
                tag:(NSInteger)tag;
@end
