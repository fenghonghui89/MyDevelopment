//
//  ViewController1.m
//  TestProjectWithOC
//
//  Created by hanyfeng on 2018/8/16.
//  Copyright © 2018年 JiepengZhengDevExtend. All rights reserved.
//

#import "ViewController1_0.h"
#import "ViewController2.h"
#import "ViewController3_0.h"
#import "XTJNavigationItem_Main.h"
#import "XANavBarTransition.h"
@interface ViewController1_0 ()
<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation ViewController1_0

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self customInitNavigationBar];
    [self customInitView];
    
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
}

-(void)viewWillDisappear:(BOOL)animated{
    self.navigationController.navigationBar.barTintColor = HexColor(@"934d91");
    [super viewWillDisappear:animated];
}

#pragma mark - init
-(void)customInitNavigationBar{
    XTJNavigationItem_Main *homeBar = [XTJNavigationItem_Main loadNibWithOwner:self];
    self.navigationItem.titleView = homeBar;
    homeBar.title = @"商品详情";
    XTJBlockWeak(self);
    homeBar.leftBarButton0Handler = ^{
        [weak_self.navigationController popViewControllerAnimated:YES];
    };
    
    self.xa_navBarAlpha = 0;
}

-(void)customInitView{
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.backgroundColor = [UIColor whiteColor];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cellId"];
    if (@available(iOS 11.0,*)) {
        self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }else{
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
}



#pragma mark - table view
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 100;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellId"];
    cell.textLabel.text = [NSString stringWithFormat:@"%ld",(long)indexPath.row];
    if (indexPath.row == 0) {
        cell.backgroundColor = HexColor(@"934d91");
    }else{
        cell.backgroundColor = [UIColor whiteColor];
    }
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        return screenW-stateH-naviH;
    }else{
        return 30;
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    ViewController2 *vc = [[ViewController2 alloc] initWithNibName:@"ViewController2" bundle:nil];
    [self.navigationController pushViewController:vc animated:YES isNeedLogin:NO];

}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    CGPoint point = scrollView.contentOffset;
    CGFloat y = point.y;
    
    //导航栏透明度
    CGFloat alpha = y/((screenW-stateH-naviH)*1.0);//减慢速度
    if (alpha>1) {
        alpha = 1;
    }else if (alpha<0){
        alpha = 0;
    }
    
    NSLog(@"alpha...%f",alpha);
    [self.navigationController xa_changeNavBarAlpha:alpha];
    self.xa_navBarAlpha = alpha;
}
@end
