//
//  MD_NSThread_VC.m
//  MyDevelopmentTest
//
//  Created by 冯鸿辉 on 16/4/8.
//  Copyright © 2016年 hanyfeng. All rights reserved.
//

#import "MD_NSThread_VC.h"
#import "MDCustomThread.h"

@interface MD_NSThread_VC()
@property(nonatomic,strong)UIButton *btn;
@property(nonatomic,strong)NSLock *lock;
@property(nonatomic,strong)NSConditionLock *conditionLock;
@property(nonatomic,strong)NSRecursiveLock *recursiveLock;
@property(nonatomic,strong)NSCondition *condition;
@property(nonatomic,assign)NSInteger ticket;
@property(nonatomic,strong)NSThread *thread1;
@property(nonatomic,strong)NSThread *thread2;
@end


@implementation MD_NSThread_VC



-(void)viewDidLoad{
  
  [super viewDidLoad];
  
  
}

-(void)viewDidAppear:(BOOL)animated{
  
  [super viewDidAppear:animated];
  
  [self test_NSRecursiveLock];
  
}

-(void)viewDidDisappear:(BOOL)animated{

  [self.thread1 cancel];
  [self.thread2 cancel];
  
  [super viewDidDisappear:animated];
}

#pragma mark - 方法和属性
-(void)test_NSThreadBase{

  if ([NSThread isMainThread]) {
    NSLog(@"isMainThread");
  }
  
  if ([NSThread isMultiThreaded]) {
    NSLog(@"isMultiThreaded");
  }
  
  NSArray *arrAddresses = [NSThread callStackReturnAddresses];
  NSArray *arrSymbols = [NSThread callStackSymbols];
  NSLog(@"arrAddresses:%@",arrAddresses);
  NSLog(@"arrSymbols:%@",arrSymbols);
  
  NSInteger stackSize = [[NSThread currentThread] stackSize];
  NSLog(@"stackSize:%ld",(long)stackSize);
  
  [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notiAction:) name:NSThreadWillExitNotification object:nil];
  [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notiAction:) name:NSDidBecomeSingleThreadedNotification object:nil];
  [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notiAction:) name:NSWillBecomeMultiThreadedNotification object:nil];
  
}

-(void)notiAction:(NSNotification *)noti{
  
  NSLog(@"~~~%@ %@",noti.name,[NSThread currentThread].name);
}
#pragma mark - 创建子线程 返回主线程
-(void)test_createThread{

  //创建子线程并开始
//  [NSThread detachNewThreadSelector:@selector(createView:) toTarget:self withObject:@"创建view"];
  
  //创建子线程 手动开始
//  NSThread *thread = [[NSThread alloc] initWithTarget:self selector:@selector(createView:) object:@"创建view"];
//  thread.name = @"1号线程";
//  [thread start];
  
  //自定义NSThread子类
  MDCustomThread *customThread = [[MDCustomThread alloc] init];
  [customThread start];
}

-(void)createView:(NSString *)object{
  
  NSLog(@"线程名：%@",[NSThread currentThread].name);
  
  if ([object isEqualToString:@"创建view"]) {
    for (int i = 0; i<5; i++) {
      [NSThread sleepForTimeInterval:1];
      UIView *view = [[UIView alloc] initWithFrame:CGRectMake(i*50, 200, 20, 20)];
      [view setBackgroundColor:[UIColor blueColor]];
      
      //回到主线程执行 waitUntilDone-是否等待主线程执行完再执行
      [self performSelectorOnMainThread:@selector(updateUI:) withObject:view waitUntilDone:NO];
    }
  }
}

-(void)updateUI:(UIView *)view{
  
  [self.view addSubview:view];
}


#pragma mark - 各种锁的性能总结
/*
 OSSpinLock                          0.097348s
 dispatch_semaphore                  0.155043s
 os_unfair_lock互斥锁                 0.171789s
 pthread_mutex                       0.262592s
 NSLock                              0.283196s
 pthread_mutex(recursive)            0.372398s
 NSRecursiveLock                     0.473536s
 NSConditionLock                     0.950285s
 @synchronized                       1.101924s
 注:建议正常锁功能用 pthread_mutex ,os_unfair_lock (适配低版本)
 */
#pragma mark - trylock和lock
/*
 当前线程锁失败，也可以继续其它任务，用 trylock 合适
 当前线程只有锁成功后，才会做一些有意义的工作，那就 lock，没必要轮询 trylock
 */

#pragma mark - 线程加锁方法1 NSLock互斥锁（也可以用其子类代替）
/*
 NSLock 封装的pthread_mutex的PTHREAD_MUTEX_NORMAL 模式
 NSRecursiveLock 封装的pthread_mutex的PTHREAD_MUTEX_RECURSIVE 模式
 */
-(void)test_saleTickets1{
  
#pragma 锁 资源
  self.lock = [[NSLock alloc] init];
  self.ticket = 100;
  
#pragma 线程
  NSThread *thread1 = [[NSThread alloc] initWithTarget:self selector:@selector(sale1) object:nil];
  thread1.name = @"1号窗口";
  [thread1 start];
  self.thread1 = thread1;
  
  NSThread *thread2 = [[NSThread alloc] initWithTarget:self selector:@selector(sale1) object:nil];
  thread2.name = @"2号窗口";
  thread2.qualityOfService = NSQualityOfServiceUserInitiated;//不久之后会替代前者
  [thread2 start];
  self.thread2 = thread2;
}

-(void)sale1{

  while (YES) {
    
    NSLog(@"%@窗口开门了~",[NSThread currentThread].name);
    
    if ([[NSThread currentThread] isCancelled]) {
      NSLog(@"return:%@",[NSThread currentThread].name);
      //[NSThread exit];
      return;//return也可以退出线程
    }
    
    
    if ([self.lock tryLock] == YES) {
      NSLog(@"%@窗口开始卖%ld号票",[NSThread currentThread].name,(long)self.ticket);
      self.ticket--;
      sleep(1);
      [self.lock unlock];
    }else{
      NSLog(@"锁不了 %@",[NSThread currentThread].name);
    }
    
    
    
    NSLog(@"%@窗口卖完，重新准备",[NSThread currentThread].name);
  }
  
}

#pragma mark - 线程加锁方法2 @synchronized递归锁
/*
 @synchronized 指令使用的 obj 为该锁的唯一标识，只有当标识相同时，才为满足互斥，如果线程2中的@synchronized(obj) 改为@synchronized(other) 时，线程2就不会被阻塞，@synchronized 指令实现锁的优点就是我们不需要在代码中显式的创建锁对象，便可以实现锁的机制，但作为一种预防措施，@synchronized 块会隐式的添加一个异常处理例程来保护代码，该处理例程会在异常抛出的时候自动的释放互斥锁。所以如果不想让隐式的异常处理例程带来额外的开销，你可以考虑使用锁对象。
 
 底层封装的pthread_mutex的PTHREAD_MUTEX_RECURSIVE 模式,
 锁对象来表示是否为同一把锁
 */
-(void)test_saleTickets2{
  
#pragma 锁 资源
  self.btn = [[UIButton alloc] init];
  self.ticket = 100;
  
#pragma 线程
  NSThread *thread1 = [[NSThread alloc] initWithTarget:self selector:@selector(sale2) object:nil];
  thread1.name = @"1号窗口";
  [thread1 start];
  self.thread1 = thread1;
  
  NSThread *thread2 = [[NSThread alloc] initWithTarget:self selector:@selector(sale2) object:nil];
  thread2.name = @"2号窗口";
  thread2.qualityOfService = NSQualityOfServiceUserInitiated;
  [thread2 start];
  self.thread2 = thread2;
}

-(void)sale2{

  while (YES) {
    
    if ([[NSThread currentThread] isCancelled]) {
      NSLog(@"return:%@",[NSThread currentThread].name);
      return;
    }
  
    @synchronized(self.btn){//必须是一个不会销毁的对象，不能是[NSObject new]之类
      NSLog(@"%@窗口开始卖%ld号票",[NSThread currentThread].name,(long)self.ticket);
      [NSThread sleepForTimeInterval:1];
      self.ticket--;
    }

  }
}

#pragma mark - 线程加锁方法3 NSCondition条件锁 信号控制
/*
 wait 进入等待状态
 waitUntilDate:让一个线程等待一定的时间
 signal 唤醒一个等待的线程
 broadcast 唤醒所有等待的线程
 注: 所测时间波动太大, 有时候会快于 NSLock, 我取得中间值.
 
 
 在一定条件下,让其等待休眠,并放开锁,等接收到信号或者广播,会从新唤起线程,并重新加锁.
 pthread_cond_wait(&_cond, &_mutex);
 // 信号
 pthread_cond_signal(&_cond);
 // 广播
 pthread_cond_broadcast(&_cond);
 
 像NSCondition封装了pthread_mutex的以上几个函数
 
 
 当我们在使用多线程的时候，有时一把只会 lock 和 unlock 的锁未必就能完全满足我们的使用。因为普通的锁只能关心锁与不锁，而不在乎用什么钥匙才能开锁，而我们在处理资源共享的时候，多数情况是只有满足一定条件的情况下才能打开这把锁
 
 */
-(void)test_saleTickets3{
  
#pragma 锁 资源
  self.condition = [[NSCondition alloc] init];
  self.lock = [[NSLock alloc] init];
  self.ticket = 100;
  
#pragma 线程
  NSThread *thread1 = [[NSThread alloc] initWithTarget:self selector:@selector(sale3) object:nil];
  thread1.name = @"1号窗口";
  [thread1 start];
  self.thread1 = thread1;
  
  NSThread *thread2 = [[NSThread alloc] initWithTarget:self selector:@selector(sale3) object:nil];
  thread2.name = @"2号窗口";
  //  thread2.threadPriority = 1;//优先级0~1
  thread2.qualityOfService = NSQualityOfServiceUserInitiated;//不久之后会替代前者
  [thread2 start];
  self.thread2 = thread2;
  
  NSThread *thread3 = [[NSThread alloc] initWithTarget:self selector:@selector(switchOnOff) object:nil];
  thread3.name = @"开关";
  [thread3 start];
}

-(void)switchOnOff{
  
  while (YES) {
    [self.condition lock];
    [NSThread sleepForTimeInterval:1];
    [self.condition signal];//发送信号
    [self.condition unlock];
  }
  
}

-(void)sale3{

  [self.condition wait];//等待信号
  
  while (YES) {
    
    if ([[NSThread currentThread] isCancelled]) {
      NSLog(@"return:%@",[NSThread currentThread].name);
      return;
    }

    [self.lock lock];
    NSLog(@"%@窗口开始卖%ld号票",[NSThread currentThread].name,(long)self.ticket);
    sleep(1);
    self.ticket--;
    [self.lock unlock];
  }

}

#pragma mark - 线程加锁方法4 NSConditionLock条件锁
/*
 NSConditionLock封装了NSCondition
 */
-(void)test_saleTickets4{
  
#pragma 锁 资源
  self.conditionLock = [[NSConditionLock alloc] initWithCondition:1];
  self.ticket = 100;
  
#pragma 线程
  NSThread *thread1 = [[NSThread alloc] initWithTarget:self selector:@selector(sale4_1) object:nil];
  thread1.name = @"1号窗口";
  [thread1 start];
  self.thread1 = thread1;
  
  NSThread *thread2 = [[NSThread alloc] initWithTarget:self selector:@selector(sale4_2) object:nil];
  thread2.name = @"2号窗口";
  thread2.qualityOfService = NSQualityOfServiceUserInitiated;
  [thread2 start];
  self.thread2 = thread2;
}

-(void)sale4_1{
  
  while (YES) {
    
    if ([self.conditionLock tryLockWhenCondition:1]) {
      NSLog(@"1号窗口开始卖%ld号票",(long)self.ticket);
      sleep(1);
      self.ticket--;
      [self.conditionLock unlockWithCondition:2];
    }
    
    //或者
//    [self.conditionLock lockWhenCondition:1];
//    NSLog(@"1号窗口开始卖%ld号票",(long)self.ticket);
//    sleep(1);
//    self.ticket--;
//    [self.conditionLock unlockWithCondition:2];
  }
}

-(void)sale4_2{
  
  while (YES) {
    
    [self.conditionLock lockWhenCondition:2];
    NSLog(@"2号窗口开始卖%ld号票",(long)self.ticket);
    sleep(1);
    self.ticket--;
    [self.conditionLock unlockWithCondition:1];
  }
}

#pragma mark - NSRecursiveLock 递归锁
/*
 注: 递归锁可以被同一线程多次请求，而不会引起死锁。
 即在同一线程中在未解锁之前还可以上锁, 执行锁中的代码。
 这主要是用在循环或递归操作中。
 
 递归锁的主要意思是,同一条线程可以加多把锁.什么意思呢,就是相同的线程访问一段代码,
 如果是加锁的可以继续加锁,继续往下走,不同线程来访问这段代码时,发现有锁要等待所有锁解开之后才可以继续往下走.
 NSRecursiveLock 类定义的锁可以在同一线程多次 lock，而不会造成死锁。递归锁会跟踪它被多少次 lock。每次成功的 lock 都必须平衡调用 unlock 操作。只有所有的锁住和解锁操作都平衡的时候，锁才真正被释放给其他线程获得。
 
 NSLock 封装的pthread_mutex的PTHREAD_MUTEX_NORMAL 模式
 NSRecursiveLock 封装的pthread_mutex的PTHREAD_MUTEX_RECURSIVE 模式
 */
-(void)test_NSRecursiveLock{

//  NSLock *lock = [NSLock new];//NSLock在递归场景会出现死锁的情况，这里就得用NSRecursiveLock（递归锁）
  NSRecursiveLock *lock = [NSRecursiveLock new];
  
  static void(^myBlock)(int);//static修饰的变量 可以在block里面修改 哪怕这个变量是个block指针
  myBlock = ^(int value){
    [lock lock];
    if (value > 0) {
      NSLog(@"value :%d",value);
      sleep(1);
      myBlock(value-1);
    }
    [lock unlock];
    NSLog(@"解锁");
  };
  
  myBlock(5);
  
  //结果：5 4 3 2 1 解锁 解锁 解锁 解锁 解锁
}
#pragma mark - NSObject扩展方法
-(void)test_NSObjectExpand{

  [self performSelectorInBackground:@selector(backgroundAction) withObject:[NSNumber numberWithBool:YES]];//退出页面后无法暂停？
}

-(void)backgroundAction{

  for (int i = 0; i<100; i++) {
    NSLog(@"i:%d",i);
    [NSThread sleepForTimeInterval:0.5];
  }
  
}

#pragma mark - action
- (IBAction)btn1Tap:(id)sender {
  
  [self.thread1 cancel];
  [self.thread2 cancel];
}

@end
