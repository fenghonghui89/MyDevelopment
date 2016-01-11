//
//  MD_PhotosLibrary_VC.m
//  MyDevelopmentTest
//
//  Created by 冯鸿辉 on 16/1/11.
//  Copyright © 2016年 hanyfeng. All rights reserved.
//

#import "MD_PhotosLibrary_VC.h"
#import "MD_PhotosLibrary_Cell.h"
#import "MDDefine.h"
#import "MDTool.h"
@import Photos;
@interface MD_PhotosLibrary_VC ()
<
UICollectionViewDataSource,UICollectionViewDelegate
>
//ui
@property (weak, nonatomic) IBOutlet UICollectionView *photoCollectionView;

//flag / datasource
@property(nonatomic,strong)NSMutableArray *imgs;
@end

@implementation MD_PhotosLibrary_VC

#pragma mark - < vc lifecycle > -
- (void)viewDidLoad
{
  [super viewDidLoad];
  
  [self customInitData];
  [self customInitUI];
}

#pragma mark - < action > -

#pragma mark - < method > -
#pragma mark customInit
-(void)customInitData
{
  
}

-(void)customInitUI
{
  self.photoCollectionView.delegate = self;
  self.photoCollectionView.dataSource = self;
  [self.photoCollectionView registerNib:[UINib nibWithNibName:@"MD_PhotosLibrary_Cell" bundle:nil] forCellWithReuseIdentifier:@"cell"];
}

#pragma mark - < callback > -
#pragma mark UICollectionView
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
  return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
  return 0;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
  MD_PhotosLibrary_Cell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
  return cell;
}



-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{

}
@end
