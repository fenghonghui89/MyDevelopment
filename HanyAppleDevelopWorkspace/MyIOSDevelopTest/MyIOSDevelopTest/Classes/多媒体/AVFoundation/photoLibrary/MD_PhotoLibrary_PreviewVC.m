//
//  MD_PhotoLibrary_PreviewVC.m
//  MyDevelopmentTest
//
//  Created by 冯鸿辉 on 16/2/1.
//  Copyright © 2016年 hanyfeng. All rights reserved.
//

#import "MD_PhotoLibrary_PreviewVC.h"
#import "CIImage+Convenience.h"

static NSString * const AdjustmentFormatIdentifier = @"com.example.apple-samplecode.SamplePhotosApp";

@interface MD_PhotoLibrary_PreviewVC ()
<
PHPhotoLibraryChangeObserver, PHLivePhotoViewDelegate
>
@property (weak, nonatomic) IBOutlet UIView *showBgView;
@property (weak, nonatomic) IBOutlet UIProgressView *progressView;//从icloud下载时显示的进度条
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet PHLivePhotoView *livePhotoView;
@property (nonatomic, strong)  UIBarButtonItem *playButton;
@property (nonatomic, strong)  UIBarButtonItem *space;
@property (nonatomic, strong)  UIBarButtonItem *trashButton;
@property (nonatomic, strong) AVPlayerLayer *playerLayer;
@property (nonatomic, assign) CGSize lastTargetSize;
@property (nonatomic, assign) BOOL playingHint;
@end

@implementation MD_PhotoLibrary_PreviewVC

#pragma mark - < vc lifecycle > -

-(void)dealloc{
  [self removeObserver];
}

- (void)viewDidLoad {
  [super viewDidLoad];
  
  [self addObserver];
  [self customInitBarButtomItem];
  [self customInitUI];
}

-(void)viewWillAppear:(BOOL)animated{
  [super viewWillAppear:animated];
  [self.navigationController setToolbarHidden:NO animated:YES];
}

-(void)viewWillDisappear:(BOOL)animated{
  [self.navigationController setToolbarHidden:YES animated:YES];
  [super viewWillDisappear:animated];
}

#pragma mark - < method > -
#pragma mark noti & observer
-(void)addObserver{
  [[PHPhotoLibrary sharedPhotoLibrary] registerChangeObserver:self];
}

-(void)removeObserver{
  [[PHPhotoLibrary sharedPhotoLibrary] unregisterChangeObserver:self];
}

#pragma mark customInit
-(void)customInitUI{

  //livePhoto
  self.livePhotoView.delegate = self;
  
  //navi edit btn
  BOOL isEditable = ([self.asset canPerformEditOperation:PHAssetEditOperationProperties] || [self.asset canPerformEditOperation:PHAssetEditOperationContent]);
  if (isEditable){
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemEdit target:self action:@selector(handleEditButtonItem:)];
  }
  
  //toolbar
  if (self.asset.mediaType == PHAssetMediaTypeVideo) {
    [self showPlaybackToolbar];
  } else {
    [self showStaticToolbar];
  }
  
  //删除按钮是否开启
  BOOL isTrashable = NO;
  if (self.assetCollection) {//如果图像是来源于某个相册
    isTrashable = [self.assetCollection canPerformEditOperation:PHCollectionEditOperationRemoveContent];
  } else {//如果图像是来源于全部
    isTrashable = [self.asset canPerformEditOperation:PHAssetEditOperationDelete];
  }
  self.trashButton.enabled = isTrashable;
  
  //show img
  [self updateImage];
}



-(void)customInitBarButtomItem{
  UIBarButtonItem *playButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemPlay target:self action:@selector(handlePlayButtonItem:)];
  self.playButton = playButton;
  
  UIBarButtonItem *space = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
  self.space = space;
  
  UIBarButtonItem *trashButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemTrash target:self action:@selector(handleTrashButtonItem:)];
  self.trashButton = trashButton;
}

#pragma mark View & Toolbar setup methods
- (void)showPlaybackToolbar {
  self.toolbarItems = @[self.playButton, self.space, self.trashButton];
}

- (void)showStaticToolbar {
  self.toolbarItems = @[self.space, self.trashButton];
}

-(CGSize)targetSize{
  CGFloat scale = [UIScreen mainScreen].scale;
  CGSize targetSize = CGSizeMake(CGRectGetWidth(self.imageView.bounds) * scale, CGRectGetHeight(self.imageView.bounds) * scale);
  return targetSize;
}

#pragma mark Photo editing methods
//添加滤镜
- (void)applyFilterWithName:(NSString *)filterName {
  // Prepare the options to pass when requesting to edit the image.
  PHContentEditingInputRequestOptions *options = [[PHContentEditingInputRequestOptions alloc] init];
  [options setCanHandleAdjustmentData:^BOOL(PHAdjustmentData *adjustmentData) {
    return [adjustmentData.formatIdentifier isEqualToString:AdjustmentFormatIdentifier] && [adjustmentData.formatVersion isEqualToString:@"1.0"];
  }];
  
  [self.asset requestContentEditingInputWithOptions:options completionHandler:^(PHContentEditingInput *contentEditingInput, NSDictionary *info) {
    // Create a CIImage from the full image representation.
    NSURL *url = [contentEditingInput fullSizeImageURL];
    int orientation = [contentEditingInput fullSizeImageOrientation];
    CIImage *inputImage = [CIImage imageWithContentsOfURL:url options:nil];
    inputImage = [inputImage imageByApplyingOrientation:orientation];
    
    // Create the filter to apply.
    CIFilter *filter = [CIFilter filterWithName:filterName];
    [filter setDefaults];
    [filter setValue:inputImage forKey:kCIInputImageKey];
    
    // Apply the filter.
    CIImage *outputImage = [filter outputImage];
    
    // Create a PHAdjustmentData object that describes the filter that was applied.
    PHAdjustmentData *adjustmentData = [[PHAdjustmentData alloc] initWithFormatIdentifier:AdjustmentFormatIdentifier formatVersion:@"1.0" data:[filterName dataUsingEncoding:NSUTF8StringEncoding]];
    
    /*
     Create a PHContentEditingOutput object and write a JPEG representation
     of the filtered object to the renderedContentURL.
     */
    PHContentEditingOutput *contentEditingOutput = [[PHContentEditingOutput alloc] initWithContentEditingInput:contentEditingInput];
    NSData *jpegData = [outputImage aapl_jpegRepresentationWithCompressionQuality:0.9f];
    [jpegData writeToURL:[contentEditingOutput renderedContentURL] atomically:YES];
    [contentEditingOutput setAdjustmentData:adjustmentData];
    
    // Ask the shared PHPhotoLinrary to perform the changes.
    [[PHPhotoLibrary sharedPhotoLibrary] performChanges:^{
      PHAssetChangeRequest *request = [PHAssetChangeRequest changeRequestForAsset:self.asset];
      request.contentEditingOutput = contentEditingOutput;
    } completionHandler:^(BOOL success, NSError *error) {
      if (!success) {
        NSLog(@"Error: %@", error);
      }
    }];
  }];
}

//放入个人收藏
- (void)toggleFavoriteState {
  [[PHPhotoLibrary sharedPhotoLibrary] performChanges:^{
    PHAssetChangeRequest *request = [PHAssetChangeRequest changeRequestForAsset:self.asset];
    [request setFavorite:![self.asset isFavorite]];
  } completionHandler:^(BOOL success, NSError *error) {
    if (!success) {
      NSLog(@"Error: %@", error);
    }
  }];
}

//复原图片
- (void)revertToOriginal {
  [[PHPhotoLibrary sharedPhotoLibrary] performChanges:^{
    PHAssetChangeRequest *request = [PHAssetChangeRequest changeRequestForAsset:self.asset];
    [request revertAssetContentToOriginal];
  } completionHandler:^(BOOL success, NSError *error) {
    if (!success) {
      NSLog(@"Error: %@", error);
    }
  }];
}


#pragma mark ImageView/LivePhotoView Image Setting methods.

- (void)updateImage {
  self.lastTargetSize = [self targetSize];
  
  //判断图像是视频还是图片
  BOOL assetHasLivePhotoSubType = (self.asset.mediaSubtypes & PHAssetMediaSubtypePhotoLive);//按位与
  if (assetHasLivePhotoSubType) {
    [self updateLiveImage];
  }
  else {
    [self updateStaticImage];
  }
}

- (void)updateLiveImage {
  // Prepare the options to pass when fetching the live photo.
  PHLivePhotoRequestOptions *livePhotoOptions = [[PHLivePhotoRequestOptions alloc] init];
  livePhotoOptions.deliveryMode = PHImageRequestOptionsDeliveryModeHighQualityFormat;
  livePhotoOptions.networkAccessAllowed = YES;
  livePhotoOptions.progressHandler = ^(double progress, NSError *error, BOOL *stop, NSDictionary *info) {
    /*
     Progress callbacks may not be on the main thread. Since we're updating
     the UI, dispatch to the main queue.
     */
    dispatch_async(dispatch_get_main_queue(), ^{
      self.progressView.progress = progress;
    });
  };
  
  // Request the live photo for the asset from the default PHImageManager.
  [[PHImageManager defaultManager] requestLivePhotoForAsset:self.asset targetSize:[self targetSize] contentMode:PHImageContentModeAspectFit options:livePhotoOptions resultHandler:^(PHLivePhoto * _Nullable livePhoto, NSDictionary * _Nullable info) {
    
    // Check if the request was successful.
    if (!livePhoto) {
      return;
    }
    
    NSLog (@"Got a live photo");
    
    // Show the PHLivePhotoView and use it to display the requested image.
    self.livePhotoView.hidden = NO;
    self.imageView.hidden = YES;
    self.livePhotoView.livePhoto = livePhoto;
    
    //如果是低质量格式，则播放低质量格式
    if (![info[PHImageResultIsDegradedKey] boolValue] && !self.playingHint) {
      // Playback a short section of the live photo; similar to the Photos share sheet.
      NSLog (@"playing hint...");
      self.playingHint = YES;
      [self.livePhotoView startPlaybackWithStyle:PHLivePhotoViewPlaybackStyleHint];
    }
    
  }];
}

- (void)updateStaticImage {
  // Prepare the options to pass when fetching the live photo.
  PHImageRequestOptions *options = [[PHImageRequestOptions alloc] init];
  options.deliveryMode = PHImageRequestOptionsDeliveryModeHighQualityFormat;
  options.networkAccessAllowed = YES;
  options.progressHandler = ^(double progress, NSError *error, BOOL *stop, NSDictionary *info) {
    /*
     Progress callbacks may not be on the main thread. Since we're updating
     the UI, dispatch to the main queue.
     */
    dispatch_async(dispatch_get_main_queue(), ^{
      self.progressView.progress = progress;
    });
  };
  
  [[PHImageManager defaultManager] requestImageForAsset:self.asset targetSize:[self targetSize] contentMode:PHImageContentModeAspectFit options:options resultHandler:^(UIImage *result, NSDictionary *info) {

    // Check if the request was successful.
    if (!result) {
      return;
    }
    
    // Show the UIImageView and use it to display the requested image.
    self.livePhotoView.hidden = YES;
    self.imageView.hidden = NO;
    self.imageView.image = result;
  }];
}

#pragma mark - < action > -
- (void)handleEditButtonItem:(id)sender {
  // Use a UIAlertController to display the editing options to the user.
  UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
  alertController.modalPresentationStyle = UIModalPresentationPopover;
  alertController.popoverPresentationController.barButtonItem = sender;
  alertController.popoverPresentationController.permittedArrowDirections = UIPopoverArrowDirectionUp;
  
  // Add an action to dismiss the UIAlertController.
  [alertController addAction:[UIAlertAction actionWithTitle:NSLocalizedString(@"Cancel", @"") style:UIAlertActionStyleCancel handler:NULL]];
  
  // If PHAsset supports edit operations, allow the user to toggle its favorite status.放入到个人收藏
  if ([self.asset canPerformEditOperation:PHAssetEditOperationProperties]) {
    NSString *favoriteActionTitle = !self.asset.favorite ? NSLocalizedString(@"Favorite", @"") : NSLocalizedString(@"Unfavorite", @"");
    
    [alertController addAction:[UIAlertAction actionWithTitle:favoriteActionTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
      [self toggleFavoriteState];
    }]];
  }
  
  // Only allow editing if the PHAsset supports edit operations and it is not a Live Photo.给照片添加特效
  if ([self.asset canPerformEditOperation:PHAssetEditOperationContent] && !(self.asset.mediaSubtypes & PHAssetMediaSubtypePhotoLive)) {
    // Allow filters to be applied if the PHAsset is an image.
    if (self.asset.mediaType == PHAssetMediaTypeImage) {
      [alertController addAction:[UIAlertAction actionWithTitle:NSLocalizedString(@"Sepia", @"") style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        [self applyFilterWithName:@"CISepiaTone"];
      }]];
      [alertController addAction:[UIAlertAction actionWithTitle:NSLocalizedString(@"Chrome", @"") style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        [self applyFilterWithName:@"CIPhotoEffectChrome"];
      }]];
    }
    
    // Add actions to revert any edits that have been made to the PHAsset.复原照片
    [alertController addAction:[UIAlertAction actionWithTitle:NSLocalizedString(@"Revert", @"") style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
      [self revertToOriginal];
    }]];
  }
  
  // Present the UIAlertController.
  [self presentViewController:alertController animated:YES completion:NULL];
}

- (void)handlePlayButtonItem:(id)sender {
  if (self.livePhotoView.livePhoto != nil) {
    // We're displaying a live photo, begin playing it.
    [self.livePhotoView startPlaybackWithStyle:PHLivePhotoViewPlaybackStyleFull];
  } else if (self.playerLayer != nil) {
    // An AVPlayerLayer has already been created for this asset.
    [self.playerLayer.player play];
  }
  else {
    // Request an AVAsset for the PHAsset we're displaying.
    [[PHImageManager defaultManager] requestAVAssetForVideo:self.asset options:nil resultHandler:^(AVAsset *avAsset, AVAudioMix *audioMix, NSDictionary *info) {
      dispatch_async(dispatch_get_main_queue(), ^{
        if (!self.playerLayer) {
          CALayer *viewLayer = self.showBgView.layer;
          
          // Create an AVPlayerItem for the AVAsset.
          AVPlayerItem *playerItem = [AVPlayerItem playerItemWithAsset:avAsset];
          playerItem.audioMix = audioMix;
          
          // Create an AVPlayer with the AVPlayerItem.
          AVPlayer *player = [AVPlayer playerWithPlayerItem:playerItem];
          
          // Create an AVPlayerLayer with the AVPlayer.
          AVPlayerLayer *playerLayer = [AVPlayerLayer playerLayerWithPlayer:player];
          
          // Configure the AVPlayerLayer and add it to the view.
          playerLayer.videoGravity = AVLayerVideoGravityResizeAspect;
          playerLayer.frame = CGRectMake(0, 0, viewLayer.bounds.size.width, viewLayer.bounds.size.height);
          
          [viewLayer addSublayer:playerLayer];
          [player play];
          
          // Store a reference to the player layer we added to the view.
          self.playerLayer = playerLayer;
        }
      });
    }];
  }
}


- (void)handleTrashButtonItem:(id)sender {
  void (^completionHandler)(BOOL, NSError *) = ^(BOOL success, NSError *error) {
    if (success) {
      dispatch_async(dispatch_get_main_queue(), ^{
        [[self navigationController] popViewControllerAnimated:YES];
      });
    } else {
      NSLog(@"Error: %@", error);
    }
  };
  
  if (self.assetCollection) {
    // Remove asset from album
    [[PHPhotoLibrary sharedPhotoLibrary] performChanges:^{
      PHAssetCollectionChangeRequest *changeRequest = [PHAssetCollectionChangeRequest changeRequestForAssetCollection:self.assetCollection];
      [changeRequest removeAssets:@[self.asset]];
    } completionHandler:completionHandler];
    
  } else {
    // Delete asset from library
    [[PHPhotoLibrary sharedPhotoLibrary] performChanges:^{
      [PHAssetChangeRequest deleteAssets:@[self.asset]];
    } completionHandler:completionHandler];
    
  }
}
#pragma mark - < callback > -
#pragma mark PHPhotoLibraryChangeObserver

- (void)photoLibraryDidChange:(PHChange *)changeInstance {
  // Call might come on any background queue. Re-dispatch to the main queue to handle it.
  dispatch_async(dispatch_get_main_queue(), ^{
    // Check if there are changes to the asset we're displaying.
    PHObjectChangeDetails *changeDetails = [changeInstance changeDetailsForObject:self.asset];
    if (changeDetails == nil) {
      return;
    }
    
    // Get the updated asset.
    self.asset = [changeDetails objectAfterChanges];
    
    // If the asset's content changed, update the image and stop any video playback.
    if ([changeDetails assetContentChanged]) {
      [self updateImage];
      
      [self.playerLayer removeFromSuperlayer];
      self.playerLayer = nil;
    }
  });
}

#pragma mark PHLivePhotoViewDelegate Protocol Methods.

- (void)livePhotoView:(PHLivePhotoView *)livePhotoView willBeginPlaybackWithStyle:(PHLivePhotoViewPlaybackStyle)playbackStyle {
  NSLog(@"Will Beginning Playback of Live Photo...");
}

- (void)livePhotoView:(PHLivePhotoView *)livePhotoView didEndPlaybackWithStyle:(PHLivePhotoViewPlaybackStyle)playbackStyle {
  NSLog(@"Did End Playback of Live Photo...");
  self.playingHint = NO;
}
@end
