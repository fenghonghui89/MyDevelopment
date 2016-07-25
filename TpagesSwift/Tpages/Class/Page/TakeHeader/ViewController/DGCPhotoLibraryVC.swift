//
//  DGCPhotoLibraryVC.swift
//  Tpages
//
//  Created by 冯鸿辉 on 16/7/20.
//  Copyright © 2016年 DGC. All rights reserved.
//

import UIKit
import Photos

private let AllPhotosReuseIdentifier = "AllPhotosReuseIdentifier"
private let CollectionCellReuseIdentifier = "CollectionCellReuseIdentifier"

class DGCPhotoLibraryVC: UIViewController,UITableViewDataSource,UITableViewDelegate,PHPhotoLibraryChangeObserver {
  
  var isTakeHeaderOrBanner:Bool? = false//yes - 头像 no - 背景
  var sectionFetchResults:NSArray?
  var sectionLocalizedTitles:NSArray?
  @IBOutlet private weak var tableView: UITableView!
  
  //MARK:*************************** vc lifecycle *************************
  deinit{
    self.removeObserver()
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    self.addObserver()
    self.customInitData()
    self.customInitUI()
    self.tableView.reloadData()
  }
  
  //MARK:*************************** mehtod *************************
  //MARK:custom init
  private func customInitData() {
    
    //全部 - PHAsset
    let allPhotosOptions:PHFetchOptions = PHFetchOptions()
    allPhotosOptions.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: true)]
    let allPhotos:PHFetchResult = PHAsset.fetchAssetsWithOptions(allPhotosOptions)
    
    //智能 (PHAssetCollection *)PHCollection - PHAsset
    let smartAlubms:PHFetchResult = PHAssetCollection.fetchAssetCollectionsWithType(.SmartAlbum, subtype: .AlbumRegular, options: nil)
    
    //用户 (PHAssetCollection *)PHCollection - PHAsset
    let topLevelUserCollections:PHFetchResult = PHCollectionList.fetchTopLevelUserCollectionsWithOptions(nil)
    
    self.sectionFetchResults = [allPhotos,smartAlubms,topLevelUserCollections]
    self.sectionLocalizedTitles = ["全部照片","智能相册","个人相册"]
  }
  
  private func customInitUI() {
    
    let titleLabel:UILabel = UILabel(frame: CGRectMake(0, 0, 100, 44))
    titleLabel.text = "相册"
    titleLabel.textColor = UIColor.whiteColor()
    titleLabel.backgroundColor = UIColor.clearColor()
    titleLabel.textAlignment = .Center
    self.navigationItem.titleView = titleLabel
  }
  
  //MARK:observer
  private func addObserver() {
    PHPhotoLibrary.sharedPhotoLibrary().registerChangeObserver(self)
  }
  
  private func removeObserver() {
    PHPhotoLibrary.sharedPhotoLibrary().unregisterChangeObserver(self)
  }
  
  //MARK:*************************** action *************************
  private func handleAddButtonItem() {
    
  }
  
  //MARK:*************************** callback *************************
  //MARK:tableview
  func numberOfSectionsInTableView(tableView: UITableView) -> Int {
    
    let count = self.sectionFetchResults?.count
    return count!;
  }
  
  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    
    if section == 0 {
      return 1
    }
    let count = self.sectionFetchResults?.objectAtIndex(section).count
    return count!
  }
  
  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    
    switch indexPath.section {
    case 0:
      var cell:UITableViewCell? = tableView.dequeueReusableCellWithIdentifier(AllPhotosReuseIdentifier)
      if cell == nil {
        cell = UITableViewCell(style: .Value1, reuseIdentifier: AllPhotosReuseIdentifier)
      }

      cell!.textLabel?.text = "全部"
      
      let fetchResult = self.sectionFetchResults![indexPath.section]
      cell!.detailTextLabel?.text = "\(fetchResult.count)"
      
      return cell!
    case 1,2:
      
      var cell:UITableViewCell? = tableView.dequeueReusableCellWithIdentifier(CollectionCellReuseIdentifier)
      if cell == nil {
        cell = UITableViewCell(style: .Value1, reuseIdentifier: CollectionCellReuseIdentifier)
      }

      let fetchResult:PHFetchResult = self.sectionFetchResults![indexPath.section] as! PHFetchResult
      let assetCollection:PHAssetCollection = fetchResult[indexPath.row] as! PHAssetCollection
      let assetsFetchResult = PHAsset.fetchAssetsInAssetCollection(assetCollection, options: nil)
      cell!.textLabel?.text = assetCollection.localizedTitle
      cell!.detailTextLabel?.text = "\(assetsFetchResult.count)"
      return cell!
    default:
      break
    }

    return UITableViewCell()
  }
  
  func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
    
    return self.sectionLocalizedTitles!.objectAtIndex(section) as? String
  }
  
  func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    
    let vc:DGCPhotoLibraryGridVC = DGCPhotoLibraryGridVC(nibName: "DGCPhotoLibraryGridVC", bundle: nil)
    vc.isTakeHeaderOrBanner = self.isTakeHeaderOrBanner
    
    //数据源
    switch indexPath.section {
    case 0:
      let fetchResult:PHFetchResult = self.sectionFetchResults![indexPath.section] as! PHFetchResult
      vc.assetsFetchResults = fetchResult
    case 1,2:
      let fetchResult:PHFetchResult = self.sectionFetchResults![indexPath.section] as! PHFetchResult
      let collection = fetchResult[indexPath.row]
      if !(collection is PHAssetCollection) {
        return
      }else{
        let assetsFetchResult = PHAsset.fetchAssetsInAssetCollection(collection as! PHAssetCollection, options: nil)
        vc.assetCollection = collection as? PHAssetCollection
        vc.assetsFetchResults = assetsFetchResult
      }
    default:
      break
    }
    
    self.navigationController?.pushViewController(vc, animated: true)
  }
  
  //MARK:PHPhotoLibraryChangeObserver
  func photoLibraryDidChange(changeInstance: PHChange) {
    
    /*
     Change notifications may be made on a background queue. Re-dispatch to the
     main queue before acting on the change as we'll be updating the UI.
     只要另一个应用或者用户在照片库中做的修改影响了你在变化前获取的任何资源或资源集合的话就会触发，更新数据和视图
     */
    dispatch_async(dispatch_get_main_queue()) {
      
      // Loop through the section fetch results, replacing any fetch results that have been updated.
      let updateSectionFetchResults:NSMutableArray = self.sectionFetchResults?.mutableCopy() as! NSMutableArray
      
      //提取每一个原始数据和更新数据做比较 如果有改变则替换
      var reloadRequired:Bool = false
      self.sectionFetchResults!.enumerateObjectsUsingBlock({
        (collectionsFetchResult:AnyObject, index:Int, stop:UnsafeMutablePointer<ObjCBool>) in
        
        if let changeDetails:PHFetchResultChangeDetails = changeInstance.changeDetailsForFetchResult(collectionsFetchResult as! PHFetchResult){
          updateSectionFetchResults.replaceObjectAtIndex(index, withObject: changeDetails.fetchResultAfterChanges)
          reloadRequired = true
        }
      })
      
      if reloadRequired == true{
        self.sectionFetchResults = updateSectionFetchResults
        self.tableView.reloadData()
      }
    }
  }
  
  
  
}
