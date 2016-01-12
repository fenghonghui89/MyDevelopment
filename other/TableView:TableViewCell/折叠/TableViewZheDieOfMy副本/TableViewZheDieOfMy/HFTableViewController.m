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
    NSLog(@"tv.frame:%f,%f",self.tableView.frame.size.width,self.tableView.frame.size.height);
    self.md = [NSMutableDictionary dictionaryWithCapacity:3];
}

#pragma mark tableview datasouce
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 10;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 2;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    //文字row
    if (indexPath.row == 0) {
        static NSString *identifier = @"content";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (cell == nil) {
            cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier] autorelease];
        }
        
        NSString *testString = @"岁月流芳，花开几度，走在岁月里，醉在流香里，总在时光里辗转徘徊。花开几许，落花几度，岁月寒香，飘进谁的诗行，一抹幽香，掺入几许愁伤，流年似花，春来秋往，睁开迷离的双眼，回首张望，随风的尘烟荡漾着迷忙，昨日的光阴已逝去，留下无尽的回忆让人留恋与追忆";
        cell.textLabel.text = testString;
        cell.textLabel.font = [UIFont systemFontOfSize:12.0f];
        cell.textLabel.opaque = NO;
        cell.textLabel.numberOfLines = 8;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        return cell;

    }
    
    //图片row
    static NSString *identifier = @"image";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier] autorelease];
    }
    
    NSString *testString = @"image";
    cell.textLabel.text = testString;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return 0.0f;
    }else return 5;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == 0) {
        if ([[_md objectForKey:indexPath] isEqualToString:isOpen]) {
            return [[_md objectForKey:indexPath] floatValue];
        }
        return originalHeight;
    }
    return originalHeight;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == 0) {
        UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        
        if (cell.frame.size.height == originalHeight)
        {
            [_md setObject:isOpen forKey:indexPath];
        }
        
        else
        {
            [_md removeObjectForKey:indexPath];
        }
        
        //局部更新
        [self.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath,nil] withRowAnimation:UITableViewRowAnimationFade];
    }
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
