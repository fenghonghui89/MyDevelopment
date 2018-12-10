//
//  HFViewController.m
//  TableViewZheDieOfMy
//
//  Created by hanyfeng on 14-4-3.
//  Copyright (c) 2014年 hanyfeng. All rights reserved.
//



#import "HFViewController.h"

@interface HFViewController ()
@property(nonatomic,retain)NSMutableDictionary *md;
@property(nonatomic,retain)UITableView *tv;
@end

@implementation HFViewController

-(void)dealloc{
    [self.md release];
    [self.tv release];
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
    
    CGRect screenFrame = [[UIScreen mainScreen] bounds];
    // Do any additional setup after loading the view.
    UITableView *tv = [[UITableView alloc] initWithFrame:screenFrame style:UITableViewStyleGrouped];
    tv.delegate = self;
    tv.dataSource = self;
    self.tv = tv;
    [tv release];
    [self.view addSubview:self.tv];
    [self.tv release];
    
    self.md = [NSMutableDictionary dictionaryWithCapacity:8];
//    self.md = [[NSMutableDictionary alloc] init];
    
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
    cell.selectionStyle = UITableViewCellSelectionStyleBlue;
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([[self.md objectForKey:indexPath] isEqualToString:@"88"]) {
        NSLog(@"------11");
        return 100;
    }
    return 33;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    
    if (cell.frame.size.height == 33) {
        NSString *heightValue = @"88";
        NSLog(@"------1");
        [self.md setObject:heightValue forKey:indexPath];
        [heightValue release];
    }else {
        NSLog(@"------2");
        [self.md removeObjectForKey:indexPath];
    }
    
   
    
    [self.tv reloadRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    
    
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
