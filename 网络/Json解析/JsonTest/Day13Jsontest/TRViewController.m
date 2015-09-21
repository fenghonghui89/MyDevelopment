//
//  TRViewController.m
//  Day13Jsontest
//
//  Created by Tarena on 13-12-18.
//  Copyright (c) 2013年 Tarena. All rights reserved.
//

#import "TRViewController.h"
#import "TRFault.h"
@interface TRViewController ()
@property (nonatomic, strong)NSMutableArray *faults;
@end

@implementation TRViewController



- (void)viewDidLoad
{
    [super viewDidLoad];
    //发送请求，取得服务器返回的二进制数据
    NSURL *url = [NSURL URLWithString:@"http://telematic.sinaapp.com/webservice/getFaultInfo?phone=13801369695&page=1&num=5&token=079a1724ca0e635f9dd7cc2434f6d4d3"];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    NSData *jsonData = [NSURLConnection sendSynchronousRequest:request returningResponse:Nil error:Nil];
    
    //把二进制数据转换成json字符串
    NSString *jsonStr = [[NSString alloc]initWithData:jsonData encoding:NSUTF8StringEncoding];

    //解析json字符串，获取数据
    NSDictionary *dic = [jsonStr JSONValue];
    NSArray *faultsArr = [dic objectForKey:@"faults"];
    
    [self parseFaultsByArray:faultsArr];
}

-(void)parseFaultsByArray:(NSArray *)faultsArr{
    self.faults = [NSMutableArray array];
    
    for (NSDictionary *faultDic in faultsArr) {
        TRFault *f = [[TRFault alloc]init];
        f.info = [faultDic objectForKey:@"fault_info"];
        f.time = [faultDic objectForKey:@"created_time"];
        f.solution =[faultDic objectForKey:@"solution"];
        [self.faults addObject:f];
    }
    
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    // Return the number of rows in the section.
    return self.faults.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    TRFault *f = self.faults[indexPath.row];
    cell.textLabel.text =f.info;
    cell.detailTextLabel.text = f.time;
    
    return cell;
}
@end
