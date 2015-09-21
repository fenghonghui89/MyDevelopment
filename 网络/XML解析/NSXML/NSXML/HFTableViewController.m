//
//  HFTableViewController.m
//  NSXML
//
//  Created by hanyfeng on 14-6-23.
//  Copyright (c) 2014年 hanyfeng. All rights reserved.
//

#import "HFTableViewController.h"
#import "XMLParser.h"

@interface HFTableViewController ()
@property(nonatomic,strong)NSMutableArray *notes;
@end

@implementation HFTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(reloadView:)
                                                 name:@"reloadViewNotification"
                                               object:nil];
    
    XMLParser *parser = [XMLParser new];
    [parser start];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.notes.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"  forIndexPath:indexPath];
    
    NSMutableDictionary*  dict = self.notes[indexPath.row];
    cell.textLabel.text = [dict objectForKey:@"Content"];
    cell.detailTextLabel.text = [dict objectForKey:@"CDate"];
    
    return cell;
}

#pragma mark - 处理通知（获取解析的数据）
-(void)reloadView:(NSNotification*)notification
{
    NSMutableArray *notes = [notification object];
    self.notes  = notes;
    [self.tableView reloadData];
}

@end
