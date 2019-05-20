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

#pragma mark - 创建线程
-(void)test_createQueue{
    
    //主队列的获取方法:主队列是串行队列，主队列中的任务都将在主线程中执行
    dispatch_queue_t mainqueue = dispatch_get_main_queue();
    
    //串行队列的创建方法:第一个参数表示队列的唯一标识,第二个参数用来识别是串行队列还是并发队列（若为NULL时，默认是DISPATCH_QUEUE_SERIAL）
    dispatch_queue_t seriaQueue = dispatch_queue_create("com.test.testQueue", DISPATCH_QUEUE_SERIAL);
    

    //串行队列的创建方法:第一个参数表示队列的唯一标识,第二个参数用来识别是串行队列还是并发队列（若为NULL时，默认是DISPATCH_QUEUE_SERIAL）
    dispatch_queue_t seriaQueue1 = dispatch_queue_create("com.test.testQueue", NULL);
    
    
    //并发队列的创建方法:第一个参数表示队列的唯一标识,第二个参数用来识别是串行队列还是并发队列（若为NULL时，默认是DISPATCH_QUEUE_SERIAL）
    dispatch_queue_t concurrentQueue = dispatch_queue_create("com.test.testQueue", DISPATCH_QUEUE_CONCURRENT);
    
    
    //全局并发队列的获取方法:第一个参数表示队列优先级,我们选择默认的好了,第二个参数flags作为保留字段备用,一般都直接填0
    dispatch_queue_t globalQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
}

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
   不管是串行队列还是并行队列，dispatch_async提交block后都会马上返回，都不会阻塞线程
   串行队列会执行完一个再执行下一个
   并行队列下都是同时执行
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
   不管是串行队列还是并行队列，dispatch_sync提交block后都要等block执行完才返回，都阻塞线程，如果在主线程调用就会阻塞程序
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

#pragma mark - 执行优先级 dispatch_set_target_queue
//使用dispatch_set_target_queue更改Dispatch Queue的执行优先级
-(void)testTargetQueue1{
    
    NSLog(@"----start-----当前线程---%@",[NSThread currentThread]);
    
    //串行队列的创建方法:第一个参数表示队列的唯一标识,第二个参数用来识别是串行队列还是并发队列（若为NULL时，默认是DISPATCH_QUEUE_SERIAL）
    dispatch_queue_t seriaQueue = dispatch_queue_create("com.test.testQueue", NULL);
    
    //指定一个任务
    dispatch_async(seriaQueue, ^{
        
        //这里线程暂停2秒,模拟一般的任务的耗时操作
        [NSThread sleepForTimeInterval:2];
        
        NSLog(@"----执行第一个任务---当前线程%@",[NSThread currentThread]);
    });
    
    //全局并发队列的获取方法:第一个参数表示队列优先级,我们选择默认的好了,第二个参数flags作为保留字段备用,一般都直接填0
    dispatch_queue_t globalQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    
    //指定一个任务
    dispatch_async(globalQueue, ^{
        
        //这里线程暂停2秒,模拟一般的任务的耗时操作
        [NSThread sleepForTimeInterval:2];
        
        NSLog(@"----执行第二个任务---当前线程%@",[NSThread currentThread]);
    });
    
    
    //第一个参数为要设置优先级的queue,第二个参数是参照物，即将第一个queue的优先级和第二个queue的优先级设置一样。
    //第一个参数如果是系统提供的【主队列】或【全局队列】,则不知道会出现什么情况，因此最好不要设置第一参数为系统提供的队列
    dispatch_set_target_queue(seriaQueue,globalQueue);
    
    NSLog(@"----end-----当前线程---%@",[NSThread currentThread]);
    
}

//dispatch_set_target_queue除了能用来设置队列的优先级之外，还能够创建队列的层次体系，当我们想让不同队列中的任务同步的执行时，我们可以创建一个串行队列，然后将这些队列的target指向新创建的队列即可。
- (void)testTargetQueue2 {
    
    NSLog(@"----start-----当前线程---%@",[NSThread currentThread]);
    
    dispatch_queue_t targetQueue = dispatch_queue_create("com.test.target_queue", DISPATCH_QUEUE_SERIAL);
    
    dispatch_queue_t queue1 = dispatch_queue_create("com.test.queue1", DISPATCH_QUEUE_SERIAL);
    
    dispatch_queue_t queue2 = dispatch_queue_create("com.test.queue2", DISPATCH_QUEUE_CONCURRENT);
    
    dispatch_set_target_queue(queue1, targetQueue);
    
    dispatch_set_target_queue(queue2, targetQueue);
    
    //指定一个异步任务
    dispatch_async(queue1, ^{
        NSLog(@"----执行第一个任务---当前线程%@",[NSThread currentThread]);
        [NSThread sleepForTimeInterval:2];
    });
    
    //指定一个异步任务
    dispatch_async(queue2, ^{
        NSLog(@"----执行第二个任务---当前线程%@",[NSThread currentThread]);
        [NSThread sleepForTimeInterval:2];
    });
    
    //指定一个异步任务
    dispatch_async(queue2, ^{
        NSLog(@"----执行第三个任务---当前线程%@",[NSThread currentThread]);
        [NSThread sleepForTimeInterval:2];
    });
    
    NSLog(@"----end-----当前线程---%@",[NSThread currentThread]);
    
}

#pragma mark - 快速遍历 dispatch_apply
/*
 快速遍历方法
 如果循环里面执行的代码相互独立，可以用dispatch_apply结合并行线程队列，提高效能
 会创建新的线程，并发执行
 size_t：一种用来记录大小的“整形”数据类型，sizeof(xxx)返回的就是size_t 这里相当于当前循环次数
 dispatch_apply和普通for循环一样，执行完才会返回，所以会阻塞进程
 正确使用方法：为了不阻塞主线程，一般把dispatch_apply放在并行队列中调用，然后执行完成后通知主线程
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

#pragma mark - 延时执行 dispatch_after / dispatch_time_t
/*
 不是一定时间后执行相应的任务，而是一定时间后，将执行的操作加入到队列中（队列里面再分配执行的时间）
 严格来说，这个时间并不是绝对准确的，但想要大致延迟执行任务，dispatch_after函数是很有效的。
 */
-(void)test_delay{

  dispatch_time_t time = dispatch_time(DISPATCH_TIME_NOW, NSEC_PER_SEC*2);
  dispatch_queue_t myQueue = dispatch_queue_create("com.myQueue.test",DISPATCH_QUEUE_SERIAL);
  dispatch_after(time, myQueue, ^{
    NSLog(@"执行了子线程代码");
  });
}


#pragma mark - 隔断 dispatch_barrier_async
/*
 必须为dispatch_queue_t创建的并行队列才有效，其他队列相当于dispatch_async
 
 隔断方法：当前面的写入操作全部完成之后，再执行后面的读取任务。
 当然也可以用Dispatch Group和dispatch_set_target_queue,只是比较而言，dispatch_barrier_async会更加顺滑
 */
-(void)test_barrier{

    NSLog(@"----start-----当前线程---%@",[NSThread currentThread]);
    
    dispatch_queue_t queue = dispatch_queue_create("com.test.testQueue", DISPATCH_QUEUE_CONCURRENT);
    
    dispatch_async(queue, ^{
        // 第一个写入任务
        [NSThread sleepForTimeInterval:3];
        
        NSLog(@"----执行第一个写入任务---当前线程%@",[NSThread currentThread]);
        
    });
    dispatch_async(queue, ^{
        // 第二个写入任务
        [NSThread sleepForTimeInterval:1];
        
        NSLog(@"----执行第二个任务---当前线程%@",[NSThread currentThread]);
        
    });
    
    dispatch_barrier_async(queue, ^{
        // 等待处理
        [NSThread sleepForTimeInterval:2];
        
        NSLog(@"----等待前面的任务完成---当前线程%@",[NSThread currentThread]);
        
    });
    
    dispatch_async(queue, ^{
        // 第一个读取任务
        [NSThread sleepForTimeInterval:2];
        
        NSLog(@"----执行第一个读取任务---当前线程%@",[NSThread currentThread]);
        
    });
    dispatch_async(queue, ^{
        // 第二个读取任务
        [NSThread sleepForTimeInterval:2];
        
        NSLog(@"----执行第二个读取任务---当前线程%@",[NSThread currentThread]);
        
    });
    
    NSLog(@"----end-----当前线程---%@",[NSThread currentThread]);
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

#pragma mark - 挂起、恢复 dispatch_suspend / dispatch_resume
//场景：当追加大量处理到Dispatch Queue时，在追加处理的过程中，有时希望不执行已追加的处理。例如演算结果被Block截获时，一些处理会对这个演算结果造成影响。在这种情况下，只要挂起Dispatch Queue即可。当可以执行时再恢复。
//总结:dispatch_suspend，dispatch_resume提供了“挂起、恢复”队列的功能，简单来说，就是可以暂停、恢复队列上的任务。但是这里的“挂起”，并不能保证可以立即停止队列上正在运行的任务，也就是如果挂起之前已经有队列中的任务在进行中，那么该任务依然会被执行完毕
-(void)test_dispatch_suspend{

    NSLog(@"----start-----当前线程---%@",[NSThread currentThread]);
    
    dispatch_queue_t queue = dispatch_queue_create("com.test.testQueue", DISPATCH_QUEUE_SERIAL);
    
    dispatch_async(queue, ^{
        // 执行第一个任务
        [NSThread sleepForTimeInterval:5];
        
        NSLog(@"----执行第一个任务---当前线程%@",[NSThread currentThread]);
        
    });
    
    dispatch_async(queue, ^{
        // 执行第二个任务
        [NSThread sleepForTimeInterval:5];
        
        NSLog(@"----执行第二个任务---当前线程%@",[NSThread currentThread]);
        
    });
    
    dispatch_async(queue, ^{
        // 执行第三个任务
        [NSThread sleepForTimeInterval:5];
        
        NSLog(@"----执行第三个任务---当前线程%@",[NSThread currentThread]);
    });
    
    //此时发现意外情况，挂起队列
    NSLog(@"suspend");
    dispatch_suspend(queue);
    
    //挂起10秒之后，恢复正常
    [NSThread sleepForTimeInterval:10];
    
    //恢复队列
    NSLog(@"resume");
    dispatch_resume(queue);
    
    NSLog(@"----end-----当前线程---%@",[NSThread currentThread]);
}

//在读取较大的文件时,如果将文件分成合适的大小并使用 Global Dispatch Queue 并列读取的话,应该会比一般的读取速度快不少。 在 GCD 当中能实现这一功能的就是 Dispatch I/O 和 Dispatch Data。
-(void)dispatch_IO{
    
    //一般情况下可以这样异步去读取数据
    //    dispatch_async(queue, ^{ /* 读取  0     ～ 8080  字节*/ });
    //    dispatch_async(queue, ^{ /* 读取  8081  ～ 16383 字节*/ });
    //    dispatch_async(queue, ^{ /* 读取  16384 ～ 24575 字节*/ });
    //    dispatch_async(queue, ^{ /* 读取  24576 ～ 32767 字节*/ });
    //    dispatch_async(queue, ^{ /* 读取  32768 ～ 40959 字节*/ });
    //    dispatch_async(queue, ^{ /* 读取  40960 ～ 49191 字节*/ });
    //    dispatch_async(queue, ^{ /* 读取  49192 ～ 57343 字节*/ });
    //    dispatch_async(queue, ^{ /* 读取  57344 ～ 65535 字节*/ });
    
    
    //下面是GCD提供的更加便捷的操作姿势
    
    int fd = 0, fdpair[2];
    dispatch_queue_t pipe_q;
    dispatch_io_t pipe_channel;
    dispatch_semaphore_t sem;
    /* ..... 此处省略若干代码.....*/
    
    // 创建串行队列
    pipe_q = dispatch_queue_create("PipeQ", NULL);
    // 创建 Dispatch I／O
    
    pipe_channel = dispatch_io_create(DISPATCH_IO_STREAM, fd, pipe_q, ^(int err){
        close(fd);
    });
    
    // 该函数设定一次读取的大小（分割大小）
    dispatch_io_set_low_water(pipe_channel, SIZE_MAX);
    
    dispatch_io_read(pipe_channel, 0, SIZE_MAX, pipe_q, ^(bool done, dispatch_data_t pipedata, int err){
        if (err == 0) // err等于0 说明读取无误
        {
            // 读取完“单个文件块”的大小
            size_t len = dispatch_data_get_size(pipedata);
            if (len > 0)
            {
                //                // 定义一个字节数组bytes
                //                const charchar *bytes = NULL;
                //                charchar *encoded;
                //
                //                dispatch_data_t md = dispatch_data_create_map(pipedata, (const voidvoid **)&bytes, &len);
                //                encoded = asl_core_encode_buffer(bytes, len);
                //                asl_set((aslmsg)merged_msg, ASL_KEY_AUX_DATA, encoded);
                //                free(encoded);
                //                _asl_send_message(NULL, merged_msg, -1, NULL);
                //                asl_msg_release(merged_msg);
                //                dispatch_release(md);
            }
        }
        if (done)
        {
            dispatch_semaphore_signal(sem);
        }
    });
}

#pragma mark - action
- (IBAction)btn1Tap:(id)sender {
  self.needStop = YES;
}

@end
