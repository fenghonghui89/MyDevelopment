//
//  AddStudentViewController.m
//  CoreData_SectionDemo
//
//  Created by Ibokan on 14-1-10.
//  Copyright (c) 2014年 Zhang_Dinghui. All rights reserved.
//

#import "AddStudentViewController.h"
#import "Student.h"
#import "Classes.h"

@interface AddStudentViewController ()
@property (weak, nonatomic) IBOutlet UITextField *textName;
@property (weak, nonatomic) IBOutlet UITextField *textId;
@property (weak, nonatomic) IBOutlet UISegmentedControl *textClasses;

@end

@implementation AddStudentViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (IBAction)addStudent:(id)sender{
    [self createStudentIntoClasses];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)createStudentIntoClasses{
    Student *stu = [NSEntityDescription insertNewObjectForEntityForName:@"Student" inManagedObjectContext:self.managedObjectContext];
    stu.name = self.textName.text;
    stu.id = [NSNumber numberWithInt:[self.textId.text intValue]];
    
    NSFetchRequest *fetch = [NSFetchRequest fetchRequestWithEntityName:@"Classes"];
    int selectIndex = self.textClasses.selectedSegmentIndex;
    NSArray *array = @[@"数学课",@"语文课",@"英语课",@"体育课"];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"name = %@",array[selectIndex]];
    [fetch setPredicate:predicate];
    __autoreleasing NSError *error = nil;
    NSArray *classes = [self.managedObjectContext executeFetchRequest:fetch error:&error];
    if(error){
        NSLog(@"抓取课程失败:%@" , error);
    }else{
        Classes *cla = [classes lastObject];
        [cla addStudentsObject:stu];
         __autoreleasing NSError *saveError = nil;
        [self.managedObjectContext save:&saveError];
        if(saveError){
            NSLog(@"添加学生失败:%@",saveError);
        }
    }
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}

@end
