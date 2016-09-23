//
//  MD_PhotoLibrary_GridVC.h
//  MyDevelopmentTest
//
//  Created by 冯鸿辉 on 16/2/1.
//  Copyright © 2016年 hanyfeng. All rights reserved.
//

@import Photos;
@import PhotosUI;
#import "MDBaseViewController.h"

@interface MD_PhotoLibrary_GridVC : MDBaseViewController
@property (nonatomic, strong) PHFetchResult *assetsFetchResults;
@property (nonatomic, strong) PHAssetCollection *assetCollection;
@end
