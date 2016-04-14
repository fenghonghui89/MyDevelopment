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
@property (nonatomic,strong)dispatch_queue_t queue;
@end

@implementation MD_GCD_VC

#pragma mark - < vc lifecycle > -
- (void)viewDidLoad {
  [super viewDidLoad];
  
}

-(void)viewDidAppear:(BOOL)animated{

  [super viewDidAppear:animated];
  [self test_serialBlock];
}

-(void)viewDidDisappear:(BOOL)animated{

  [super viewDidDisappear:animated];
}
#pragma mark - < method > -

#pragma mark 开启子线程下载图片 返回主线程显示
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

#pragma mark 不同队列下的异步执行
-(void)test_concurrentBlock{

  /*
   不管是同步队列还是异步队列，dispatch_async都会马上返回，都不会阻塞线程
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

#pragma mark 不同队列下的同步执行
-(void)test_serialBlock{
  
  /*
   不管是同步队列还是异步队列，执行完才返回，都阻塞线程，如果在主线程调用就会阻塞程序
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

#pragma mark 死锁
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
  
  //死锁
  dispatch_async(serialQueue, ^{
    NSLog(@"4");
    dispatch_sync(serialQueue, ^{
      sleep(3);
      NSLog(@"5");
    });
    NSLog(@"6");
  });//4
  
}

#pragma mark 卖票问题(要用并行队列，暂未解决停止问题)
-(void)test_saleTickets{

  static NSInteger ticket = 100;
  __block NSLock *lock = [[NSLock alloc] init];
  
  dispatch_queue_t myQueue = dispatch_queue_create("com.myQueue.test", DISPATCH_QUEUE_CONCURRENT);
  self.queue = myQueue;
  
  dispatch_async(myQueue, ^{
    while (YES) {
      [lock lock];
      [NSThread sleepForTimeInterval:0.5];
      NSLog(@"1号子线程结束 %ld",(long)ticket);
      ticket--;
      [lock unlock];
    }
  });
  
  dispatch_async(myQueue, ^{
    while (YES) {
      [lock lock];
      [NSThread sleepForTimeInterval:0.5];
      NSLog(@"2号子线程结束 %ld",(long)ticket);
      ticket--;
      [lock unlock];
    }
  });
  
  dispatch_async(myQueue, ^{
    while (YES) {
      [lock lock];
      [NSThread sleepForTimeInterval:0.5];
      NSLog(@"3号子线程结束 %ld",(long)ticket);
      ticket--;
      [lock unlock];
    }
  });
  
}

#pragma mark dispatch_apply
/*
 如果循环里面执行的代码相互独立，可以用dispatch_apply结合并行线程队列，提高效能
 size_t：一种用来记录大小的“整形”数据类型，sizeof(xxx)返回的就是size_t 这里相当于循环次数
 dispatch_apply和普通for循环一样，执行完才会返回，所以会阻塞进程
 */
-(void)test_apply{

  __block int sum = 0;
  __block int p = 3;
  int count = 5;
  
  dispatch_queue_t myQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
  dispatch_apply(count, myQueue, ^(size_t i){
    sum += p;
    NSLog(@"current sum:%d index:%zu %d",sum,i,count);
  });
  
  NSLog(@"sum:%d",sum);

}

#pragma mark dispatch_after dispatch_time_t
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





#pragma mark - < action > -
- (IBAction)btn1Tap:(id)sender {
  
}

@end
