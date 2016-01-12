//
//  ViewController.m
//  MasonryTest
//
//  Created by 冯鸿辉 on 16/1/12.
//  Copyright © 2016年 DGC. All rights reserved.
//




#import "ViewController.h"
#import "Masonry.h"
#import "UIView+Masonry_Hany.h"

typedef NS_ENUM(NSInteger,PlantReferenceIndex) {
  PlantReferenceWaterIndex = 0,
  PlantReferenceSumIndex = 1,
  PlantReferenceTemperatureIndex = 2,
  PlantReferenceElectrolyteIndex = 3
};

@interface ViewController ()
@property(nonatomic,strong)UIView *bgview;
@end

@implementation ViewController

- (void)viewDidLoad
{
  [super viewDidLoad];
 
  [self createUI];
}

#pragma mark - < test > -
#pragma mark 初级
//中心点与self.view相同，宽度为400*400
-(void)test
{
  self.bgview = [[UIView alloc] init];
  [self.bgview setBackgroundColor:[UIColor yellowColor]];
  [self.view addSubview:self.bgview];
  
  [self.bgview mas_makeConstraints:^(MASConstraintMaker *make) {
    make.center.equalTo(self.view);
    make.size.mas_equalTo(CGSizeMake(400, 400));
  }];
}
//上下左右边距都为10
-(void)test1
{
  [self test];
  
  UIView *subview1 = [UIView new];
  subview1.backgroundColor = [UIColor redColor];
  [self.bgview addSubview:subview1];
  [subview1 mas_makeConstraints:^(MASConstraintMaker *make) {
//    make.edges.equalTo(self.bgview).with.insets(UIEdgeInsetsMake(0, 0, 0, 0));
    make.edges.equalTo(self.bgview);
  }];
}

//让两个高度为150的view垂直居中且等宽且等间隔排列 间隔为10
-(void)test2
{
  [self test];
  
  int padding1 = 10;
  
  UIView *subview1 = [UIView new];
  subview1.backgroundColor = [UIColor redColor];
  [self.bgview addSubview:subview1];
  
  UIView *subview2 = [UIView new];
  subview2.backgroundColor = [UIColor redColor];
  [self.bgview addSubview:subview2];
  
  [subview1 mas_makeConstraints:^(MASConstraintMaker *make) {
    make.centerY.mas_equalTo(self.bgview.mas_centerY);
    make.left.equalTo(self.bgview.mas_left).with.offset(padding1);
    make.right.equalTo(subview2.mas_left).with.offset(-padding1);
    make.height.mas_equalTo(@150);
    make.width.equalTo(subview2);
  }];
  
  [subview2 mas_makeConstraints:^(MASConstraintMaker *make) {
    make.centerY.mas_equalTo(self.bgview.mas_centerY);
    make.left.equalTo(subview1.mas_right).with.offset(padding1);
    make.right.equalTo(self.bgview.mas_right).with.offset(-padding1);
    make.height.mas_equalTo(@150);
    make.width.equalTo(subview1);
  }];
}

#pragma mark 中级
//在UIScrollView顺序排列一些view并自动计算contentSize
-(void)test3
{
  [self test];
  
  UIScrollView *scrollView = [UIScrollView new];
  scrollView.backgroundColor = [UIColor whiteColor];
  [self.bgview addSubview:scrollView];
  [scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
    make.edges.equalTo(self.bgview).with.insets(UIEdgeInsetsMake(5,5,5,5));
  }];
  
  UIView *container = [UIView new];
  [scrollView addSubview:container];
  [container mas_makeConstraints:^(MASConstraintMaker *make) {
    make.edges.equalTo(scrollView);
    make.width.equalTo(scrollView);
  }];
  
  int count = 10;
  UIView *lastView = nil;
  for ( int i = 1 ; i <= count ; ++i )
  {
    UIView *subv = [UIView new];
    [container addSubview:subv];
    subv.backgroundColor = [UIColor colorWithHue:( arc4random() % 256 / 256.0 )
                                      saturation:( arc4random() % 128 / 256.0 ) + 0.5
                                      brightness:( arc4random() % 128 / 256.0 ) + 0.5
                                           alpha:1];
    
    [subv mas_makeConstraints:^(MASConstraintMaker *make) {
      make.left.and.right.equalTo(container);
      make.height.mas_equalTo(@(20*i));
      
      if ( lastView )
      {
        make.top.mas_equalTo(lastView.mas_bottom);
      }
      else
      {
        make.top.mas_equalTo(container.mas_top);
      }
    }];
    
    lastView = subv;
  }
  
  [container mas_makeConstraints:^(MASConstraintMaker *make) {
    make.bottom.equalTo(lastView.mas_bottom);
  }];
}

#pragma mark 高级
//横向或者纵向等间隙的排列一组view
-(void)test4
{
  [self test];
  
  UIView *sv11 = [UIView new];
  UIView *sv12 = [UIView new];
  UIView *sv13 = [UIView new];
  UIView *sv21 = [UIView new];
  UIView *sv31 = [UIView new];
  sv11.backgroundColor = [UIColor redColor];
  sv12.backgroundColor = [UIColor redColor];
  sv13.backgroundColor = [UIColor redColor];
  sv21.backgroundColor = [UIColor redColor];
  sv31.backgroundColor = [UIColor redColor];
  [self.bgview addSubview:sv11];
  [self.bgview addSubview:sv12];
  [self.bgview addSubview:sv13];
  [self.bgview addSubview:sv21];
  [self.bgview addSubview:sv31];
  
  //给予不同的大小 测试效果
  [sv11 mas_makeConstraints:^(MASConstraintMaker *make) {
    make.centerY.equalTo(@[sv12,sv13]);
    make.centerX.equalTo(@[sv21,sv31]);
    make.size.mas_equalTo(CGSizeMake(40, 40));
  }];
  [sv12 mas_makeConstraints:^(MASConstraintMaker *make) {
    make.size.mas_equalTo(CGSizeMake(70, 20));
  }];
  [sv13 mas_makeConstraints:^(MASConstraintMaker *make) {
    make.size.mas_equalTo(CGSizeMake(50, 50));
  }];
  [sv21 mas_makeConstraints:^(MASConstraintMaker *make) {
    make.size.mas_equalTo(CGSizeMake(50, 20));
  }];
  [sv31 mas_makeConstraints:^(MASConstraintMaker *make) {
    make.size.mas_equalTo(CGSizeMake(40, 60));
  }];
  [self.bgview distributeSpacingHorizontallyWith:@[sv11,sv12,sv13]];
  [self.bgview distributeSpacingVerticallyWith:@[sv11,sv21,sv31]];
//  [self.bgview showPlaceHolderWithAllSubviews];
//  [self.bgview hidePlaceHolder];
}

//高级布局练习 ios自带计算器布局
/*
 本例子使用的baseline去控制高度位置，这似乎不是太准，如果想要精准控制高度位置，可以使用一行一行添加的方法，每次当前行的top去equelTo上一行的bottom
 */
-(void)test5
{
  //申明区域，displayView是显示区域，keyboardView是键盘区域
  UIView *displayView = [UIView new];
  [displayView setBackgroundColor:[UIColor blackColor]];
  [self.view addSubview:displayView];
  UIView *keyboardView = [UIView new];
  [self.view addSubview:keyboardView];
  //先按1：3分割 displView（显示结果区域）和 keyboardView（键盘区域）
  [displayView mas_makeConstraints:^(MASConstraintMaker *make) {
    make.top.equalTo(self.view.mas_top);
    make.left.and.right.equalTo(self.view);
    make.height.equalTo(keyboardView).multipliedBy(0.3f);
  }];
  [keyboardView mas_makeConstraints:^(MASConstraintMaker *make) {
    make.top.equalTo(displayView.mas_bottom);
    make.bottom.equalTo(self.view.mas_bottom);
    make.left.and.right.equalTo(self.view);
  }];
  //设置显示位置的数字为0
  UILabel *displayNum = [[UILabel alloc]init];
  [displayView addSubview:displayNum];
  displayNum.text = @"0";
  displayNum.font = [UIFont fontWithName:@"HeiTi SC" size:70];
  displayNum.textColor = [UIColor whiteColor];
  displayNum.textAlignment = NSTextAlignmentRight;
  [displayNum mas_makeConstraints:^(MASConstraintMaker *make) {
    make.left.and.right.equalTo(displayView).with.offset(-10);
    make.bottom.equalTo(displayView).with.offset(-10);
  }];
  //定义键盘键名称，？号代表合并的单元格
  NSArray *keys = @[@"AC",@"+/-",@"%",@"÷"
                    ,@"7",@"8",@"9",@"x"
                    ,@"4",@"5",@"6",@"-"
                    ,@"1",@"2",@"3",@"+"
                    ,@"0",@"?",@".",@"="];
  int indexOfKeys = 0;
  for (NSString *key in keys){
    //循环所有键
    indexOfKeys++;
    int rowNum = indexOfKeys %4 ==0? indexOfKeys/4:indexOfKeys/4 +1;
    int colNum = indexOfKeys %4 ==0? 4 :indexOfKeys %4;
    NSLog(@"index is:%d and row:%d,col:%d",indexOfKeys,rowNum,colNum);
    //键样式
    UIButton *keyView = [UIButton buttonWithType:UIButtonTypeCustom];
    [keyboardView addSubview:keyView];
    [keyView setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [keyView setTitle:key forState:UIControlStateNormal];
    [keyView.layer setBorderWidth:1];
    [keyView.layer setBorderColor:[[UIColor blackColor]CGColor]];
    [keyView.titleLabel setFont:[UIFont fontWithName:@"Arial-BoldItalicMT" size:30]];
    //键约束
    [keyView mas_makeConstraints:^(MASConstraintMaker *make) {
      //处理 0 合并单元格
      if([key isEqualToString:@"0"] || [key isEqualToString:@"?"] ){
        if([key isEqualToString:@"0"]){
          [keyView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(keyboardView.mas_height).with.multipliedBy(.2f);
            make.width.equalTo(keyboardView.mas_width).multipliedBy(.5);
            make.left.equalTo(keyboardView.mas_left);
            make.baseline.equalTo(keyboardView.mas_baseline).with.multipliedBy(.9f);
          }];
        }if([key isEqualToString:@"?"]){
          [keyView removeFromSuperview];
        }
      }
      //正常的单元格
      else{
        make.width.equalTo(keyboardView.mas_width).with.multipliedBy(.25f);
        make.height.equalTo(keyboardView.mas_height).with.multipliedBy(.2f);
        //按照行和列添加约束，这里添加行约束
        switch (rowNum) {
          case 1:
          {
            make.baseline.equalTo(keyboardView.mas_baseline).with.multipliedBy(.1f);
            keyView.backgroundColor = [UIColor colorWithRed:205 green:205 blue:205 alpha:1];
          }
            break;
          case 2:
          {
            make.baseline.equalTo(keyboardView.mas_baseline).with.multipliedBy(.3f);
          }
            break;
          case 3:
          {
            make.baseline.equalTo(keyboardView.mas_baseline).with.multipliedBy(.5f);
          }
            break;
          case 4:
          {
            make.baseline.equalTo(keyboardView.mas_baseline).with.multipliedBy(.7f);
          }
            break;
          case 5:
          {
            make.baseline.equalTo(keyboardView.mas_baseline).with.multipliedBy(.9f);
          }
            break;
          default:
            break;
        }
        //按照行和列添加约束，这里添加列约束
        switch (colNum) {
          case 1:
          {
            make.left.equalTo(keyboardView.mas_left);
          }
            break;
          case 2:
          {
            make.right.equalTo(keyboardView.mas_centerX);
          }
            break;
          case 3:
          {
            make.left.equalTo(keyboardView.mas_centerX);
          }
            break;
          case 4:
          {
            make.right.equalTo(keyboardView.mas_right);
            [keyView setBackgroundColor:[UIColor colorWithRed:243 green:127 blue:38 alpha:1]];
          }
            break;
          default:
            break;
        }
      }
    }];
  }
}

#pragma mark 例子1
-(void)createUI
{
  self.title = @"Name";
  UIView *titleView = [UIView new];
  UIView *caredView = [UIView new];
  [self.view addSubview:caredView];
  UITextView *brifeView = [UITextView new];
  [self.view addSubview:brifeView];
  //self.view
  self.view.backgroundColor = [UIColor colorWithWhite:0.965 alpha:1.000];
  //thrm
  UIImageView *plantThrm = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"sticker01.png"]];
  [self.view addSubview:plantThrm];
  [plantThrm mas_makeConstraints:^(MASConstraintMaker *make) {
    make.left.and.top.equalTo(self.view).with.offset(10);
  }];
  //title
  [self.view addSubview:titleView];
  UIImageView *bgTitleView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"sticker02.png"]];
  [titleView addSubview:bgTitleView];
  [titleView mas_makeConstraints:^(MASConstraintMaker *make) {
    make.right.equalTo(self.view.mas_right);
    make.left.equalTo(plantThrm.mas_right).with.offset(20);
    make.centerY.equalTo(plantThrm.mas_centerY);
  }];
  [bgTitleView mas_makeConstraints:^(MASConstraintMaker *make) {
    make.edges.equalTo(titleView);
  }];
  UILabel *title = [[UILabel alloc]init];
  title.textColor =  [UIColor whiteColor];
  title.font = [UIFont fontWithName:@"Heiti SC" size:26];
  title.text = @"Name";
  [titleView addSubview:title];
  [title mas_makeConstraints:^(MASConstraintMaker *make) {
    make.left.equalTo(titleView.mas_left).offset(10);
    make.width.equalTo(titleView.mas_width);
    make.centerY.equalTo(titleView.mas_centerY);
  }];
  //植物养护
  UILabel *caredTitle = [[UILabel alloc]init];
  caredTitle.textColor =  [UIColor colorWithRed:0.172 green:0.171 blue:0.219 alpha:1.000];
  caredTitle.font = [UIFont fontWithName:@"Heiti SC" size:10];
  caredTitle.text = @"植物养护";
  [self.view addSubview:caredTitle];
  [caredTitle mas_makeConstraints:^(MASConstraintMaker *make) {
    make.top.equalTo(plantThrm.mas_bottom).with.offset(20);
    make.left.and.right.equalTo(self.view).with.offset(10);
    make.height.mas_equalTo(10);
  }];
  //植物养护 数据
  [self createIndexUIWithView:caredView];
  //将图层的边框设置为圆脚
  caredView.layer.cornerRadius = 5;
  caredView.layer.masksToBounds = YES;
  //给图层添加一个有色边框
  caredView.layer.borderWidth = 1;
  caredView.layer.borderColor = [[UIColor colorWithWhite:0.521 alpha:1.000] CGColor];
  caredView.backgroundColor = [UIColor whiteColor];
  [caredView mas_makeConstraints:^(MASConstraintMaker *make) {
    make.top.equalTo(caredTitle.mas_bottom).with.offset(5);
    make.left.equalTo(self.view.mas_left).with.offset(10);
    make.right.equalTo(self.view.mas_right).with.offset(-10);
    make.height.equalTo(brifeView);
  }];
  //植物简介
  UILabel *brifeTitle = [[UILabel alloc]init];
  brifeTitle.textColor =  [UIColor colorWithRed:0.172 green:0.171 blue:0.219 alpha:1.000];
  brifeTitle.font = [UIFont fontWithName:@"Heiti SC" size:10];
  brifeTitle.text = @"植物简介";
  [self.view addSubview:brifeTitle];
  [brifeTitle mas_makeConstraints:^(MASConstraintMaker *make) {
    make.top.equalTo(caredView.mas_bottom).with.offset(20);
    make.left.and.right.equalTo(self.view).with.offset(10);
    make.height.mas_equalTo(10);
  }];
  //将图层的边框设置为圆脚
  brifeView.layer.cornerRadius = 5;
  brifeView.layer.masksToBounds = YES;
  //给图层添加一个有色边框
  brifeView.layer.borderWidth = 1;
  brifeView.layer.borderColor = [[UIColor colorWithWhite:0.447 alpha:1.000] CGColor];
  brifeView.backgroundColor = [UIColor whiteColor];
  //文字样式
  //    brifeView.textColor = [UIColor colorWithWhite:0.352 alpha:1.000];
  //    brifeView.font = [UIFont fontWithName:@"HeiTi SC" size:12];
  NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc]init];
  paragraphStyle.lineHeightMultiple = 20.f;
  paragraphStyle.maximumLineHeight = 25.f;
  paragraphStyle.minimumLineHeight = 15.f;
  paragraphStyle.alignment = NSTextAlignmentJustified;
  NSDictionary *attributes = @{ NSFontAttributeName:[UIFont systemFontOfSize:12], NSParagraphStyleAttributeName:paragraphStyle, NSForegroundColorAttributeName:[UIColor colorWithWhite:0.447 alpha:1.000]};
  //植物简介数据
  //brifeView.text = _reference.brief;
  brifeView.attributedText = [[NSAttributedString alloc] initWithString: @"这是一个简介这是一个简介这是一个简介这是一个简介这是一个简介这是一个简介这是一个简介这是一个简介这是一个简介这是一个简介这是一个简介这是一个简介这是一个简介这是一个简介这是一个简介这是一个简介这是一个简介这是一个简介这是一个简介这是一个简介" attributes:attributes];
  [brifeView mas_makeConstraints:^(MASConstraintMaker *make) {
    make.top.equalTo(brifeTitle.mas_bottom).with.offset(5);
    make.left.equalTo(self.view.mas_left).with.offset(10);
    make.right.equalTo(self.view.mas_right).with.offset(-10);
    make.bottom.equalTo(self.view.mas_bottom).with.offset(-10);
    make.height.equalTo(caredView);
  }];
}

//把块拆分为四行
-(void)createIndexUIWithView:(UIView *)view{
  //拆分四行
  UIView *row1 = [UIView new];
  UIView *row2 = [UIView new];
  UIView *row3 = [UIView new];
  UIView *row4 = [UIView new];
  [view addSubview:row1];
  [view addSubview:row2];
  [view addSubview:row3];
  [view addSubview:row4];
  [row1 mas_makeConstraints:^(MASConstraintMaker *make) {
    make.right.and.left.equalTo(view);
    make.height.equalTo(view.mas_height).multipliedBy(0.25);
    make.top.equalTo(view.mas_top);
  }];
  [row2 mas_makeConstraints:^(MASConstraintMaker *make) {
    make.right.and.left.equalTo(view);
    make.top.equalTo(row1.mas_bottom);
    make.height.equalTo(view.mas_height).multipliedBy(0.25);
  }];
  [row3 mas_makeConstraints:^(MASConstraintMaker *make) {
    make.right.equalTo(view.mas_right);
    make.top.equalTo(row2.mas_bottom);
    make.height.equalTo(view.mas_height).multipliedBy(0.25);
    make.left.equalTo(view.mas_left);
  }];
  [row4 mas_makeConstraints:^(MASConstraintMaker *make) {
    make.right.and.left.equalTo(view);
    make.top.equalTo(row3.mas_bottom);
    make.height.equalTo(view.mas_height).multipliedBy(0.25);
  }];
  [self createIndexRowUI:PlantReferenceWaterIndex withUIView:row1];
  [self createIndexRowUI:PlantReferenceSumIndex withUIView:row2];
  [self createIndexRowUI:PlantReferenceTemperatureIndex withUIView:row3];
  [self createIndexRowUI:PlantReferenceElectrolyteIndex withUIView:row4];
}


//构造每行的UI
-(void)createIndexRowUI:(PlantReferenceIndex) index withUIView:(UIView *)view{
  //index标题
  UILabel *indexTitle = [UILabel new];
  indexTitle.font = [UIFont fontWithName:@"HeiTi SC" size:14];
  indexTitle.textColor = [UIColor colorWithWhite:0.326 alpha:1.000];
  [view addSubview:indexTitle];
  [indexTitle mas_makeConstraints:^(MASConstraintMaker *make) {
    make.left.equalTo(view.mas_left).with.offset(20);
    make.centerY.equalTo(view.mas_centerY);
  }];
  switch (index) {
    case PlantReferenceWaterIndex:
    {
      indexTitle.text = @"水分";
      UIImageView * current;
      for(int i=1;i<=5;i++){
        if(i<3){
          current = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"btn_good_on"]];
        }else{
          current = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"btn_bad_on"]];
        }
        [view addSubview:current];
        //间距12%，左边留空30%
        [current mas_makeConstraints:^(MASConstraintMaker *make) {
          make.left.equalTo(view.mas_right).with.multipliedBy(0.12*(i-1) +0.3);
          make.centerY.equalTo(view.mas_centerY);
        }];
      }
    }
      break;
    case PlantReferenceSumIndex:
    {
      indexTitle.text = @"光照";
      UIImageView * current;
      for(int i=1;i<=5;i++){
        if(i<3){
          current = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"btn_good_on"]];
        }else{
          current = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"btn_bad_on"]];
        }
        [view addSubview:current];
        //间距12%，左边留空30%
        [current mas_makeConstraints:^(MASConstraintMaker *make) {
          make.left.equalTo(view.mas_right).with.multipliedBy(0.12*(i-1) +0.3);
          make.centerY.equalTo(view.mas_centerY);
        }];
      }
    }
      break;
    case PlantReferenceTemperatureIndex:
    {
      indexTitle.text = @"温度";
      UIImageView * current;
      for(int i=1;i<=5;i++){
        if(i<3){
          current = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"btn_good_on"]];
        }else{
          current = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"btn_bad_on"]];
        }
        [view addSubview:current];
        //间距12%，左边留空30%
        [current mas_makeConstraints:^(MASConstraintMaker *make) {
          make.left.equalTo(view.mas_right).with.multipliedBy(0.12*(i-1) +0.3);
          make.centerY.equalTo(view.mas_centerY);
        }];
      }
    }
      break;
    case PlantReferenceElectrolyteIndex:
    {
      indexTitle.text = @"肥料";
      UIImageView * current;
      for(int i=1;i<=5;i++){
        if(i<3){
          current = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"btn_good_on"]];
        }else{
          current = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"btn_bad_on"]];
        }
        [view addSubview:current];
        //间距12%，左边留空30%
        [current mas_makeConstraints:^(MASConstraintMaker *make) {
          make.left.equalTo(view.mas_right).with.multipliedBy(0.12*(i-1) +0.3);
          make.centerY.equalTo(view.mas_centerY);
        }];
      }
    }
      break;
    default:
      break;
  }
}



@end
