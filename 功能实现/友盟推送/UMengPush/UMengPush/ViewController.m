//
//  ViewController.m
//  UMengPush
//
//  Created by 冯鸿辉 on 16/3/31.
//  Copyright © 2016年 DGC. All rights reserved.
//

#import "ViewController.h"
#import "UMengPushManager.h"
@interface ViewController ()<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableview;
@property (weak, nonatomic) IBOutlet UITextField *textfield;
@property(nonatomic,strong)NSMutableArray *tags;
@property (weak, nonatomic) IBOutlet UILabel *deviceTokenLabel;

@end

@implementation ViewController

#pragma mark - < vc lifecycle > -

-(void)dealloc{

  [[NSNotificationCenter defaultCenter] removeObserver:self name:@"initUI" object:nil];
}
- (void)viewDidLoad {
  
  [super viewDidLoad];
  
  self.tags = [NSMutableArray array];
  
  self.tableview.delegate = self;
  self.tableview.dataSource = self;
  
  self.textfield.delegate = self;
  
  [self.tableview reloadData];
  
  [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(customInitUI) name:@"initUI" object:nil];
}

-(void)customInitUI{

  NSString *dt = [[NSUserDefaults standardUserDefaults] objectForKey:@"deviceToken"];
  [self.deviceTokenLabel setText:dt];
}

#pragma mark - < action > -
- (IBAction)btnTap:(UIButton *)sender {
  
  switch (sender.tag) {
    case 0://delete all
      [self removeAllTag];
      break;
    case 1://get tag list
      [self getTags];
      break;
    case 2://add tag
      [self addtage];
      break;
    case 3://start push
    {
      [[UMengPushManager sharedManager] restartPush];
    }
      break;
    case 4://stop push
      [[UMengPushManager sharedManager] stopPush];
      break;
    case 5://edit
      if (self.tableview.editing) {
        [self.tableview setEditing:NO animated:YES];
      }else{
        [self.tableview setEditing:YES animated:YES];
      }
      break;
    default:
      break;
  }
}

-(void)removeAllTag{

  [[UMengPushManager sharedManager] removeAllTag:^(id responseObject, NSInteger remain, NSError *error) {
    
    [self getTags];
  }];
}

-(void)getTags{
  
  [[UMengPushManager sharedManager] getTags:^(NSSet *responseTages, NSInteger remain, NSError *error) {
    if (!error) {
      self.tags = [NSMutableArray arrayWithArray:responseTages.allObjects];
      [self.tableview reloadData];
    }else{
      NSLog(@"error:%@",[error localizedDescription]);
    }
  }];
}

-(void)addtage{
  
  NSString *tag = self.textfield.text;
  [[UMengPushManager sharedManager] addTag:tag response:^(id responseObject, NSInteger remain, NSError *error) {
    [self getTags];
  }];
}

-(void)removeTag:(id)tag{

  [[UMengPushManager sharedManager] removeTag:tag response:^(id responseObject, NSInteger remain, NSError *error) {
    [self getTags];
  }];
}

#pragma mark - < callback > -
#pragma mark UITextFieldDelegate
-(BOOL)textFieldShouldReturn:(UITextField *)textField{

  [textField resignFirstResponder];
  return YES;
}

#pragma mark UITableViewDelegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
  NSInteger count = self.tags.count;
  return count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
  
  static NSString *cellid = @"cellid";
  UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellid];
  if (!cell) {
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid];
  }
  
  NSString *tag = [self.tags objectAtIndex:indexPath.row];
  cell.textLabel.text = tag;
  return cell;
}

-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
  return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
  if (editingStyle == UITableViewCellEditingStyleDelete) {
    NSString *tag = [self.tags objectAtIndex:indexPath.row];
    [self removeTag:tag];
    [self.tags removeObjectAtIndex:indexPath.row];
    [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
  }
}

@end
