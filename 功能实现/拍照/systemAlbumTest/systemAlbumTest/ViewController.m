//
//  ViewController.m
//  systemAlbumTest
//
//  Created by 冯鸿辉 on 15/10/30.
//  Copyright © 2015年 DGC. All rights reserved.
//

#import "ViewController.h"
#import <AssetsLibrary/ALAsset.h>
#import <AssetsLibrary/ALAssetsLibrary.h>
#import <AssetsLibrary/ALAssetsGroup.h>
#import <AssetsLibrary/ALAssetRepresentation.h>
#import "CollectionViewCell.h"
#import "ImageViewController.h"

@interface ViewController ()<UICollectionViewDataSource,UICollectionViewDelegate>

@property (strong, nonatomic) IBOutlet UICollectionView *cv;
@property(nonatomic,strong)NSMutableArray *imageArray;
@property(nonatomic,strong)NSMutableArray *sourceArr;



@end

@implementation ViewController

- (void)viewDidLoad
{
  [super viewDidLoad];
  
  [self.cv registerNib:[UINib nibWithNibName:@"CollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"CollectionViewCell"];
  self.cv.delegate = self;
  self.cv.dataSource = self;
  
  [self getAlbum0];
}

#pragma mark - < method > -
-(void)getAlbum0
{
  _imageArray = [NSMutableArray array];
  _sourceArr = [NSMutableArray array];
  
  dispatch_queue_t queue = dispatch_queue_create("myqueue", DISPATCH_QUEUE_SERIAL);
  dispatch_async(queue, ^{
    ALAssetsLibrary *library = [[ALAssetsLibrary alloc] init];
    [library enumerateGroupsWithTypes:ALAssetsGroupAll usingBlock:^(ALAssetsGroup *group, BOOL *stop) {
      
      if(group == nil){
        NSLog(@"全部相册加载完成 %d",_imageArray.count);
        
        dispatch_async(dispatch_get_main_queue(), ^{
          [self.cv reloadData];
        });
        
        
        return ;
      }else{
        NSLog(@"一个相册开始加载");
      }
      

      [group enumerateAssetsUsingBlock:^(ALAsset *result, NSUInteger index, BOOL *stop) {
        if (result) {
//          //fullScreenImage可以直接初始化为UIImage
//          UIImage *tempImg = [UIImage imageWithCGImage:result.defaultRepresentation.fullScreenImage];
//          
//          //需传入方向和缩放比例，否则方向和尺寸都不对
//          UIImage *tempImg1 = [UIImage imageWithCGImage:result.defaultRepresentation.fullResolutionImage
//                                                 scale:result.defaultRepresentation.scale
//                                           orientation:(UIImageOrientation)result.defaultRepresentation.orientation];

          //缩略图
          UIImage *tempImg2 = [UIImage imageWithCGImage:result.thumbnail];
          [_imageArray addObject:tempImg2];
          NSURL *url = result.defaultRepresentation.url;
          [_sourceArr addObject:url];
          NSLog(@"1张图片加载完成");
        }
      }];
      
      NSLog(@"一个相册加载完成");
      
    } failureBlock:^(NSError *error) {
      NSLog(@"group not fround!");
    }];
    
  });
}

#pragma mark - < action > -
- (IBAction)btn1:(id)sender
{
  [self getAlbum0];
}

- (IBAction)btn2:(id)sender
{

}

#pragma mark - < callback > -
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
  return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
  return self.imageArray.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
  CollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CollectionViewCell" forIndexPath:indexPath];
  UIImage *img = self.imageArray[indexPath.row];
  cell.iv.image = img;
  return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
  CGFloat screenW = [[UIScreen mainScreen] bounds].size.width;
  CGSize size = CGSizeMake((screenW-3)/4, (screenW-3)/4);
  return size;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
  return 1;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
  return 1;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{

  

  
  ALAssetsLibrary *library = [[ALAssetsLibrary alloc] init];
  NSURL *url = [_sourceArr objectAtIndex:indexPath.row];
  [library assetForURL:url resultBlock:^(ALAsset *asset) {
    UIImage *fullImg = [UIImage imageWithCGImage:asset.defaultRepresentation.fullScreenImage];
    ImageViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"ImageViewController"];
    vc.img = fullImg;
    [self.navigationController pushViewController:vc animated:YES];
  } failureBlock:^(NSError *error) {
    NSLog(@"获取相册指定照片错误");
  }];
//  ALAsset *set = [_sourceArr objectAtIndex:indexPath.row];
//  UIImage *fimg = [UIImage imageWithCGImage:set.defaultRepresentation.fullScreenImage];
//  UIImage *img = [_imageArray objectAtIndex:indexPath.row];
  
}

@end
