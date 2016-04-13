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
@property (nonatomic,strong)dispatch_queue_t queue;
@end

@implementation MD_GCD_VC

#pragma mark - < vc lifecycle > -
- (void)viewDidLoad {
  [super viewDidLoad];
  
}

-(void)viewDidAppear:(BOOL)animated{

  [super viewDidAppear:animated];
  [self test_saleTickets];
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

#pragma mark 自定义队列（DISPATCH_QUEUE_SERIAL串行 DISPATCH_QUEUE_CONCURRENT并行）
-(void)test_customQueue{

  dispatch_queue_t myQueue = dispatch_queue_create("com.myQueue.test", DISPATCH_QUEUE_SERIAL);
  
  dispatch_async(myQueue, ^{
    NSURL *url = [NSURL URLWithString:@"http://www.sinaimg.cn/home/2016/0412/U6939P30DT20160412105616.jpg"];
    NSData *data = [NSData dataWithContentsOfURL:url];
    UIImage *img = [UIImage imageWithData:data];
    
    dispatch_async(dispatch_get_main_queue(), ^{
      self.imageView.image = img;
    });
  });

}

#pragma mark 卖票问题(要用并行队列)
-(void)test_saleTickets{

  __block NSInteger ticket = 100;
  __block NSLock *lock = [NSLock new];
  
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
