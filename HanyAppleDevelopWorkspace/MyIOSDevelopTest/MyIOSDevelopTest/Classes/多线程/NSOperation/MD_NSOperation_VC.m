//
//  MD_NSOperation_VC.m
//  MyDevelopmentTest
//
//  Created by 冯鸿辉 on 16/4/11.
//  Copyright © 2016年 hanyfeng. All rights reserved.
//

#import "MD_NSOperation_VC.h"
#import "MyOperation.h"

@interface MD_NSOperation_VC ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property(nonatomic,assign)NSInteger tickets;
@property(nonatomic,strong)NSOperationQueue *queue;
@property(nonatomic,strong)NSOperation *op;
@end
@implementation MD_NSOperation_VC

#pragma mark - < vc lifecycle > -
-(void)viewDidLoad{

  [super viewDidLoad];
}

-(void)viewDidAppear:(BOOL)animated{

  [super viewDidAppear:animated];
  [self test_NSOperationQueue];
}

-(void)viewDidDisappear:(BOOL)animated{
  
  [self.queue cancelAllOperations];
  [super viewDidDisappear:animated];
}

#pragma mark - < method > -

#pragma mark - 创建NSOperationObject
-(void)test_NSOperationObject{

  //自定义NSOperation
//  MyOperation *op = [[MyOperation alloc] init];
//  op.completionBlock = ^(){
//    NSLog(@"main finish ~~");
//  };
//  [op start];
  
  //NSBlockOperation
//  NSBlockOperation *opBlock = [NSBlockOperation blockOperationWithBlock:^{
//    NSLog(@"this is opBlock");
//  }];
//  
//  for (int i = 0; i<5; i++) {
//    [opBlock addExecutionBlock:^{
//      NSLog(@"addExecutionBlock %d",i);
//    }];
//  }
//  
//  
//  [opBlock setCompletionBlock:^{
//    NSLog(@"opBlock finish");
//  }];
//  
//  [opBlock start];
//  
//  NSLog(@"executionBlocks:%@",opBlock.executionBlocks);
  
  //NSInvocationOperation
  NSInvocationOperation *iop = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(NSInvocationOperationAction) object:nil];
  iop.completionBlock = ^(){
    NSLog(@"iop finish");
  };
  [iop start];
}

-(void)NSInvocationOperationAction{
  NSLog(@"NSInvocationOperationAction");
}

#pragma mark - NSOperationQueue
-(void)test_NSOperationQueue{

  NSBlockOperation *op1 = [NSBlockOperation blockOperationWithBlock:^{
    NSLog(@"这里是子线程1代码 开始");
    [NSThread sleepForTimeInterval:1];
    NSLog(@"这里是子线程1代码 结束");
  }];
  
  NSBlockOperation *op2 = [NSBlockOperation blockOperationWithBlock:^{
    NSLog(@"这里是子线程2代码 开始");
    [NSThread sleepForTimeInterval:1];
    NSLog(@"这里是子线程2代码 结束");
  }];
  
  
  MyOperation *op3 = [[MyOperation alloc] init];

  NSOperationQueue *queue = [[NSOperationQueue alloc] init];
  queue.name = @"queue one";
  [queue setMaxConcurrentOperationCount:-1];//设置允许并发执行的线程数量 默认是-1 -1就是没有限制 大家一起来
  [queue addOperations:@[op1,op2,op3] waitUntilFinished:NO];//把子线程加入队列的同时 子线程开启(并非先加进去的先执行，速度不一定，可能主线程先开启或者某个子线程)
  [queue addOperationWithBlock:^{
    NSLog(@"这里是子线程4代码 开始");
    [NSThread sleepForTimeInterval:1];
    NSLog(@"这里是子线程4代码 结束");
  }];
  
  NSLog(@"这里是主线程 %d",queue.operationCount);
}

#pragma mark - 依赖关系 优先级
-(void)test_Dependency{
  
  /*
   1.首先看看NSOperation是否已经准备好：是否准备好由对象的依赖关系确定
   2.然后再根据所有NSOperation的相对优先级来确定。
   
   优先级不能替代依赖关系,优先级只是对已经准备好的 operations确定执行顺序。先满足依赖关系,然后再根据优先级从所有准备好的操作中选择优先级最高的那个执行。
   
   如果应用有多个operation queue,每个queue的优先级等级是互相独立的。
   
   不能添加相互依赖，会死锁，比如 A依赖B，B依赖A。
   
   可以在不同的队列之间依赖，反正就是这个依赖是添加到任务身上的，和队列没关系。
   */
  
  NSBlockOperation *op1 = [NSBlockOperation blockOperationWithBlock:^{
    NSLog(@"1号线程开始");
  }];
  op1.name = @"1号线程";
  [op1 setQueuePriority:NSOperationQueuePriorityHigh];
  [op1 setQualityOfService:NSQualityOfServiceDefault];

  NSBlockOperation *op2 = [NSBlockOperation blockOperationWithBlock:^{
    NSLog(@"2号线程开始");
  }];
  op2.name = @"2号线程";
  
  NSBlockOperation *op3 = [NSBlockOperation blockOperationWithBlock:^{
    NSLog(@"3号线程开始");
  }];
  op3.name = @"3号线程";
  
  NSBlockOperation *op4 = [NSBlockOperation blockOperationWithBlock:^{
    NSLog(@"2-4号线程开始");
  }];
  op4.name = @"2-4号线程";
  [op4 setQueuePriority:NSOperationQueuePriorityHigh];
  
  NSBlockOperation *op5 = [NSBlockOperation blockOperationWithBlock:^{
    NSLog(@"2-5号线程开始");
  }];
  op5.name = @"2-5号线程";
  
  [op1 addDependency:op2];
  [op1 addDependency:op3];
  [op2 addDependency:op4];
//  [op2 removeDependency:op4];
  
  NSOperationQueue *queue = [[NSOperationQueue alloc] init];
  [queue addOperations:@[op1,op2,op3] waitUntilFinished:NO];
  
  NSOperationQueue *queue1 = [[NSOperationQueue alloc] init];
  [queue1 addOperations:@[op4,op5] waitUntilFinished:NO];

  //输出某线程的依赖
  for (NSOperation *op in op1.dependencies) {
    NSLog(@"op1 dep:%@",op.name);
  }
}

#pragma mark - cancle
-(void)test_cancle{
  
  __block NSBlockOperation *op1 = [NSBlockOperation blockOperationWithBlock:^{
    while (YES) {
      if (op1.isCancelled) {
        return;
      }
      [NSThread sleepForTimeInterval:1];
      NSLog(@"1号线程 %d",op1.isCancelled);
    }
  }];
  self.op = op1;
  
  __block NSBlockOperation *op2 = [NSBlockOperation blockOperationWithBlock:^{
    while (YES) {
      if (op2.isCancelled) {
        return;
      }
      [NSThread sleepForTimeInterval:1];
      NSLog(@"2号线程 %d",op2.isCancelled);
    }
  }];
  
  __block NSBlockOperation *op3 = [NSBlockOperation blockOperationWithBlock:^{
    while (YES) {
      if (op3.isCancelled) {
        return;
      }
      [NSThread sleepForTimeInterval:1];
      NSLog(@"3号线程 %d",op3.isCancelled);
    }
  }];
  
  NSOperationQueue *queue = [[NSOperationQueue alloc] init];
  [queue addOperations:@[op1,op2,op3] waitUntilFinished:NO];
  self.queue = queue;
}

#pragma mark - waitUntilFinished
-(void)test_wait{

  NSBlockOperation *op1 = [NSBlockOperation blockOperationWithBlock:^{
    NSLog(@"1 op");
  }];
  [op1 setCompletionBlock:^{
    NSLog(@"1 finish");
  }];
  
  NSBlockOperation *op2 = [NSBlockOperation blockOperationWithBlock:^{
    [op1 waitUntilFinished];//会阻塞当前线程，等到某个operation执行完毕
    NSLog(@"2 op");
  }];
  
  NSBlockOperation *op3 = [NSBlockOperation blockOperationWithBlock:^{
    NSLog(@"3 op");
  }];
  [op3 setQueuePriority:NSOperationQueuePriorityHigh];
  
  NSOperationQueue *queue = [[NSOperationQueue alloc] init];
  [queue addOperation:op1];
  [queue addOperation:op2];
  [queue addOperation:op3];
  [queue waitUntilAllOperationsAreFinished];//阻塞当前线程，等待queue的所有操作执行完毕
  
  
  NSLog(@"主线程");
  
}

#pragma mark - 挂起
-(void)test_queueSuspended{
  
  NSBlockOperation *op1 = [NSBlockOperation blockOperationWithBlock:^{
    [NSThread sleepForTimeInterval:3];
    for (int i = 0; i<5; i++) {
      NSLog(@"1 op : %d",i);
    }
  }];
  [op1 setCompletionBlock:^{
    NSLog(@"1 finish");
  }];
  
  NSBlockOperation *op2 = [NSBlockOperation blockOperationWithBlock:^{
    [NSThread sleepForTimeInterval:3];
    for (int i = 0; i<5; i++) {
      NSLog(@"2 op : %d",i);
    }
  }];
  [op2 setCompletionBlock:^{
    NSLog(@"2 finish");
  }];
  
  NSBlockOperation *op3 = [NSBlockOperation blockOperationWithBlock:^{
    for (int i = 0; i<5; i++) {
      NSLog(@"3 op : %d",i);
    }
  }];
  [op3 setCompletionBlock:^{
    NSLog(@"3 finish");
  }];
  
  NSOperationQueue *queue = [[NSOperationQueue alloc] init];
  [queue setMaxConcurrentOperationCount:2];
  [queue addOperation:op1];
  [queue addOperation:op2];
  [queue addOperation:op3];
  self.queue = queue;
  
  //200ms后挂起，此时op3会被挂起，因为此时op3还没被加入到队列中（允许最大同时并行2个线程）
  [self execute:^{
    [queue setSuspended:YES];
  } afterDelay:NSEC_PER_MSEC * 200];
  
 
}

-(void)execute:(dispatch_block_t)block afterDelay:(NSInteger)delta{

  dispatch_after(dispatch_time(DISPATCH_TIME_NOW, delta), dispatch_get_main_queue(), block);
}

#pragma mark - test:下载图片 返回主线程显示
-(void)test_downLoad{
  
  __block UIImage *img = nil;
  NSBlockOperation *op = [NSBlockOperation blockOperationWithBlock:^{
    NSURL *url = [NSURL URLWithString:@"http://www.sinaimg.cn/home/2016/0412/U6939P30DT20160412105616.jpg"];
    NSData *data = [NSData dataWithContentsOfURL:url];
    img = [UIImage imageWithData:data];
  }];
  [op setCompletionBlock:^{
    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
      self.imageView.image = img;
    }];
  }];
  
  
  NSOperationQueue *queue = [[NSOperationQueue alloc] init];
  [queue addOperation:op];
  
}

#pragma mark - test:卖票
-(void)test_saleTickets{

  self.tickets = 100;
  NSLock *lock = [NSLock new];//实测
  
  __block NSBlockOperation *op1 = [NSBlockOperation blockOperationWithBlock:^{
    
    while (YES) {
      if (op1.isCancelled) {
        return ;
      }
      
      [lock lock];
      [NSThread sleepForTimeInterval:1];
      NSLog(@"1 sale %ld ticket",(long)self.tickets);
      self.tickets--;
      [lock unlock];
    }
    
  }];
  
  __block NSBlockOperation *op2 = [NSBlockOperation blockOperationWithBlock:^{
    
    while (YES) {
      if (op2.isCancelled) {
        return ;
      }
      
      [lock lock];
      [NSThread sleepForTimeInterval:1];
      NSLog(@"2 sale %ld ticket",(long)self.tickets);
      self.tickets--;
      [lock unlock];
    }
  
  }];
  
  NSOperationQueue *queue = [[NSOperationQueue alloc] init];
  [queue addOperations:@[op1,op2] waitUntilFinished:NO];
  self.queue = queue;
}

#pragma mark - < action > -

- (IBAction)btn1Tap:(id)sender {
  
//  [self.op cancel];
  [self.queue cancelAllOperations];
//  [self.queue setSuspended:NO];
  
}


@end
