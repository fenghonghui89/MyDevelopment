//
//  AddStudentViewController.h
//  CoreData_SectionDemo
//
//  Created by Ibokan on 14-1-10.
//  Copyright (c) 2014年 Zhang_Dinghui. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddStudentViewController : UIViewController

@property (nonatomic , strong)NSManagedObjectContext *managedObjectContext;
@property (nonatomic , strong)NSFetchedResultsController *fetchedResultsController;

@end
