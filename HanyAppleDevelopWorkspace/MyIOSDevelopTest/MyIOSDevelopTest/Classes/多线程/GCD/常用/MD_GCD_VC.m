//
//  MD_GCD_VC.m
//  MyDevelopmentTest
//
//  Created by 冯鸿辉 on 16/4/12.
//  Copyright © 2016年 hanyfeng. All rights reserved.
//

#import "MD_GCD_VC.h"

@interface MD_GCD_VC ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIImageView *imageView1;
@property (nonatomic,assign)BOOL needStop;
@end

@implementation MD_GCD_VC

#pragma mark - < vc lifecycle > -
- (void)viewDidLoad {
  [super viewDidLoad];
  
}

-(void)viewDidAppear:(BOOL)animated{

  [super viewDidAppear:animated];
  [self test_barrier];
}

-(void)viewDidDisappear:(BOOL)animated{

  self.needStop = YES;
  [super viewDidDisappear:animated];
}
#pragma mark - < method > -

#pragma mark - 开启子线程下载图片 返回主线程显示
-(void)test_downloalImg{

  dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
    NSURL *url = [NSURL URLWithString:@"http://www.sinaimg.cn/home/2016/0412/U6939P30DT20160412105616.jpg"];
    NSData *data = [NSData dataWithContentsOfURL:url];
    UIImage *img = [UIImage imageWithData:data];
    
    dispatch_async(dispatch_get_main_queue(), ^{
      self.imageView.image = img;
    });
  });
  
}

#pragma mark - 不同队列下的异步执行
-(void)test_concurrentBlock{

  /*
   不管是同步队列还是异步队列，dispatch_async提交block后都会马上返回，都不会阻塞线程
   同步队列会执行完一个再执行下一个
   异步队列下都是同时执行
   */
  
  dispatch_queue_t serialQueue = dispatch_queue_create("com.myqueue.serialQueue", DISPATCH_QUEUE_SERIAL);
  dispatch_queue_t concurrentQueue = dispatch_queue_create("com.myqueue.concurrentQueue", DISPATCH_QUEUE_CONCURRENT);
  
  dispatch_async(concurrentQueue, ^{
    
    sleep(3);
    
    NSURL *url = [NSURL URLWithString:@"http://www.sinaimg.cn/home/2016/0412/U6939P30DT20160412105616.jpg"];
    NSData *data = [NSData dataWithContentsOfURL:url];
    UIImage *img = [UIImage imageWithData:data];
    
    dispatch_async(dispatch_get_main_queue(), ^{
      self.imageView.image = img;
    });
  });

  dispatch_async(concurrentQueue, ^{
    
    sleep(3);
    
    NSURL *url = [NSURL URLWithString:@"http://www.sinaimg.cn/home/2016/0412/U6939P30DT20160412105616.jpg"];
    NSData *data = [NSData dataWithContentsOfURL:url];
    UIImage *img = [UIImage imageWithData:data];
    
    dispatch_async(dispatch_get_main_queue(), ^{
      self.imageView1.image = img;
    });
  });
}

#pragma mark - 不同队列下的同步执行
-(void)test_serialBlock{
  
  /*
   不管是同步队列还是异步队列，dispatch_sync提交block后都要等block执行完才返回，都阻塞线程，如果在主线程调用就会阻塞程序
   */
  dispatch_queue_t serialQueue = dispatch_queue_create("com.myqueue.serialQueue", DISPATCH_QUEUE_SERIAL);
  dispatch_queue_t concurrentQueue = dispatch_queue_create("com.myqueue.concurrentQueue", DISPATCH_QUEUE_CONCURRENT);
  
  dispatch_sync(concurrentQueue, ^{
    sleep(3);
    NSLog(@"1111111");
  });
  
  dispatch_sync(concurrentQueue, ^{
    sleep(3);
    NSLog(@"22222222");
  });
}

#pragma mark - 死锁
-(void)test_deadLock{
  
  dispatch_queue_t serialQueue = dispatch_queue_create("com.myqueue.serialQueue", DISPATCH_QUEUE_SERIAL);
  dispatch_queue_t concurrentQueue = dispatch_queue_create("com.myqueue.concurrentQueue", DISPATCH_QUEUE_CONCURRENT);
  
  
  //不会死锁
//  dispatch_async(serialQueue, ^{
//    NSLog(@"4");
//    dispatch_sync(concurrentQueue, ^{
//      sleep(3);
//      NSLog(@"5");
//    });
//    NSLog(@"6");
//  });//4 3sec 5 6
  
  //不会死锁
//  dispatch_async(concurrentQueue, ^{
//    NSLog(@"4");
//    dispatch_sync(serialQueue, ^{
//      sleep(3);
//      NSLog(@"5");
//    });
//    NSLog(@"6");
//  });//4 3sec 5 6
  
  //不会死锁
//  dispatch_async(concurrentQueue, ^{
//    NSLog(@"4");
//    dispatch_sync(concurrentQueue, ^{
//      sleep(3);
//      NSLog(@"5");
//    });
//    NSLog(@"6");
//  });//4 3sec 5 6
  
  //死锁 (5等待6 6等待5)
  dispatch_async(serialQueue, ^{
    NSLog(@"4");
    dispatch_sync(serialQueue, ^{
      sleep(3);
      NSLog(@"5");
    });
    NSLog(@"6");
  });//4
  
}

#pragma mark - 卖票问题
-(void)test_saleTickets{

  static NSInteger ticket = 100;
  __block NSLock *lock = [[NSLock alloc] init];
  
  dispatch_queue_t myQueue = dispatch_queue_create("com.myQueue.test", DISPATCH_QUEUE_CONCURRENT);
  
  dispatch_async(myQueue, ^{
    while (YES) {
      
      if (self.needStop) {
        return ;
      }
      
      [lock lock];
      [NSThread sleepForTimeInterval:0.5];
      NSLog(@"1号子线程结束 %ld",(long)ticket);
      ticket--;
      [lock unlock];
    }
  });
  
  dispatch_async(myQueue, ^{
    while (YES) {
      
      if (self.needStop) {
        return ;
      }
      
      [lock lock];
      [NSThread sleepForTimeInterval:0.5];
      NSLog(@"2号子线程结束 %ld",(long)ticket);
      ticket--;
      [lock unlock];
    }
  });
  
  dispatch_async(myQueue, ^{
    while (YES) {
      
      if (self.needStop) {
        return ;
      }
      
      [lock lock];
      [NSThread sleepForTimeInterval:0.5];
      NSLog(@"3号子线程结束 %ld",(long)ticket);
      ticket--;
      [lock unlock];
    }
  });
  
}

#pragma mark - dispatch_apply
/*
 如果循环里面执行的代码相互独立，可以用dispatch_apply结合并行线程队列，提高效能
 size_t：一种用来记录大小的“整形”数据类型，sizeof(xxx)返回的就是size_t 这里相当于当前循环次数
 dispatch_apply和普通for循环一样，执行完才会返回，所以会阻塞进程
 正确使用方法：为了不阻塞主线程，一般把dispatch_apply放在异步队列中调用，然后执行完成后通知主线程
 */
-(void)test_apply{

  __block int sum = 0;
  __block int p = 3;
  int count = 5;//执行次数
  
  dispatch_queue_t myQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
  dispatch_apply(count, myQueue, ^(size_t i){
    sum += p;
    NSLog(@"current sum:%d index:%zu %d",sum,i,count);
  });
  
  NSLog(@"sum:%d",sum);

}

#pragma mark - dispatch_after / dispatch_time_t
/*
 不是一定时间后执行相应的任务，而是一定时间后，将执行的操作加入到队列中（队列里面再分配执行的时间）
 */
-(void)test_delay{

  dispatch_time_t time = dispatch_time(DISPATCH_TIME_NOW, NSEC_PER_SEC*2);
  dispatch_queue_t myQueue = dispatch_queue_create("com.myQueue.test",DISPATCH_QUEUE_SERIAL);
  dispatch_after(time, myQueue, ^{
    NSLog(@"执行了子线程代码");
  });
}


#pragma mark - dispatch_barrier_async
/*
 必须为dispatch_queue_t创建的并行队列才有效，其他队列相当于dispatch_async
 */
-(void)test_barrier{

  dispatch_queue_t queue = dispatch_queue_create("com.queue.test", DISPATCH_QUEUE_CONCURRENT);
  
  dispatch_async(queue, ^{
    NSLog(@"1");
  });
  
  dispatch_async(queue, ^{
    NSLog(@"2");
  });
  
  dispatch_barrier_async(queue, ^{
    NSLog(@"dispatch_barrier_async");
  });
  
  dispatch_async(queue, ^{
    NSLog(@"3");
  });
  
  dispatch_async(queue, ^{
    NSLog(@"4");
  });
}

#pragma mark - dispatch_async_f
-(void)test_async_f{

  dispatch_queue_t queue = dispatch_queue_create("com.queue.test", DISPATCH_QUEUE_CONCURRENT);
  
  dispatch_async_f(queue, @"111", msg1);
  dispatch_async_f(queue, @"222", msg2);
  dispatch_async_f(queue, @"333", msg3);
}

void msg1(){
  sleep(2);
  NSLog(@"msg1");
}

void msg2(){
  sleep(2);
  NSLog(@"msg2");
}

void msg3(){
  sleep(2);
  NSLog(@"msg3");
}

#pragma mark - dispatch_suspend / dispatch_resume
-(void)test_dispatch_suspend{

  dispatch_queue_t queue = dispatch_queue_create("com.queue.test", DISPATCH_QUEUE_CONCURRENT);
  dispatch_async(queue, ^{
    for (int i = 0; i<10; i++) {
      if (i == 5) {
        dispatch_suspend(queue);
        sleep(3);
        NSLog(@"特殊处理");
        dispatch_resume(queue);
      }
      NSLog(@"i:%d",i);
    }
  });
}

#pragma mark - dispatch_semaphore_t
/*
 信号量>0 就不会阻塞
 dispatch_semaphore_wait注意time的选择
 */
-(void)test_dispatch_semaphore_t{

  dispatch_queue_t queue = dispatch_queue_create("com.queue.abc", DISPATCH_QUEUE_CONCURRENT);
  dispatch_semaphore_t sema = dispatch_semaphore_create(0);
  
  dispatch_async(queue, ^{
    NSLog(@"下载中");
    sleep(3);
    dispatch_semaphore_signal(sema);
  });
  
  dispatch_semaphore_wait(sema, DISPATCH_TIME_FOREVER);//用DISPATCH_TIME_NOW会起不到等待效果
  dispatch_async(queue, ^{
    NSLog(@"下载完成");
  });
  

  //每2秒输出异步10个数字
//  dispatch_semaphore_t semaphore = dispatch_semaphore_create(10);//为了让一次输出10个，初始信号量为10；
//  dispatch_queue_t queue = dispatch_queue_create("com.queue.abc", DISPATCH_QUEUE_CONCURRENT);
//  
//  for (int i = 0; i <100; i++){
//    dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);//每进来1次，信号量-1;进来10次后就一直hold住，直到信号量大于0；
//    dispatch_async(queue, ^{
//      NSLog(@"%i",i);
//      sleep(2);
//      dispatch_semaphore_signal(semaphore);
//    });
//  }
  
}
#pragma mark - < action > -
- (IBAction)btn1Tap:(id)sender {
  self.needStop = YES;
}

@end
