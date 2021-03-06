//
//  MD_PhotoLibrary_GridVC.m
//  MyDevelopmentTest
//
//  Created by 冯鸿辉 on 16/2/1.
//  Copyright © 2016年 hanyfeng. All rights reserved.
//

#import "MD_PhotoLibrary_GridVC.h"
#import "MD_PhotoLibrary_CollectionViewCell.h"
#import "NSIndexSet+Convenience.h"
#import "UICollectionView+Convenience.h"
#import "MD_PhotoLibrary_PreviewVC.h"
static CGSize AssetGridThumbnailSize;//预览图尺寸 即cell尺寸*缩放率
static NSString * const collectionViewCellIdentifier = @"cell";

@interface MD_PhotoLibrary_GridVC ()<UICollectionViewDataSource,UICollectionViewDelegate,PHPhotoLibraryChangeObserver>
@property (weak, nonatomic) IBOutlet UICollectionView *collectionview;
@property (nonatomic, strong) PHCachingImageManager *imageManager;
@property CGRect previousPreheatRect;//上一次的预加载区域
@end

@implementation MD_PhotoLibrary_GridVC

#pragma mark - < vc lifecycle > -
- (void)dealloc {
  [self removeObserver];
}

- (void)viewDidLoad {
  [super viewDidLoad];
  
  [self customInitUnit];
  [self customInitUI];
  [self addObserver];
}

-(void)viewDidAppear:(BOOL)animated{
  [super viewDidAppear:animated];
  [self updateCachedAssets];
}

#pragma mark - < method > -
#pragma mark customInit
-(void)customInitUnit{
  self.imageManager = [[PHCachingImageManager alloc] init];
  [self resetCachedAssets];
}

-(void)customInitUI{
  //定义 cell尺寸和预览图尺寸
  CGFloat cellunit = (MIN(screenH, screenW) - 3) / 4;
  CGFloat scale = [UIScreen mainScreen].scale;
  CGSize cellSize = CGSizeMake(cellunit, cellunit);
  AssetGridThumbnailSize = CGSizeMake(cellSize.width * scale, cellSize.height * scale);
  
  //如果显示的是某个相册的内容（assetCollection属性有值）且支持编辑 添加按钮
  if (!self.assetCollection || [self.assetCollection canPerformEditOperation:PHCollectionEditOperationAddContent]) {
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(handleAddButtonItem:)];
  } else {
    self.navigationItem.rightBarButtonItem = nil;
  }

  //注册cell
  [self.collectionview registerNib:[UINib nibWithNibName:@"MD_PhotoLibrary_CollectionViewCell" bundle:nil] forCellWithReuseIdentifier:collectionViewCellIdentifier];
}

#pragma mark noti & observer
-(void)addObserver{
  [[PHPhotoLibrary sharedPhotoLibrary] registerChangeObserver:self];
}

-(void)removeObserver{
  [[PHPhotoLibrary sharedPhotoLibrary] unregisterChangeObserver:self];
}

#pragma mark Asset Caching
- (void)resetCachedAssets {
  [self.imageManager stopCachingImagesForAllAssets];
  self.previousPreheatRect = CGRectZero;
}

- (void)updateCachedAssets {
  //判断vc的视图是否已经显示，没显示则退出
  BOOL isViewVisible = [self isViewLoaded] && [[self view] window] != nil;
  if (!isViewVisible) { return; }
  
  //预加载区域大小为 向上下各延伸屏幕大小的一半
  CGRect preheatRect = self.collectionview.bounds;//(0,0,320,568-64=504) 注意滚动的时候bound.size会变（基于scrollview特性）
  preheatRect = CGRectInset(preheatRect, 0.0f, -0.5f * CGRectGetHeight(preheatRect));//(0,-252,320,1008)   原点y:-252   终点y:-252+1008=756
  
  /*
   Check if the collection view is showing an area that is significantly
   different to the last preheated area.
   依据“当前预加载区域”与“上次预加载区域”的“中心点偏移量”是否大于cv高度的三分之一
   判断cv是否在显示一个区域，这个区域是明显不同于上一次的预加载区域
   */
  CGFloat delta = ABS(CGRectGetMidY(preheatRect) - CGRectGetMidY(self.previousPreheatRect));//绝对值(中心点y252-0)
  if (delta > CGRectGetHeight(self.collectionview.bounds) / 3.0f) {
    // Compute the assets to start caching and to stop caching.计算开始缓存和结束缓存的集合
    NSMutableArray *addedIndexPaths = [NSMutableArray array];
    NSMutableArray *removedIndexPaths = [NSMutableArray array];
    
    [self computeDifferenceBetweenRect:self.previousPreheatRect andRect:preheatRect removedHandler:^(CGRect removedRect) {
      NSLog(@"moveRect %@",NSStringFromCGRect(removedRect));
      NSArray *indexPaths = [self.collectionview aapl_indexPathsForElementsInRect:removedRect];
      [removedIndexPaths addObjectsFromArray:indexPaths];
    } addedHandler:^(CGRect addedRect) {
      NSLog(@"addedRect %@",NSStringFromCGRect(addedRect));
      NSArray *indexPaths = [self.collectionview aapl_indexPathsForElementsInRect:addedRect];
      [addedIndexPaths addObjectsFromArray:indexPaths];
    }];
    
    NSArray *assetsToStartCaching = [self assetsAtIndexPaths:addedIndexPaths];
    NSArray *assetsToStopCaching = [self assetsAtIndexPaths:removedIndexPaths];
    
    // Update the assets the PHCachingImageManager is caching.更新缓存
    [self.imageManager startCachingImagesForAssets:assetsToStartCaching
                                        targetSize:AssetGridThumbnailSize
                                       contentMode:PHImageContentModeAspectFill
                                           options:nil];
    [self.imageManager stopCachingImagesForAssets:assetsToStopCaching
                                       targetSize:AssetGridThumbnailSize
                                      contentMode:PHImageContentModeAspectFill
                                          options:nil];
    
    // Store the preheat rect to compare against in the future.
    self.previousPreheatRect = preheatRect;
  }
}

- (void)computeDifferenceBetweenRect:(CGRect)oldRect andRect:(CGRect)newRect removedHandler:(void (^)(CGRect removedRect))removedHandler addedHandler:(void (^)(CGRect addedRect))addedHandler {
  if (CGRectIntersectsRect(newRect, oldRect)) {//如果两个矩形有交叉
    //minY 一般为坐标原点y;maxY 一般为高度尽头点y
    CGFloat oldMinY = CGRectGetMinY(oldRect);
    CGFloat oldMaxY = CGRectGetMaxY(oldRect);
    CGFloat newMinY = CGRectGetMinY(newRect);
    CGFloat newMaxY = CGRectGetMaxY(newRect);
    NSLog(@"~~~~%f %f %f %f",oldMinY,oldMaxY,newMinY,newMaxY);
    
    if (newMinY > oldMinY) {//下滚
      CGRect rectToRemove = CGRectMake(newRect.origin.x, oldMinY, newRect.size.width, (newMinY - oldMinY));//退出屏幕的区域
      removedHandler(rectToRemove);
    }
    
    if (newMinY < oldMinY) {//初始 回滚
      CGRect rectToAdd = CGRectMake(newRect.origin.x, newMinY, newRect.size.width, (oldMinY - newMinY));//进入屏幕的区域
      addedHandler(rectToAdd);
    }
    
    if (newMaxY > oldMaxY) {//初始 下滚
      CGRect rectToAdd = CGRectMake(newRect.origin.x, oldMaxY, newRect.size.width, (newMaxY - oldMaxY));//进入屏幕的区域
      addedHandler(rectToAdd);
    }
    
    if (newMaxY < oldMaxY) {//回滚
      CGRect rectToRemove = CGRectMake(newRect.origin.x, newMaxY, newRect.size.width, (oldMaxY - newMaxY));//退出屏幕的区域
      removedHandler(rectToRemove);
    }
    
  } else {//如果两个矩形没有有交叉
    addedHandler(newRect);
    removedHandler(oldRect);
  }
}

- (NSArray *)assetsAtIndexPaths:(NSArray *)indexPaths {
  if (indexPaths.count == 0) { return nil; }
  
  NSMutableArray *assets = [NSMutableArray arrayWithCapacity:indexPaths.count];
  for (NSIndexPath *indexPath in indexPaths) {
    PHAsset *asset = self.assetsFetchResults[indexPath.item];
    [assets addObject:asset];
  }
  
  return assets;
}
#pragma mark - < action > -
- (void)handleAddButtonItem:(id)sender {
  // Create a random dummy image.
  CGRect rect = rand() % 2 == 0 ? CGRectMake(0, 0, 400, 300) : CGRectMake(0, 0, 300, 400);
  UIGraphicsBeginImageContextWithOptions(rect.size, NO, 1.0f);
  [[UIColor colorWithHue:(float)(rand() % 100) / 100 saturation:1.0 brightness:1.0 alpha:1.0] setFill];
  UIRectFillUsingBlendMode(rect, kCGBlendModeNormal);
  UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
  UIGraphicsEndImageContext();
  
  // Add it to the photo library
  [[PHPhotoLibrary sharedPhotoLibrary] performChanges:^{
    PHAssetChangeRequest *assetChangeRequest = [PHAssetChangeRequest creationRequestForAssetFromImage:image];
    
    if (self.assetCollection) {
      PHAssetCollectionChangeRequest *assetCollectionChangeRequest = [PHAssetCollectionChangeRequest changeRequestForAssetCollection:self.assetCollection];
      [assetCollectionChangeRequest addAssets:@[[assetChangeRequest placeholderForCreatedAsset]]];
    }
  } completionHandler:^(BOOL success, NSError *error) {
    if (!success) {
      NSLog(@"Error creating asset: %@", error);
    }
  }];
}
#pragma mark - < callback > -
#pragma mark UICollectionView
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
  return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
  NSInteger count = self.assetsFetchResults.count;
  return count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
  
  MD_PhotoLibrary_CollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:collectionViewCellIdentifier forIndexPath:indexPath];
  PHAsset *asset = self.assetsFetchResults[indexPath.item];
  
  cell.representedAssetIdentifier = asset.localIdentifier;
  
  // Add a badge to the cell if the PHAsset represents a Live Photo.
  if (asset.mediaSubtypes & PHAssetMediaSubtypePhotoLive) {
    // Add Badge Image to the cell to denote that the asset is a Live Photo.
    UIImage *badge = [PHLivePhotoView livePhotoBadgeImageWithOptions:PHLivePhotoBadgeOptionsOverContent];
    cell.livePhotoBadgeImage = badge;
  }
  
  // Request an image for the asset from the PHCachingImageManager.
  [self.imageManager requestImageForAsset:asset
                               targetSize:AssetGridThumbnailSize
                              contentMode:PHImageContentModeAspectFill
                                  options:nil
                            resultHandler:^(UIImage *result, NSDictionary *info) {
                              // Set the cell's thumbnail image if it's still showing the same asset.
                              if ([cell.representedAssetIdentifier isEqualToString:asset.localIdentifier]) {
                                cell.thumbnailImage = result;
                              }
                            }];
  
  return cell;

}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
  CGFloat cellunit = (MIN(screenH, screenW) - 3) / 4;
  CGSize cellSize = CGSizeMake(cellunit, cellunit);
  return cellSize;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
  return 1;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
  return 1;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
  PHAsset *asset = self.assetsFetchResults[indexPath.row];
  PHAssetCollection *assetCollection = self.assetCollection;
  
  MD_PhotoLibrary_PreviewVC *vc = [[MD_PhotoLibrary_PreviewVC alloc] initWithNibName:@"MD_PhotoLibrary_PreviewVC" bundle:nil];
  vc.asset = asset;
  vc.assetCollection = assetCollection;
  [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark PHPhotoLibraryChangeObserver

- (void)photoLibraryDidChange:(PHChange *)changeInstance {
  // Check if there are changes to the assets we are showing.
  PHFetchResultChangeDetails *collectionChanges = [changeInstance changeDetailsForFetchResult:self.assetsFetchResults];
  if (collectionChanges == nil) {
    return;
  }
  
  /*
   Change notifications may be made on a background queue. Re-dispatch to the
   main queue before acting on the change as we'll be updating the UI.
   */
  dispatch_async(dispatch_get_main_queue(), ^{
    // Get the new fetch result.
    self.assetsFetchResults = [collectionChanges fetchResultAfterChanges];
    
    UICollectionView *collectionView = self.collectionview;
    
    if (![collectionChanges hasIncrementalChanges] || [collectionChanges hasMoves]) {
      // Reload the collection view if the incremental diffs are not available
      [collectionView reloadData];
      
    } else {
      /*
       Tell the collection view to animate insertions and deletions if we
       have incremental diffs.
       */
      [collectionView performBatchUpdates:^{
        NSIndexSet *removedIndexes = [collectionChanges removedIndexes];
        if ([removedIndexes count] > 0) {
          [collectionView deleteItemsAtIndexPaths:[removedIndexes aapl_indexPathsFromIndexesWithSection:0]];
        }
        
        NSIndexSet *insertedIndexes = [collectionChanges insertedIndexes];
        if ([insertedIndexes count] > 0) {
          [collectionView insertItemsAtIndexPaths:[insertedIndexes aapl_indexPathsFromIndexesWithSection:0]];
        }
        
        NSIndexSet *changedIndexes = [collectionChanges changedIndexes];
        if ([changedIndexes count] > 0) {
          [collectionView reloadItemsAtIndexPaths:[changedIndexes aapl_indexPathsFromIndexesWithSection:0]];
        }
      } completion:NULL];
    }
    
    [self resetCachedAssets];
  });
}

#pragma mark UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
  // Update cached assets for the new visible area.
  [self updateCachedAssets];
}
@end
