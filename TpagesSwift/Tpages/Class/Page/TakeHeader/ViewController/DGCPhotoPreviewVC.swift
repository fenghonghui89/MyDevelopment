//
//  DGCPhotoPreviewVC.swift
//  Tpages
//
//  Created by 冯鸿辉 on 16/7/20.
//  Copyright © 2016年 DGC. All rights reserved.
//

import UIKit

class DGCPhotoPreviewVC: UIViewController {
  
  @IBOutlet weak var imageView: UIImageView!
  var photo:UIImage?
  var isTakeHeaderOrBanner:Bool? = false//yes - 头像 no - 背景
  
  //MARK:**************** vc lifecycle *****************
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // Do any additional setup after loading the view.
  }
  
  //MARK:**************** method *****************
  func customInitUI() {
    
    let titleLabel:UILabel = UILabel(frame: CGRectMake(0,0,100,44))
    if self.isTakeHeaderOrBanner == true {
      titleLabel.text = "头像预览"
    }else{
      titleLabel.text = "背景预览"
    }
    
    titleLabel.textColor = UIColor.whiteColor()
    titleLabel.backgroundColor = UIColor.clearColor()
    titleLabel.textAlignment = .Center
    self.navigationItem.titleView = titleLabel
    
    let nextBtn:UIButton = UIButton(frame: CGRectMake(0,0,50,44))
    nextBtn.setTitle("下一步", forState: UIControlState.Normal)
    nextBtn.setTitleColor(UIColor.whiteColor(), forState: .Normal)
    nextBtn.backgroundColor = UIColor.clearColor()
    nextBtn.addTarget(self, action: #selector(nextBtnTap(_:)), forControlEvents: .TouchUpInside)
    let nextItem:UIBarButtonItem = UIBarButtonItem(customView: nextBtn)
    nextItem.enabled = true
    
    self.navigationItem.rightBarButtonItem = nextItem
    self.imageView.image = self.photo!
  }
  
  //MARK:**************** action *****************
  func nextBtnTap(sender:UIButton) {
    
    DGCMBProgressHUD.showHUDAddedTo(UIApplication.sharedApplication().keyWindow, animated: true, type: 0, block: nil)
    
    var urlStr:String = ""
    if self.isTakeHeaderOrBanner == true {
      urlStr = URL_TPAGES.stringByAppendingString("/service.php?mod=avatar&type=big")
    }else{
      urlStr = URL_TPAGES.stringByAppendingString("/service.php?mod=avatar&type=header")
    }
    
    let url:NSURL = NSURL(string: urlStr)!
    let request:NSMutableURLRequest = NSMutableURLRequest(URL: url)
    request.setValue("application/octet-stream", forHTTPHeaderField: "Content-Type")
    request.HTTPMethod = "POST"
    request.setValue("application/json", forHTTPHeaderField: "Accept")
    let imageData:NSData = UIImageJPEGRepresentation(self.imageView.image!, 0.3)!
    request.HTTPBody = imageData
    dlog("上传图片 image data:\(imageData.length)")
    
    

    
    let conf:NSURLSessionConfiguration = NSURLSessionConfiguration.defaultSessionConfiguration()
    let manager:AFURLSessionManager = AFURLSessionManager(sessionConfiguration: conf)
    let responseSerializer:AFHTTPResponseSerializer = AFHTTPResponseSerializer()
    manager.responseSerializer = responseSerializer
    
    let dataTask:NSURLSessionDataTask = manager.dataTaskWithRequest(request, uploadProgress: nil, downloadProgress: nil) {
      (response:NSURLResponse, responseObject:AnyObject?, error:NSError?)->Void in
      
      if error != nil{
        dlog("修改头像或背景失败 :\(error?.localizedDescription)")
        DGCMBProgressHUD.hideHUDForView(UIApplication.sharedApplication().keyWindow, animated: true)
        let ac:UIAlertController = DGCAlertController.alertControlller("修改头像或背景失败", message: error?.localizedDescription, type: DGCAlertType.DGCAlertTypeJustConfirm, block: nil)
        self.presentViewController(ac, animated: true, completion: nil)
      }else{
        
        do{
          let dic:NSDictionary = try  NSJSONSerialization.JSONObjectWithData(responseObject as! NSData, options: NSJSONReadingOptions.AllowFragments) as! NSDictionary
          dlog("修改头像或背景成功 \(dic)")
          DGCMBProgressHUD.hideHUDForView(UIApplication.sharedApplication().keyWindow, animated: true)
          if let errorValue = dic.objectForKey("error"){
            let ac:UIAlertController = DGCAlertController.alertControlller("修改头像或背景失败", message: errorValue as? String, type: DGCAlertType.DGCAlertTypeJustConfirm, block: nil)
            self.presentViewController(ac, animated: true, completion: nil)
          }else{
            NSNotificationCenter.defaultCenter().postNotificationName(NOTI_TakeHeaderPhotoSuccess, object: nil)
            self.navigationController?.popToRootViewControllerAnimated(true)
          }
        }catch let err as NSError{
          dlog("修改头像或背景成功 数据解析错误:\(err.localizedDescription)")
        }
      }
    }
    dataTask.resume()
    
    
  }
  
  
  
  
  
  
  
  
  
  
}
