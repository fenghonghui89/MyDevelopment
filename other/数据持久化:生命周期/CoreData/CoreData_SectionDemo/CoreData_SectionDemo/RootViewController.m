//
//  RootViewController.m
//  CoreData_SectionDemo
//
//  Created by Ibokan on 14-1-10.
//  Copyright (c) 2014年 Zhang_Dinghui. All rights reserved.
//

#import "RootViewController.h"
#import "Student.h"
#import "Classes.h"
#import "AddStudentViewController.h"
@interface RootViewController (){
    NSFetchedResultsController *_fetchedResultsController;
    NSManagedObjectContext *_managedObjectContext;

}

@end

@implementation RootViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization //构建学生
        [self createStudentObject];
        //初始化班级
        [self createClasses];
         self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addStudent)];
    }
    return self;
}
- (void)createStudentObject{
    UIApplication *app = [UIApplication sharedApplication];
    id delegate = app.delegate;
    //获取托管对象上下文
    _managedObjectContext = [delegate managedObjectContext];
    //抓取对象
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"Student"];
    //排序对象
    NSSortDescriptor *sort = [[NSSortDescriptor alloc]initWithKey:@"id" ascending:YES];
    [fetchRequest setSortDescriptors:@[sort]];
    
    //监控coreData的数据变化
    NSFetchedResultsController *controller =
    [[NSFetchedResultsController alloc]
     initWithFetchRequest:fetchRequest
     managedObjectContext:_managedObjectContext
     sectionNameKeyPath:@"classes"
     cacheName:@"student"];
    _fetchedResultsController = controller;
    controller.delegate = self;
    
    
    NSError *error = nil;
    BOOL success = [_fetchedResultsController performFetch:&error];
    if(!success){
        NSLog(@"NSFetchedResultsController error:%@" , error);
    }
}


- (void)createClasses{
    NSFetchRequest *fetch = [NSFetchRequest fetchRequestWithEntityName:@"Classes"];
    NSArray *classes = [_managedObjectContext executeFetchRequest:fetch error:nil];
    if(classes.count == 0){
        NSArray *array = @[@"数学课",@"语文课",@"英语课",@"体育课"];
        static int ID = 1;
        for(NSString *classesStr in array){
            Classes *class = [NSEntityDescription insertNewObjectForEntityForName:@"Classes" inManagedObjectContext:_managedObjectContext];
            class.name = classesStr;
            class.id = [NSNumber numberWithInt:ID];
            ID ++;
        }
        [_managedObjectContext save:nil];
    }
}

- (void)addStudent{
    AddStudentViewController *add = [[AddStudentViewController alloc]initWithNibName:@"AddStudentViewController" bundle:nil];
    add.managedObjectContext = _managedObjectContext;
    [self presentViewController:add animated:YES completion:^{
       
    [self.tableView reloadData];
    }];
    
}


- (void)viewDidLoad
{
    [super viewDidLoad];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [[_fetchedResultsController sections]count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if ([[_fetchedResultsController sections] count] > 0) {
        id <NSFetchedResultsSectionInfo> sectionInfo = [[_fetchedResultsController sections] objectAtIndex:section];
    
        return [sectionInfo numberOfObjects];
        
    } else
        return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *Cellldetifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:Cellldetifier];
    if(cell == nil){
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:Cellldetifier];
    }
    
    Student *stu  = [_fetchedResultsController objectAtIndexPath:indexPath];
    cell.textLabel.text = stu.name;
    cell.detailTextLabel.text = [stu.id stringValue];
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if ([[_fetchedResultsController sections] count] > 0) {
        id <NSFetchedResultsSectionInfo> sectionInfo = [[_fetchedResultsController sections] objectAtIndex:section];
        return [sectionInfo name];
    } else
        return nil;
}

- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView{
    NSArray *array = [_fetchedResultsController sections];
    NSMutableArray *arrays = [NSMutableArray arrayWithCapacity:42];
    for(id <NSFetchedResultsSectionInfo> sectionInfo in array){
        [arrays addObject:[sectionInfo name]];
    }
    return arrays;
}

#pragma mark NSFetchedRequestDelegated的委托
- (void)controllerWillChangeContent:(NSFetchedResultsController *)controller {
    [self.tableView beginUpdates];
}

#pragma mark 数据变化引起分区的变化时调用
- (void)controller:(NSFetchedResultsController *)controller didChangeSection:(id <NSFetchedResultsSectionInfo>)sectionInfo
           atIndex:(NSUInteger)sectionIndex forChangeType:(NSFetchedResultsChangeType)type {
    
    switch(type) {
        case NSFetchedResultsChangeInsert:
            [self.tableView insertSections:[NSIndexSet indexSetWithIndex:sectionIndex]
                          withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeDelete:
            [self.tableView deleteSections:[NSIndexSet indexSetWithIndex:sectionIndex]
                          withRowAnimation:UITableViewRowAnimationFade];
            break;
    }
}

#pragma mark 增,删,改,移动 后执行
- (void)controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject
       atIndexPath:(NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type
      newIndexPath:(NSIndexPath *)newIndexPath {
    
    UITableView *tableView = self.tableView;
    
    switch(type) {
            
        case NSFetchedResultsChangeInsert:
            [tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:newIndexPath]
                             withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeDelete:
            [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath]
                             withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeUpdate:
            [tableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:newIndexPath]
                             withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeMove:
            [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath]
                             withRowAnimation:UITableViewRowAnimationFade];
            [tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:newIndexPath]
                             withRowAnimation:UITableViewRowAnimationFade];
            break;
    }
}

#pragma mark 数据变化结束后调用
- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller {
    [self.tableView endUpdates];
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
    return UITableViewCellEditingStyleDelete;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    if(editingStyle == UITableViewCellEditingStyleDelete){
        Student *stu = [_fetchedResultsController objectAtIndexPath:indexPath];
        [_managedObjectContext deleteObject:stu];
        __autoreleasing NSError *error;
        [_managedObjectContext save:&error];
        if(error){
            NSLog(@"删除失败:%@",error);
        }
    }
}
@end
