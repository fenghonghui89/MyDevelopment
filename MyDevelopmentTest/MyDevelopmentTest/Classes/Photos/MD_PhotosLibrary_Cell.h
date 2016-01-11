//
//  MD_PhotosLibrary_Cell.h
//  MyDevelopmentTest
//
//  Created by 冯鸿辉 on 16/1/11.
//  Copyright © 2016年 hanyfeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MD_PhotosLibrary_Cell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIView *bgview;
@property (weak, nonatomic) IBOutlet UIImageView *albumImageView;
@property (weak, nonatomic) IBOutlet UIImageView *selectedImageView;
@property(nonatomic,strong)UIImage *albumImage;
@property(nonatomic,strong)NSURL *url;
@property(nonatomic,assign)BOOL isTap;

@property (nonatomic, copy) NSString *representedAssetIdentifier;
@end
