//
//  TRViewController.m
//  Day1Persons
//
//  Created by Tarena on 13-12-2.
//  Copyright (c) 2013年 Tarena. All rights reserved.
//

#import "TRViewController.h"
#import "TRPerson.h"
#import "TRAddPersonViewController.h"
@interface TRViewController ()
@property (nonatomic,strong)NSMutableArray *persons;
@end

@implementation TRViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    self.persons = [NSMutableArray array];
}

-(void)viewWillAppear:(BOOL)animated
{
    NSData *personsData = [NSData dataWithContentsOfFile:@"/Users/hanyfeng/Desktop/personsData"];
    
    //如果存储文件不存在，则跳出该方法；如果存在，则读取里面的数组并用属性接收
    if (!personsData) {
        return;//跳出当前方法
    }else {
        NSKeyedUnarchiver *unArch = [[NSKeyedUnarchiver alloc]initForReadingWithData:personsData];
        self.persons = [unArch decodeObjectForKey:@"persons"];
    }
    
    //让tableView刷新一下数据
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
    return self.persons.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    TRPerson *person = [self.persons objectAtIndex:indexPath.row];
    cell.textLabel.text = person.name;
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%d",person.age];
    
    return cell;
}

//点击row修改联系人信息
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //执行对应标识符的segue跳转
    //把数组下标用NSNumber包装成对象，然后作为prepareForSegue:方法的参数传递过去
    [self performSegueWithIdentifier:@"editvc" sender:[NSNumber numberWithLong:indexPath.row]];
}


//当使用segue跳转的时候，跳转之前调用此方法，作用是用来传参
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    //判断点击的是按钮，还是Cell————判断接收到的参数（sender）是否NSNumber的子类
    if ([sender isKindOfClass:[NSNumber class]]) {
        TRAddPersonViewController *vc = segue.destinationViewController;
        vc.persons = self.persons;
        vc.row = [sender intValue];
    }
}

/*
 // Override to support conditional editing of the table view.
 - (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
 {
 // Return NO if you do not want the specified item to be editable.
 return YES;
 }
 */

@end
