//
//  DGCPhotoLibraryGridVC.swift
//  Tpages
//
//  Created by 冯鸿辉 on 16/7/20.
//  Copyright © 2016年 DGC. All rights reserved.
//

import UIKit
import Photos
import PhotosUI
class DGCPhotoLibraryGridVC: UIViewController,UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,PHPhotoLibraryChangeObserver,VPImageCropperDelegate{
  
  var assetsFetchResults:PHFetchResult?
  var assetCollection:PHAssetCollection?
  var isTakeHeaderOrBanner:Bool? = false//yes - 头像 no - 背景
  
  @IBOutlet private weak var collectionView: UICollectionView!
  
  private var assetGridThumbnailSize:CGSize?//预览图尺寸 即cell尺寸*缩放率
  private let collectionViewCellIdentifier:String = "cell"
  private var imageManager:PHCachingImageManager?
  private var previousPreheatRect:CGRect?//上一次的预加载区域
  
  //MARK:********************** vc lifecycle **********************
  deinit{
    self.removeObserver()
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    self.customInitUnit()
    self.customInitUI()
    self.addObserver()
  }
  
  override func viewDidAppear(animated: Bool) {
    super.viewDidAppear(animated)
    self.updateCachedAssets()
  }
  
  //MARK:********************** method **********************
  //MARK:- < custom init >
  private func customInitUnit(){
    self.imageManager = PHCachingImageManager()
    self.resetCachedAssets()
  }
  
  private func customInitUI(){
  
    //navi
    let titleLabel:UILabel = UILabel(frame: CGRectMake(0,0,100,44))
    if self.assetCollection == nil {
      titleLabel.text = "全部"
    }else{
      titleLabel.text = self.assetCollection?.localizedTitle
    }
    titleLabel.textColor = UIColor.whiteColor()
    titleLabel.backgroundColor = UIColor.clearColor()
    titleLabel.textAlignment = .Center
    self.navigationItem.titleView = titleLabel
    
    //定义 cell尺寸和预览图尺寸
    let cellunit = (min(SCREEN_HEIGHT, SCREEN_WIDTH)-3) * 0.25
    let scale = UIScreen.mainScreen().scale
    let cellSize = CGSizeMake(cellunit*scale, cellunit*scale)
    self.assetGridThumbnailSize = cellSize
    
    //注册cell
    self.collectionView.registerNib(UINib(nibName: "DGCPhotoLibraryCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: self.collectionViewCellIdentifier)
    
  }
  
  //MARK:- < noti & observer >
  private func addObserver(){
    PHPhotoLibrary.sharedPhotoLibrary().registerChangeObserver(self)
  }
  
  private func removeObserver(){
    PHPhotoLibrary.sharedPhotoLibrary().unregisterChangeObserver(self)
  }
  
  //MARK:- < Asset Caching >
  private func resetCachedAssets(){
    self.imageManager?.stopCachingImagesForAllAssets()
    self.previousPreheatRect = CGRectZero
  }
  
  private func updateCachedAssets(){
  
    //判断vc的视图是否已经显示，没显示则退出
    let isVieVisible:Bool = self.isViewLoaded() && self.view.window != nil
    if isVieVisible == false {
      return
    }
    
    //预加载区域大小为 向上下各延伸屏幕大小的一半
    var preheatRect:CGRect = self.collectionView.bounds//(0,0,320,568-64=504) 注意滚动的时候bound.size会变（基于scrollview特性）
    preheatRect = CGRectInset(preheatRect, 0.0, -0.5*CGRectGetHeight(preheatRect))//(0,-252,320,1008)   原点y:-252   终点y:-252+1008=756
    
    /*
     Check if the collection view is showing an area that is significantly
     different to the last preheated area.
     依据“当前预加载区域”与“上次预加载区域”的“中心点偏移量”是否大于cv高度的三分之一
     判断cv是否在显示一个区域，这个区域是明显不同于上一次的预加载区域
     */
    let delta = abs(CGRectGetMidY(preheatRect)) - CGRectGetMidY(self.previousPreheatRect!)//绝对值(中心点y252-0)
    if delta > CGRectGetHeight(self.collectionView.bounds) / 3.0 {
      
      // Compute the assets to start caching and to stop caching.计算开始缓存和结束缓存的集合
      let addedIndexPaths:NSMutableArray = NSMutableArray()
      let removedIndexPaths:NSMutableArray = NSMutableArray()
      
      self.computeDifferenceBetweenRect(oldRect: self.previousPreheatRect!, andRect: preheatRect,
                                        andRemovedHandler: { (removedRect) in
                                          let indexPaths:NSArray = self.collectionView.aapl_indexPathsForElementsInRect(removedRect)!
                                          removedIndexPaths.addObjectsFromArray(indexPaths as [AnyObject])
        },
                                        andAddedHandler: { (addedRect) in
                                          let indexPaths:NSArray = self.collectionView.aapl_indexPathsForElementsInRect(addedRect)!
                                          addedIndexPaths.addObjectsFromArray(indexPaths as [AnyObject])
      })
      
      // Update the assets the PHCachingImageManager is caching.更新缓存
      let assetsToStartCaching:NSArray = self.assetsAtIndexPaths(addedIndexPaths)
      let assetsToStopCaching:NSArray = self.assetsAtIndexPaths(removedIndexPaths)
      
      self.imageManager?.startCachingImagesForAssets(assetsToStartCaching as! [PHAsset], targetSize: self.assetGridThumbnailSize!, contentMode: .AspectFill, options: nil)
      self.imageManager?.stopCachingImagesForAssets(assetsToStopCaching as! [PHAsset], targetSize: self.assetGridThumbnailSize!, contentMode: .AspectFill, options: nil)
      
      // Store the preheat rect to compare against in the future.
      self.previousPreheatRect = preheatRect;
    }
    
  }
  

  private func computeDifferenceBetweenRect(oldRect oldRect:CGRect,andRect newRect:CGRect,andRemovedHandler removedHandler:(removedRect:CGRect)->Void,andAddedHandler addedHandler:(addedRect:CGRect)->Void){
    
    if (CGRectIntersectsRect(newRect, oldRect)) {//如果两个矩形有交叉
      //minY 一般为坐标原点y;maxY 一般为高度
      let oldMinY:CGFloat = CGRectGetMinY(oldRect);
      let oldMaxY:CGFloat = CGRectGetMaxY(oldRect);
      let newMinY:CGFloat = CGRectGetMinY(newRect);
      let newMaxY:CGFloat = CGRectGetMaxY(newRect);
      dlog("~~~~\(oldMinY) \(oldMaxY) \(newMinY) \(newMaxY)")
      
      if (newMinY > oldMinY) {//下滚
        let rectToRemove:CGRect = CGRectMake(newRect.origin.x, oldMinY, newRect.size.width, (newMinY - oldMinY));//退出屏幕的区域
        removedHandler(removedRect: rectToRemove);
      }
      
      if (newMinY < oldMinY) {//初始 回滚
        let rectToAdd:CGRect = CGRectMake(newRect.origin.x, newMinY, newRect.size.width, (oldMinY - newMinY));//进入屏幕的区域
        addedHandler(addedRect: rectToAdd);
      }
      
      if (newMaxY > oldMaxY) {//初始 下滚
        let rectToAdd:CGRect = CGRectMake(newRect.origin.x, oldMaxY, newRect.size.width, (newMaxY - oldMaxY));//进入屏幕的区域
        addedHandler(addedRect: rectToAdd);
      }
      
      if (newMaxY < oldMaxY) {//回滚
        let rectToRemove:CGRect = CGRectMake(newRect.origin.x, newMaxY, newRect.size.width, (oldMaxY - newMaxY));//退出屏幕的区域
        removedHandler(removedRect: rectToRemove);
      }
      
    } else {//如果两个矩形没有有交叉
      addedHandler(addedRect: newRect);
      removedHandler(removedRect: oldRect);
    }
  }
  

  private func assetsAtIndexPaths(indexPaths:NSArray)->NSArray{
    
    if indexPaths.count == 0 {
      return NSArray()
    }
    
    let assets:NSMutableArray = NSMutableArray(capacity: indexPaths.count)
    for indexPath in indexPaths {
      let asset:PHAsset = self.assetsFetchResults![(indexPath as! NSIndexPath).item] as! PHAsset
      assets.addObject(asset)
    }
    
    return assets
  }

  //MARK:********************** callback **********************
  //MARK:- < UICollectionView >
  func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
    return 1
  }
  
  func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return self.assetsFetchResults!.count
  }
  
  func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
    
    let cell:DGCPhotoLibraryCollectionViewCell = collectionView.dequeueReusableCellWithReuseIdentifier(collectionViewCellIdentifier, forIndexPath: indexPath) as! DGCPhotoLibraryCollectionViewCell
    
    let asset:PHAsset = self.assetsFetchResults![indexPath.item] as! PHAsset
    cell.representedAssetIdentifier = asset.localIdentifier
    
    self.imageManager?.requestImageForAsset(asset,
                                            targetSize: self.assetGridThumbnailSize!,
                                            contentMode: .AspectFill,
                                            options: nil,
                                            resultHandler: { (result:UIImage?, info:[NSObject:AnyObject]?) in
                                              if cell.representedAssetIdentifier == asset.localIdentifier{
                                              cell.thumbnaiImage = result
                                              }
    })
    
    return cell;
  }
  
  
  func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
    
    let vc:VPImageCropperViewController = VPImageCropperViewController()
    vc.asset = self.assetsFetchResults![indexPath.row] as! PHAsset
    vc.limitRatio = 3.0
    vc.delegate = self
    if self.isTakeHeaderOrBanner == true {
      vc.cropFrame = CGRectMake(0, (SCREEN_HEIGHT-SCREEN_WIDTH-NAVI_HEIGHT)*0.5, SCREEN_WIDTH, SCREEN_WIDTH)
    }else{
      vc.cropFrame = CGRectMake(0, (SCREEN_HEIGHT-SCREEN_WIDTH*0.3-NAVI_HEIGHT)*0.5, SCREEN_WIDTH, SCREEN_WIDTH*0.3)
    }
    self.navigationController?.pushViewController(vc, animated: true)
  }
  
  func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
    
    let cellunit = (min(SCREEN_HEIGHT, SCREEN_WIDTH)-3) * 0.25
    let cellSize = CGSizeMake(cellunit, cellunit)
    
    return cellSize
  }
  
  func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAtIndex section: Int) -> CGFloat {
    return 1
  }
  
  func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAtIndex section: Int) -> CGFloat {
    return 1
  }
  
  //MARK:- < PHPhotoLibraryChangeObserver >
  func photoLibraryDidChange(changeInstance: PHChange) {
    
    // Check if there are changes to the assets we are showing.
    let collectionChanges:PHFetchResultChangeDetails? = changeInstance.changeDetailsForFetchResult(self.assetsFetchResults!)
    if collectionChanges == nil {
      return
    }
    
    /*
     Change notifications may be made on a background queue. Re-dispatch to the
     main queue before acting on the change as we'll be updating the UI.
     */
    dispatch_async(dispatch_get_main_queue()) {
      
      self.assetsFetchResults = collectionChanges?.fetchResultAfterChanges
      
      let collectionView:UICollectionView = self.collectionView
      
      if collectionChanges?.hasIncrementalChanges == false || collectionChanges?.hasMoves == true{
        // Reload the collection view if the incremental diffs are not available
        collectionView.reloadData()
      }else{
        /*
         Tell the collection view to animate insertions and deletions if we
         have incremental diffs.
         */
        collectionView.performBatchUpdates({
          let removedIndexes = collectionChanges?.removedIndexes
          if removedIndexes != nil && removedIndexes!.count>0{
            collectionView.deleteItemsAtIndexPaths((removedIndexes?.aapl_indexPathsFromIndexesWithSection(0))! as! [NSIndexPath])
          }
          
          let insertedIndexes = collectionChanges?.removedIndexes
          if insertedIndexes != nil && insertedIndexes!.count>0{
            collectionView.deleteItemsAtIndexPaths((insertedIndexes?.aapl_indexPathsFromIndexesWithSection(0))! as! [NSIndexPath])
          }
          
          let changedIndexes = collectionChanges?.removedIndexes
          if changedIndexes != nil && changedIndexes!.count>0{
            collectionView.deleteItemsAtIndexPaths((changedIndexes?.aapl_indexPathsFromIndexesWithSection(0))! as! [NSIndexPath])
          }
          
          }, completion: nil)
      }
    }
    
  }
  
  //MARK:- < UIScrollViewDelegate >
  func scrollViewDidScroll(scrollView: UIScrollView) {
    self.updateCachedAssets()
  }
  
  //MARK:- < VPImageCropperDelegate >
  func imageCropper(cropperViewController: VPImageCropperViewController!, didFinished editedImage: UIImage!) {
   
    let vc:DGCPhotoPreviewVC = DGCPhotoPreviewVC(nibName: "DGCPhotoPreviewVC", bundle: nil)
    vc.photo = editedImage
    vc.isTakeHeaderOrBanner = self.isTakeHeaderOrBanner
    cropperViewController.navigationController!.pushViewController(vc, animated: true)
  }
  
  func imageCropperDidCancel(cropperViewController: VPImageCropperViewController!) {
    cropperViewController.navigationController?.popViewControllerAnimated(true)
  }
  
}
