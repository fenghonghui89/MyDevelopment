//
//  DGCPhotoLibraryVC.swift
//  Tpages
//
//  Created by 冯鸿辉 on 16/7/20.
//  Copyright © 2016年 DGC. All rights reserved.
//

import UIKit
import Photos

class DGCPhotoLibraryVC: UIViewController,UITableViewDataSource,UITableViewDelegate,PHPhotoLibraryChangeObserver {
  
  var isTakeHeaderOrBanner:Bool? = false//yes - 头像 no - 背景
  var sectionFetchResults:NSArray?
  var sectionLocalizedTitles:NSArray?
  @IBOutlet weak var tableView: UITableView!
  
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
  func customInitData() {
    
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
  
  func customInitUI() {
    
    let titleLabel:UILabel = UILabel(frame: CGRectMake(0, 0, 100, 44))
    titleLabel.text = "相册"
    titleLabel.textColor = UIColor.whiteColor()
    titleLabel.backgroundColor = UIColor.clearColor()
    titleLabel.textAlignment = .Center
    self.navigationItem.titleView = titleLabel
  }
  //MARK:observer
  func addObserver() {
    PHPhotoLibrary.sharedPhotoLibrary().registerChangeObserver(self)
  }
  
  func removeObserver() {
    PHPhotoLibrary.sharedPhotoLibrary().unregisterChangeObserver(self)
  }
  //MARK:*************************** action *************************
  func handleAddButtonItem() {
    
  }
  //MARK:*************************** callback *************************
  //MARK:tableview
  func numberOfSectionsInTableView(tableView: UITableView) -> Int {
    return 0
  }
  
  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 0
  }
  
  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    return UITableViewCell();
  }
  
  func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
    return nil
  }
  
  func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    
  }
  
  //MARK:PHPhotoLibraryChangeObserver
  func photoLibraryDidChange(changeInstance: PHChange) {
    
  }
}
