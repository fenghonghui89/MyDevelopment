//
//  MD_GCD_group_VC.m
//  MyDevelopmentTest
//
//  Created by 冯鸿辉 on 16/4/12.
//  Copyright © 2016年 hanyfeng. All rights reserved.
//
/*
 如果某些任务需要更另一些任务完成后才执行，可以使用dispatch_group
 */

#import "MD_GCD_group_VC.h"

@interface MD_GCD_group_VC ()

@end

@implementation MD_GCD_group_VC

- (void)viewDidLoad {
  
  [super viewDidLoad];
  
}

-(void)viewDidAppear:(BOOL)animated{
  
  [super viewDidAppear:animated];
  
  //任务同步执行，效率大大降低
//  [self sync];
//  [self finish];
  
  //任务异步执行，无法确定顺序
//  [self async];
//  [self finish];
  
  //先异步执行一系列任务（1），完成后再执行特殊任务（2），保证效率，但会阻塞线程
//  [self group];
  
  //先异步执行一系列任务（1），完成后再执行特殊任务（2），保证效率，也不会阻塞线程
//  [self group2];
}



#pragma mark - 推导
-(void)sync{
  
  dispatch_queue_t myQueue = dispatch_get_global_queue(0, 0);
  
  for (int i = 0; i < 100; i++) {
    dispatch_sync(myQueue, ^{
      NSLog(@"下载图片:%d",i);
    });
  }
  
}


-(void)async{
  
  dispatch_queue_t myQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
  
  for (int i = 0; i < 100; i++) {
    dispatch_async(myQueue, ^{
      NSLog(@"下载图片:%d",i);
    });
  }
  
}

-(void)finish{
  
  NSLog(@"全部完成");
}

#pragma mark - dispatch_group_notify dispatch_group_wait
-(void)group2{
  
  dispatch_queue_t myQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
  dispatch_group_t myGroup = dispatch_group_create();
  
  for (int i = 0; i < 100; i++) {
    dispatch_group_async(myGroup, myQueue, ^{
      NSLog(@"下载图片:%d",i);
    });
  }
  
  dispatch_group_notify(myGroup, myQueue, ^{
    [self finish];
  });
    
    // 若想执行完上面的任务再走下面这行代码可以加上下面这句代码
    // 等待上面的任务全部完成后，往下继续执行（注意会阻塞当前线程）
//    dispatch_group_wait(group, DISPATCH_TIME_FOREVER);
  
}

#pragma mark * 先请求接口a 接口a返回后再请求接口b
-(void)group3{
//    dispatch_semaphore_t sema = dispatch_semaphore_create(0);
//    dispatch_group_t group = dispatch_group_create();
//    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
//    
//    dispatch_group_async(group, queue, ^{
//        [XTJMBProgressHUD showHUDToView:XTJ_KEY_WINDOW];
//        [NSThread sleepForTimeInterval:3];
//        dispatch_semaphore_signal(sema);
//    });
//    
//    dispatch_group_notify(group, queue, ^{
//        dispatch_semaphore_wait(sema, DISPATCH_TIME_FOREVER);
//        
//        [XTJMBProgressHUD hideHUDForView:XTJ_KEY_WINDOW];
//        BOOL isSuccess = YES;
//        if (isSuccess) {
//            
//            //存储数据
//            XTJMemberModel *member = [XTJGlobalManager sharedInstance].currentUser;
//            member.memberSex = sex;
//            [[XTJMemberStoreManager shareInstance] changeEntityWithMemberId:member.memberId newModel:member];
//            
//            //通知刷新
//            [[NSNotificationCenter defaultCenter] postNotifacation:@""];
//            
//            self.sex = sex;
//            
//            dispatch_async(dispatch_get_main_queue(), ^{
//                [self.navigationController popViewControllerAnimated:YES];
//            });
//            
//        }else{
//            
//        }
//    });

}

#pragma mark - dispatch_group_enter dispatch_group_leave
//dispatch_group_enter 标志着一个任务追加到 group，执行一次，相当于 group 中未执行完毕任务数+1
//dispatch_group_leave 标志着一个任务离开了 group，执行一次，相当于 group 中未执行完毕任务数-1。
//当 group 中未执行完毕任务数为0的时候，才会使dispatch_group_wait解除阻塞，以及执行追加到dispatch_group_notify中的任务。
-(void)dispatch_group_1{
    
    NSLog(@"----start-----当前线程---%@",[NSThread currentThread]);
    
    dispatch_group_t group = dispatch_group_create();
    
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    
    dispatch_group_enter(group);
    dispatch_async(queue, ^{
        // 第一个任务
        [NSThread sleepForTimeInterval:2];
        
        NSLog(@"----执行第一个任务---当前线程%@",[NSThread currentThread]);
        
        dispatch_group_leave(group);
    });
    
    dispatch_group_enter(group);
    dispatch_async(queue, ^{
        // 第二个任务
        [NSThread sleepForTimeInterval:2];
        
        NSLog(@"----执行第二个任务---当前线程%@",[NSThread currentThread]);
        
        dispatch_group_leave(group);
    });
    
    dispatch_group_enter(group);
    dispatch_async(queue, ^{
        // 第三个任务
        [NSThread sleepForTimeInterval:2];
        
        NSLog(@"----执行第三个任务---当前线程%@",[NSThread currentThread]);
        
        dispatch_group_leave(group);
    });
    
    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
        
        [NSThread sleepForTimeInterval:2];
        NSLog(@"----执行最后的汇总任务---当前线程%@",[NSThread currentThread]);
    });
    
    NSLog(@"----end-----当前线程---%@",[NSThread currentThread]);
    
}

-(void)gcd_group_2{
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_group_t group = dispatch_group_create();
            
    dispatch_group_async(group, queue, ^{
        sleep(2);
        NSLog(@"1");
    });
    dispatch_group_async(group, queue, ^{
        sleep(2);
        NSLog(@"2");
    });
    dispatch_group_async(group, queue, ^{
        sleep(2);
        NSLog(@"3");
    });
    dispatch_group_async(group, queue, ^{
        sleep(2);
        NSLog(@"4");
    });
    
    dispatch_group_enter(group);
    dispatch_async(queue, ^{
        sleep(2);
        NSLog(@"6");
        dispatch_group_leave(group);
    });
    
    dispatch_group_enter(group);
    dispatch_async(queue, ^{
        sleep(2);
        NSLog(@"7");
        dispatch_group_leave(group);
    });
    
    dispatch_group_wait(group, DISPATCH_TIME_FOREVER);//会阻塞当前线程
    NSLog(@"123");
    dispatch_group_notify(group, queue, ^{
        NSLog(@"5");
    });
}
#pragma mark - 信号量 dispatch_semaphore_t /dispatch_semaphore_wait /dispatch_semaphore_signal

/*
 信号量>0 就不会阻塞
 dispatch_semaphore_wait注意time的选择
 总结:信号量设置的是2，在当前场景下，同一时间内执行的线程就不会超过2，先执行2个线程，等执行完一个，下一个会开始执行。
 
 当两个线程需要协调特定事件的完成时，为值传递零是有用的。
 传递大于零的值对于管理有限的资源池非常有用，其中池大小等于该值。
 
 从本质意义上讲，信号量与互斥锁是有区别：
 （1）作用域
 信号量：进程间或线程间(linux 仅线程间)
 互斥锁：线程间
 
 （2）上锁时
 信号量：只要信号量的 value 大于0，其他线程就可以 sem_wait 成功，成功后信号量的 value 减一。若 value 值不大于0，则 sem_wait 阻塞，直到 sem_post 释放后 value 值加一。一句话，信号量的 value>=0。
 互斥锁：只要被锁住，其他任何线程都不可以访问被保护的资源。如果没有锁，获得资源成功，否则进行阻塞等待资源可用。一句话，线程互斥锁的 vlaue 可以为负数。
 */
-(void)dispatch_semaphore{
    
    NSLog(@"----start-----当前线程---%@",[NSThread currentThread]);
    
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(2);
    
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    
    //任务1
    dispatch_async(queue, ^{
        
        dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);//用DISPATCH_TIME_NOW会起不到等待效果
        
        NSLog(@"----开始执行第一个任务---当前线程%@",[NSThread currentThread]);
        
        [NSThread sleepForTimeInterval:2];
        
        NSLog(@"----结束执行第一个任务---当前线程%@",[NSThread currentThread]);
        
        dispatch_semaphore_signal(semaphore);
    });
    
    //任务2
    dispatch_async(queue, ^{
        
        dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
        
        NSLog(@"----开始执行第二个任务---当前线程%@",[NSThread currentThread]);
        
        [NSThread sleepForTimeInterval:1];
        
        NSLog(@"----结束执行第二个任务---当前线程%@",[NSThread currentThread]);
        
        dispatch_semaphore_signal(semaphore);
    });
    
    //任务3
    dispatch_async(queue, ^{
        
        dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
        
        NSLog(@"----开始执行第三个任务---当前线程%@",[NSThread currentThread]);
        
        [NSThread sleepForTimeInterval:2];
        
        NSLog(@"----结束执行第三个任务---当前线程%@",[NSThread currentThread]);
        
        dispatch_semaphore_signal(semaphore);
    });
    
    NSLog(@"----end-----当前线程---%@",[NSThread currentThread]);
    
}

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
@end
