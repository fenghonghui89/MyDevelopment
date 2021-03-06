//
//  MD_FreeTest_VC.m
//  MyDevelopmentTest
//
//  Created by 冯鸿辉 on 16/2/26.
//  Copyright © 2016年 hanyfeng. All rights reserved.
//

#import "MD_CollectionView_VC.h"
#import "MD_PhotoLibrary_CollectionViewCell.h"
#import "MD_CollectionView_ReuseView.h"

static NSString * const cellId = @"cellId";
static NSString * const headerId = @"headerId";
static NSString * const footerId = @"footerId";
@interface MD_CollectionView_VC ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>

@end

@implementation MD_CollectionView_VC
#pragma mark - < vc lifecycle > -
- (void)viewDidLoad {
  [super viewDidLoad];
}

-(void)viewDidAppear:(BOOL)animated{
  [super viewDidAppear:animated];
  [self customInitUI];
}

#pragma mark - < method > -
-(void)customInitUI{
  
  UICollectionViewFlowLayout *cvl = [[UICollectionViewFlowLayout alloc] init];
  cvl.minimumInteritemSpacing = 1;
  cvl.minimumLineSpacing = 1;
  cvl.headerReferenceSize = CGSizeMake(screenW, 50);//必须设置分区头尺寸 否则不会触发回调
  cvl.footerReferenceSize = CGSizeMake(screenW, 50);//必须设置分区尾尺寸 否则不会触发回调
//  cvl.sectionFootersPinToVisibleBounds = YES;
//  cvl.sectionHeadersPinToVisibleBounds = YES;
//  cvl.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
//  cvl.scrollDirection = UICollectionViewScrollDirectionVertical;
  
  UICollectionView *cv = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:cvl];
  [cv setBackgroundColor:[UIColor whiteColor]];
  [cv registerNib:[UINib nibWithNibName:@"MD_PhotoLibrary_CollectionViewCell" bundle:nil] forCellWithReuseIdentifier:cellId];
  [cv registerNib:[UINib nibWithNibName:@"MD_CollectionView_ReuseView" bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:headerId];
  [cv registerNib:[UINib nibWithNibName:@"MD_CollectionView_ReuseView" bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:footerId];
  cv.delegate = self;
  cv.dataSource = self;
  [self.view addSubview:cv];
}

#pragma mark - < callback > -
#pragma mark UICollectionViewDataSource UICollectionViewDelegate
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
  return 2;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
  return 31;
}



-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
  
  UICollectionReusableView *supplementaryView;
  if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
    supplementaryView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:headerId forIndexPath:indexPath];
  }
  if ([kind isEqualToString:UICollectionElementKindSectionFooter]) {
    supplementaryView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:footerId forIndexPath:indexPath];
  }
  
  return supplementaryView;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
  
  MD_PhotoLibrary_CollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellId forIndexPath:indexPath];
  cell.backgroundColor = [UIColor colorWithRed:arc4random()%10*0.1 green:arc4random()%10*0.1 blue:arc4random()%10*0.1 alpha:1];
  return cell;
}

#pragma mark UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
  CGSize size = CGSizeMake((screenW-3)/4, (screenW-3)/4);
  return size;
}

//- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
//  return 1;
//}
//
//- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
//  return 1;
//}
//
//-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
//  return UIEdgeInsetsMake(10, 10, 10, 10);
//}
//
//-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
//  return CGSizeMake(screenW, 50);
//}
//
//-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section{
//  return CGSizeMake(screenW, 50);
//}


@end
