//
//  HFViewController.m
//  TableViewFold
//
//  Created by hanyfeng on 14-4-10.
//  Copyright (c) 2014年 hanyfeng. All rights reserved.
//

#import "HFViewController.h"
#import "HFData.h"
@interface HFViewController ()
@property(nonatomic,strong)NSMutableArray *marr;
@property(nonatomic,strong)UITableView *tv;
@end

@implementation HFViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    CGRect screenFrame = [[UIScreen mainScreen] bounds];
    UITableView *tv = [[UITableView alloc] initWithFrame:screenFrame style:UITableViewStyleGrouped];
    tv.dataSource = self;
    tv.delegate = self;
    self.tv = tv;
    [self.view addSubview:self.tv];
    
    self.marr = [HFData data];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - tableView datasource and delegate -
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.marr.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSMutableDictionary *mdic = [self.marr objectAtIndex:section];
    
    //mdic不存在expand键值 或 值为NO，则没有row
    if (![mdic objectForKey:@"expand"]||[[mdic objectForKey:@"expand"] boolValue]== NO) {
        return 0;
    }
    
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *identifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    
    NSMutableDictionary *mdic = [self.marr objectAtIndex:indexPath.section];
    NSString* content = [mdic objectForKey:@"content"];
    
    cell.textLabel.text = content;
    cell.textLabel.numberOfLines = 8;
    cell.textLabel.font = [UIFont systemFontOfSize:17.0f];
    cell.textLabel.opaque = NO;
    
    return  cell;
}

#pragma mark - 计算字符串所占空间 -
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString* content = [[self.marr objectAtIndex:indexPath.section] objectForKey:@"content"];
    
    //根据IOS版本调用不同的api
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0) {

        CGSize contentSize = [self getStringRect_IOS7:content andFont:[UIFont systemFontOfSize:17]];
        return contentSize.height + 20;
    }
    
    CGSize contentSize = [self getStringRect_IOS6:content andFont:[UIFont systemFontOfSize:17]];
    return contentSize.height + 20;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 44;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.tv.frame.size.width, 44)];
    UIButton *headerButton = [UIButton buttonWithType:UIButtonTypeSystem];
    
    [headerButton setFrame:headerView.frame];
    [headerButton setTag:section];
    [headerButton setTitle:[[self.marr objectAtIndex:section] objectForKey:@"header"] forState:UIControlStateNormal];
    
    //修改展开或折叠时的按钮背景
    if ([[[self.marr objectAtIndex:section] objectForKey:@"expand"] boolValue] == YES)
    {
        [headerButton setBackgroundImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"button" ofType:@"png"]] forState:UIControlStateNormal];
    }
    else
    {
        [headerButton setBackgroundColor:[UIColor grayColor]];
    }
    
    [headerButton addTarget:self action:@selector(tap:) forControlEvents:UIControlEventTouchUpInside];
    
    [headerView addSubview:headerButton];
    
    return headerView;
}

#pragma mark - 展开cell -

#pragma mark --点击sectionHeader按钮-修改对象字典中得expand键值-reloadData
-(void)tap:(UIButton*)button{
    UIButton* btn = button;
    [self expand:btn.tag];
    [self.tv reloadData];
}

#pragma mark --修改对象字典中得expand键值
-(void)expand:(NSInteger)section{
    
    BOOL expand = YES;
    NSMutableDictionary *mdic = [self.marr objectAtIndex:section];
    
    //1.如果mdic不存在expand这个键值，则添加expand键值，且值为YES（初始状态）
    //  如果值为NO，则改为YES
    if (![[mdic objectForKey:@"expand"] boolValue] == YES)
    {
        [mdic setObject:[NSNumber numberWithBool:expand] forKey:@"expand"];//如果为NO，直接替换，不用先remove
        for (int i = 0; i<self.marr.count; i++) {
            if (i != section) {
                NSMutableDictionary *mdic = [self.marr objectAtIndex:i];
                [mdic removeObjectForKey:@"expand"];
            }
        }
        return;
    }
    
    //2.如果值为YES，则改为NO
    if([[mdic objectForKey:@"expand"] boolValue] == YES)
    {
        [mdic setObject:[NSNumber numberWithBool:!expand] forKey:@"expand"];
        return;
    }
    
}

//获取字符串的大小  ios6
- (CGSize)getStringRect_IOS6:(NSString *)aString andFont:(UIFont *)aFont
{
    CGSize size = [aString sizeWithFont:aFont constrainedToSize:CGSizeMake(320, MAXFLOAT) lineBreakMode:NSLineBreakByCharWrapping];
    
    return size;
}

//获取字符串的大小  ios7
- (CGSize)getStringRect_IOS7:(NSString*)aString andFont:(UIFont *)aFont
{
    //label默认：17号字
    NSDictionary *attribute_dic = @{NSFontAttributeName: aFont};
    
    //Helvetica字体默认大小：12号字（点击NSFontAttributeName，旁边绿色的注释有写）
//    NSAttributedString* atrString = [[NSAttributedString alloc] initWithString:aString];
//    NSRange range = NSMakeRange(0, atrString.length);
//    NSDictionary *dic = [atrString attributesAtIndex:0 effectiveRange:&range];
    
    CGRect rect = [aString boundingRectWithSize:CGSizeMake(320, MAXFLOAT)  options:NSStringDrawingUsesLineFragmentOrigin attributes:attribute_dic context:nil];
    
    return  rect.size;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
