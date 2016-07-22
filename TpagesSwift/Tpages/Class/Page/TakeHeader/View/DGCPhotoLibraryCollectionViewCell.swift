//
//  DGCPhotoLibraryCollectionViewCell.swift
//  Tpages
//
//  Created by 冯鸿辉 on 16/7/22.
//  Copyright © 2016年 DGC. All rights reserved.
//

import UIKit

class DGCPhotoLibraryCollectionViewCell: UICollectionViewCell {
  
  
  var thumbnaiImage:UIImage?{
    didSet{
      self.imageView.image = thumbnaiImage
    }
  }
  
  var livePhotoBadgeImage:UIImage?{
  
    didSet{
      self.livePhotoBadgeImageView.image = livePhotoBadgeImage
    }
  }
  
  var representedAssetIdentifier:String?
  
  @IBOutlet private weak var livePhotoBadgeImageView: UIImageView!
  @IBOutlet private weak var imageView: UIImageView!
  
  
  //重用的时候触发 清除原来的数据
  override func prepareForReuse() {
    super.prepareForReuse()
    self.imageView.image = nil
    self.livePhotoBadgeImageView.image = nil
  }


  
  override func awakeFromNib() {
    super.awakeFromNib()
    // Initialization code
  }
  
}
