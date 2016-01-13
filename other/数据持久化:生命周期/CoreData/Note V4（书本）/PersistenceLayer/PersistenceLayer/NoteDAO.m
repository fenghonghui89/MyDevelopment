//
//  NoteDAO.m
//  MyNotes
//
//  Created by 关东升 on 12-9-26.
//  本书网站：http://www.iosbook1.com
//  智捷iOS课堂：http://www.51work6.com
//  智捷iOS课堂在线课堂：http://v.51work6.com
//  智捷iOS课堂新浪微博：http://weibo.com/u/3215753973
//  作者微博：http://weibo.com/516inc
//  官方csdn博客：http://blog.csdn.net/tonny_guan
//  QQ：1575716557 邮箱：jylong06@163.com
//

#import "NoteDAO.h"

@implementation NoteDAO

static NoteDAO *sharedManager = nil;

+ (NoteDAO*)sharedManager
{
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        
        sharedManager = [[self alloc] init];
        [sharedManager managedObjectContext];
        
    });
    return sharedManager;
}


//插入Note方法
-(int) create:(Note*)model
{
    
    NSManagedObjectContext *cxt = [self managedObjectContext];
    
    //创建被管理的实体对象并设值
    NoteManagedObject *note = [NSEntityDescription insertNewObjectForEntityForName:@"Note" inManagedObjectContext:cxt];
    [note setValue: model.content forKey:@"content"];
    [note setValue: model.date forKey:@"date"];
    //设值可以写成下面那种
//    note.date = model.date;
//    note.content = model.content;
    
    //保存修改，同步到文件中
    NSError *savingError = nil;
    if ([self.managedObjectContext save:&savingError]){
        NSLog(@"插入数据成功");
    } else {
        NSLog(@"插入数据失败");
        return -1;
    }
    
    return 0;
}

//删除Note方法
-(int) remove:(Note*)model
{
    
    NSManagedObjectContext *cxt = [self managedObjectContext];

    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    
    NSEntityDescription *entityDescription = [NSEntityDescription entityForName:@"Note" inManagedObjectContext:cxt];
    [request setEntity:entityDescription];
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"date =  %@", model.date];
    [request setPredicate:predicate];
    
    NSError *error = nil;
    NSArray *listData = [cxt executeFetchRequest:request error:&error];
    if ([listData count] > 0) {
        NoteManagedObject *note = [listData lastObject];
        [self.managedObjectContext deleteObject:note];
        
        NSError *savingError = nil;
        if ([self.managedObjectContext save:&savingError]){
            NSLog(@"删除数据成功");
        } else {
            NSLog(@"删除数据失败");
            return -1;
        }
    }
    
    return 0;
}

//修改Note方法
-(int) modify:(Note*)model
{
    NSManagedObjectContext *cxt = [self managedObjectContext];
    
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    
    NSEntityDescription *entityDescription = [NSEntityDescription entityForName:@"Note" inManagedObjectContext:cxt];
    [request setEntity:entityDescription];
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"date =  %@", model.date];
    [request setPredicate:predicate];
    
    NSError *error = nil;
    NSArray *listData = [cxt executeFetchRequest:request error:&error];
    if ([listData count] > 0) {
        NoteManagedObject *note = [listData lastObject];
        note.content = model.content;
        
        NSError *savingError = nil;
        if ([self.managedObjectContext save:&savingError]){
            NSLog(@"修改数据成功");
        } else {
            NSLog(@"修改数据失败");
            return -1;
        }
    }
    return 0;
}

//查询所有数据方法
-(NSMutableArray*) findAll
{
    //1.被管理的对象上下文
    NSManagedObjectContext *cxt = [self managedObjectContext];
    
    //2.创建请求
    //数据提取请求，用于查询
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    
    //与实体关联的描述类
    NSEntityDescription *entityDescription = [NSEntityDescription entityForName:@"Note" inManagedObjectContext:cxt];
    [request setEntity:entityDescription];
    
    //排序描述
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"date" ascending:YES];
    [request setSortDescriptors:@[sortDescriptor]];
    
    //3.执行请求
    NSError *error = nil;
    NSArray *listData = [cxt executeFetchRequest:request error:&error];
    
    //4.把被管理的实体类对象转换成未被管理的实体类对象
    NSMutableArray *resListData = [[NSMutableArray alloc] init];
    
    for (NoteManagedObject *mo in listData) {
        Note *note = [[Note alloc] init];
        note.date = mo.date;
        note.content = mo.content;
        [resListData addObject:note];
    }
    
    return resListData;
}

//按照主键查询数据方法
-(Note*) findById:(Note*)model
{
    NSManagedObjectContext *cxt = [self managedObjectContext];
    
    NSEntityDescription *entityDescription = [NSEntityDescription
                                              entityForName:@"Note" inManagedObjectContext:cxt];
    
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:entityDescription];
    
    //定义一个逻辑查询条件，在内存中过滤集合对象
    NSPredicate *predicate = [NSPredicate predicateWithFormat:
                              @"date =  %@",model.date];
    [request setPredicate:predicate];
    
    NSError *error = nil;
    NSArray *listData = [cxt executeFetchRequest:request error:&error];
    
    if ([listData count] > 0) {
        NoteManagedObject *mo = [listData lastObject];
        
        Note *note = [[Note alloc] init];
        note.date = mo.date;
        note.content = mo.content;
        
        return note;
    }
    return nil;
}



@end
