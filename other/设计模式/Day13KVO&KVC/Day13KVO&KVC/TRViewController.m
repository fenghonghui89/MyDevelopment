//
//  TRViewController.m
//  Day13KVO&KVC
//
//  Created by Tarena on 13-12-18.
//  Copyright (c) 2013年 Tarena. All rights reserved.
//

#import "TRViewController.h"
#import "TRPerson.h"

@interface TRViewController ()
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (nonatomic, strong)TRPerson *person;
@end

@implementation TRViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    self.person = [[TRPerson alloc]init];
    
//********************KVC**********

    // 通过key value的形式赋值
    [self.person setValue:@"张三" forKey:@"name"];
    [self.person setValue:[NSNumber numberWithInt:20] forKey:@"age"];
    
    // 通过key value的形式取值
    NSString *name = [self.person valueForKey:@"name"];
    NSNumber *age = [self.person valueForKey:@"age"];
    NSLog(@"name = %@  age = %@",name,age);

    self.nameLabel.text = self.person.name;
    
//********************KVO*******************
    
    //添加监听
    [self.person addObserver:self forKeyPath:@"name" options:NSKeyValueObservingOptionNew context:@"aaa"];
    [self.person addObserver:self forKeyPath:@"age" options:NSKeyValueObservingOptionNew context:NULL];

}

//按钮
- (IBAction)clicked:(id)sender {
    self.person.name = @"李四";//修改对象的属性（注意没有修改label的text）
    //self.nameLabel.text = self.p.name;//以往不用KVO的方式
}

//当监听响应的时候会调用此方法
-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context{
    
    NSLog(@"\n名字发生改变\n object = %@\n context = %@\n change = %@\n",object,context,change);
    
    //如果监听多个值，每个值变化时都会进入到该方法，要用if语句比较key进行区分
    if ([keyPath isEqualToString:@"name"]) {
        self.nameLabel.text = self.person.name;
    }else if ([keyPath isEqualToString:@"age"]){
        
    }
}

-(void)dealloc{
    //如果添加了监听 并且监听添加一次 那删除监听一定也要执行一次 才能保证内存不泄露
    [self.person removeObserver:self forKeyPath:@"name"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
