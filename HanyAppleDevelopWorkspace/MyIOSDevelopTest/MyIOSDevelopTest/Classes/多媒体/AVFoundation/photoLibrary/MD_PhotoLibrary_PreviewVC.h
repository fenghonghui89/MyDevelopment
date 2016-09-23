//
//  MD_PhotoLibrary_PreviewVC.h
//  MyDevelopmentTest
//
//  Created by 冯鸿辉 on 16/2/1.
//  Copyright © 2016年 hanyfeng. All rights reserved.
//

#import "MDBaseViewController.h"
@import Photos;
@import PhotosUI;
@interface MD_PhotoLibrary_PreviewVC : MDBaseViewController
@property(nonatomic,strong)PHAsset *asset;
@property(nonatomic,strong)PHAssetCollection *assetCollection;

@end
