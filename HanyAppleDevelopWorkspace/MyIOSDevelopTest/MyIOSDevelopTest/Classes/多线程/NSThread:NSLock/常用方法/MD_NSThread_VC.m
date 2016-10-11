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

#pragma mark - < vc lifecycle > -

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

#pragma mark - < method > -
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

#pragma mark - 卖票问题(线程同步 加锁)
#pragma mark 线程加锁方法1 NSLock（也可以用其子类代替）
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
  //  thread2.threadPriority = 1;//优先级0~1
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

#pragma mark 线程加锁方法2 @synchronized
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

#pragma mark 线程加锁方法3 NSCondition 信号控制
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

#pragma mark 线程加锁方法4 NSConditionLock 条件锁
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

#pragma mark NSRecursiveLock 递归锁
-(void)test_NSRecursiveLock{

//  NSLock *lock = [NSLock new];//会死锁
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

#pragma mark - < action > -
- (IBAction)btn1Tap:(id)sender {
  
  [self.thread1 cancel];
  [self.thread2 cancel];
}

@end
