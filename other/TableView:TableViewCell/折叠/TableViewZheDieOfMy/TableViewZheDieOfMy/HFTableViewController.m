//
//  HFViewController.m
//  TableViewZheDieOfMy
//
//  Created by hanyfeng on 14-4-3.
//  Copyright (c) 2014年 hanyfeng. All rights reserved.
//

#define originalHeight 25.0f//原始高度
#define newHeight 85.0f//展开高度
#define isOpen @"85.0f"

#import "HFTableViewController.h"

@interface HFTableViewController ()
@property(nonatomic,retain)NSMutableDictionary *md;
@end

@implementation HFTableViewController

-(void)dealloc{
    [_md release];
    [super dealloc];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

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
    self.md = [NSMutableDictionary dictionaryWithCapacity:8];
}

#pragma mark tableview datasouce
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 5;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *identifier = @"content";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier] autorelease];
    }
    
    NSString *testString = @"岁月流芳，花开几度，走在岁月里，醉在流香里，总在时光里辗转徘徊。花开几许，落花几度，岁月寒香，飘进谁的诗行，一抹幽香，掺入几许愁伤，流年似花，春来秋往，睁开迷离的双眼，回首张望，随风的尘烟荡漾着迷忙，昨日的光阴已逝去，留下无尽的回忆让人留恋与追忆";
    cell.textLabel.text = testString;
    
    cell.textLabel.opaque = NO;
    cell.textLabel.numberOfLines = 8;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 100.0f;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([[_md objectForKey:indexPath] isEqualToString:isOpen]) {
        NSLog(@"------11");
        NSLog(@"~~~~~index:%@",indexPath);
        NSLog(@"~~~~~self.md:%@",_md);
        return [[_md objectForKey:indexPath] floatValue];
    }
    return originalHeight;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    
    if (cell.frame.size.height == originalHeight) {
        NSLog(@"------1");
        NSLog(@"section:%d,row:%d",indexPath.section,indexPath.row);
        NSLog(@"isOpen:%p",isOpen);
        [_md setObject:isOpen forKey:indexPath];
        
    }else {
        NSLog(@"------2");
        [_md removeObjectForKey:indexPath];
    }
    
    [self.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath,nil] withRowAnimation:UITableViewRowAnimationFade];
    
    NSLog(@"index:%@",indexPath);
    NSLog(@"self.md:%@",_md);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
