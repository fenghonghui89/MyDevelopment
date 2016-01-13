//
//  NoteManage.m
//  MyNote
//
//  Created by hanyfeng on 14-5-13.
//  Copyright (c) 2014年 hanyfeng. All rights reserved.
//

#define ARCHIVER_FILE_KEY @"NotesList.archiver"
#define ARCHIVER_KEY @"NotesList"
#import "NoteManager.h"

@implementation NoteManager

static NoteManager *shareManager = nil;
+(NoteManager *)shareNoteManager
{
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        shareManager = [[self alloc] init];
        [shareManager managedObjectContext];//获得被管理的对象上下文
    });
    return shareManager;
}

#pragma mark - 增删改查数据 -
//插入数据
-(void)createData:(Note *)parmaNote
{
    //1.创建被管理的对象上下文
    NSManagedObjectContext *managedObjectContext = [self managedObjectContext];
    
    //2.创建被管理的实体类
    NoteManagedObject *managedObject = [NSEntityDescription insertNewObjectForEntityForName:@"Note" inManagedObjectContext:managedObjectContext];
    [managedObject setValue:parmaNote.content forKey:@"content"];
    [managedObject setValue:parmaNote.date forKey:@"date"];
    //设值可以写成下面那种
//    managedObject.content = parmaNote.content;
//    managedObject.date = parmaNote.date;
    

    
    //3.保存数据，同步到文件中
    NSError *error = nil;
    if ([self.managedObjectContext save:&error]) {
        NSLog(@"插入数据成功");
    }else{
        NSLog(@"插入数据失败");
    }
}

//删除数据
-(void)deleteData:(Note *)parmaNote
{
    NSManagedObjectContext *managedObjectContext = [self managedObjectContext];
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    
    NSEntityDescription *entityDescription = [NSEntityDescription entityForName:@"Note" inManagedObjectContext:managedObjectContext];
    [fetchRequest setEntity:entityDescription];
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"date = %@",parmaNote.date];
    [fetchRequest setPredicate:predicate];
    
    //执行数据提取
    NSError *error = nil;
    NSArray *noteData = [managedObjectContext executeFetchRequest:fetchRequest error:&error];
    if (noteData.count > 0) {
        NoteManagedObject *noteManagedObject = [noteData lastObject];
        [managedObjectContext deleteObject:noteManagedObject];
        
        if ([self.managedObjectContext save:&error]) {
            NSLog(@"删除数据成功");
        }else{
            NSLog(@"删除数据失败");
        }
    }
}

-(void)changeData:(Note *)parmaNote
{
    NSManagedObjectContext *managedObjectContext = [self managedObjectContext];
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    
    NSEntityDescription *entityDescription = [NSEntityDescription entityForName:@"Note" inManagedObjectContext:managedObjectContext];
    [fetchRequest setEntity:entityDescription];
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"date = %@",parmaNote.date];
    [fetchRequest setPredicate:predicate];
    
    NSError *error = nil;
    NSArray *noteData = [managedObjectContext executeFetchRequest:fetchRequest error:&error];
    if (noteData.count > 0) {
        NoteManagedObject *noteManagedObject = [noteData lastObject];
        noteManagedObject.content = parmaNote.content;
        
        if ([self.managedObjectContext save:&error]) {
            NSLog(@"修改数据成功");
        }else{
            NSLog(@"修改数据失败");
        }
    }
}

//查询所有数据
-(NSMutableArray *)allData
{
    //1.被管理的对象上下文
    NSManagedObjectContext *managedObjectContext = [self managedObjectContext];
    
    //2.创建请求
    //数据提取请求，用于查询
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    
    //与实体关联的描述类
    NSEntityDescription *entityDescription = [NSEntityDescription entityForName:@"Note" inManagedObjectContext:managedObjectContext];
    [fetchRequest setEntity:entityDescription];
    
    //排序描述
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"date" ascending:YES];
    [fetchRequest setSortDescriptors:@[sortDescriptor]];
    
    //3.执行请求
    NSError *error = nil;
    NSArray *noteData = [managedObjectContext executeFetchRequest:fetchRequest error:&error];
    
    //4.把被管理的实体类对象转换成未被管理的实体类对象
    NSMutableArray *noteArr = [NSMutableArray array];
    for (NoteManagedObject *noteManagedObject in noteData) {
        Note *note = [[Note alloc] init];
        note.content = noteManagedObject.content;
        note.date = noteManagedObject.date;
        [noteArr addObject:note];
    }
    return noteArr;
}

//按照主键查询数据
-(Note *)findData:(Note *)parmaNote
{
    NSManagedObjectContext *managedObjectContext = [self managedObjectContext];
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    
    NSEntityDescription *entityDescription = [NSEntityDescription entityForName:@"Note" inManagedObjectContext:managedObjectContext];
    [fetchRequest setEntity:entityDescription];
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"date = %@",parmaNote.date];
    [fetchRequest setPredicate:predicate];
    
    NSError *error = nil;
    NSArray *noteData = [managedObjectContext executeFetchRequest:fetchRequest error:&error];
    if (noteData.count > 0) {
        NoteManagedObject *noteManagedObject = [noteData lastObject];
        Note *note = [[Note alloc] init];
        note.content = noteManagedObject.content;
        note.date = noteManagedObject.date;
        return note;
    }
    
    return nil;
}
@end
