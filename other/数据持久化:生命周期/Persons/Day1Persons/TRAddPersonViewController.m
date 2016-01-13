//
//  TRAddPersonViewController.m
//  Day1Persons
//
//  Created by Tarena on 13-12-2.
//  Copyright (c) 2013年 Tarena. All rights reserved.
//

#import "TRAddPersonViewController.h"

@interface TRAddPersonViewController ()


@end

@implementation TRAddPersonViewController

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
    //如果属性有值，则把页面改为修改页面，否则为增加页面
    if (self.persons) {
        TRPerson *editPerson = [self.persons objectAtIndex:self.row];
        self.nameTF.text = editPerson.name;
        self.ageTF.text = [NSString stringWithFormat:@"%d",editPerson.age];
        [self.button setTitle:@"修改" forState:UIControlStateNormal];
    }else{
        [self.button setTitle:@"增加" forState:UIControlStateNormal];
    }
}

//按钮
- (IBAction)clicked:(id)sender {
    //修改
    if (self.persons) {
        TRPerson *editPerson = [self.persons objectAtIndex:self.row];//取出数组中的对应元素进行修改
        editPerson.name = self.nameTF.text;
        editPerson.age = [self.ageTF.text intValue];
        [self savePersons:self.persons];//把修改后的数组保存到文件中
    }
    
    //新增
    else{
        NSData *personsData =[NSData dataWithContentsOfFile:@"/Users/hanyfeng/Desktop/personsData"];
        NSMutableArray *newPersons = [NSMutableArray array];
        //如果存储文件存在，则提取数组，并加入到新数组中
        if (personsData) {
            NSKeyedUnarchiver *unArch = [[NSKeyedUnarchiver alloc]initForReadingWithData:personsData];
            NSArray *persons = [unArch decodeObjectForKey:@"persons"];
            [newPersons addObjectsFromArray:persons];
        }
        
        //新建对象并放入到新数组中
        TRPerson *p = [[TRPerson alloc]init];
        p.name = self.nameTF.text;
        p.age = [self.ageTF.text intValue];
        [newPersons addObject:p];
        
        //归档，把新数组放入到存储文件中
        [self savePersons:newPersons];
    }
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

//保存数组到文件
-(void)savePersons:(NSMutableArray*)persons
{
    NSMutableData *data = [NSMutableData data];
    NSKeyedArchiver *arch = [[NSKeyedArchiver alloc]initForWritingWithMutableData:data];
    [arch encodeObject:persons forKey:@"persons"];
    [arch finishEncoding];
    [data writeToFile:@"/Users/hanyfeng/Desktop/personsData" atomically:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
