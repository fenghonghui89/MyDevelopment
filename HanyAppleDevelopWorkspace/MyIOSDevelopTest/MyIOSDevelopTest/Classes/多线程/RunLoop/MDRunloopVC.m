//
//  MDRunloopVC
//  XTJMall
//
//  Created by hanyfeng on 2019/6/17.
//  Copyright © 2019 hanyfeng. All rights reserved.
//

#import "MDRunloopVC.h"

#import "BJRunLoopHelper.h"
@interface MDRunloopVC ()
@property(nonatomic,strong)BJRunLoopHelper *helper;
@property(nonatomic,strong)NSThread *thread;
@end

@implementation MDRunloopVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self runloop_test];
    //    [self test1];
}

#pragma mark - test
-(void)runloop_test{
    BJRunLoopHelper *helper = [BJRunLoopHelper new];
    [helper start];
    self.helper = helper;
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.helper processSubThread];
    
    //    [self test11];
}

#pragma mark - test
-(void)test1{
    NSThread *thread = [[NSThread alloc] initWithTarget:self selector:@selector(ttt) object:nil];
    thread.name = @"1号线程";
    [thread start];
    self.thread = thread;
}

-(void)ttt{
    @autoreleasepool {
        NSRunLoop *rl = [NSRunLoop currentRunLoop];
        [rl addPort:[NSMachPort port] forMode:NSDefaultRunLoopMode];
        [rl run];
        
        //        [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(createView) userInfo:nil repeats:YES];
        //        [[NSRunLoop currentRunLoop] run];
    }
}

-(void)test11{
    [self performSelector:@selector(createView) onThread:self.thread withObject:nil waitUntilDone:NO];
}

-(void)createView{
    
    NSLog(@"线程名：%@",[NSThread currentThread].name);
    
    for (int i = 0; i<5; i++) {
        [NSThread sleepForTimeInterval:1];
        
        //回到主线程执行 waitUntilDone-是否等待主线程执行完再执行
        [self performSelectorOnMainThread:@selector(updateUI) withObject:nil waitUntilDone:NO];
    }
}

-(void)updateUI{
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(arc4random()%300+50, arc4random()%300+50, 20, 20)];
    [view setBackgroundColor:[UIColor randomColor]];
    
    [self.view addSubview:view];
}

@end
